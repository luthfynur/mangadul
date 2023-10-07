import 'dart:convert';
import 'package:mangadul/core/constants/url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:mangadul/domain/entities/book_entity.dart';
import 'package:mangadul/domain/entities/book_tag.dart';

class MangaDexDataSource {
  final String _baseUrl = UrlConstants.mangadexBaseUrl;
  final String _uploadUrl = UrlConstants.mangadexUploadUrl;
  final String _contentRatingParams =
      "contentRating[]=safe&contentRating[]=suggestive&contentRating[]=erotica&contentRating[]=pornographic";

  Future<String> getCoverImage(String coverId) async {
    try {
      Uri url = Uri.parse("$_baseUrl/cover/$coverId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["data"];
        var mangaId = (data["relationships"] as List<dynamic>)
            .where((e) => e["type"] == "manga")
            .first["id"];
        var fileName = data["attributes"]["fileName"];
        return "$_uploadUrl/covers/$mangaId/$fileName";
      }
      return "";
    } catch (err) {
      return "";
    }
  }

  Future<Map<String, dynamic>> fetchManga(
      int limit,
      int offset,
      String title,
      String sort,
      List<dynamic> tags,
      List<dynamic> contentRatings,
      List<dynamic> statuses) async {
    try {
      String sortBy = sort.split(".").first;
      String sortOrder = sort.split(".").last;
      String origUrl =
          "$_baseUrl/manga?limit=$limit&offset=$offset&order[$sortBy]=$sortOrder";

      // filter tag
      if (tags.isNotEmpty) {
        for (var tag in tags) {
          origUrl += "&includedTags[]=$tag";
        }
      }

      // filter contentRating
      if (contentRatings.isNotEmpty) {
        for (var rating in contentRatings) {
          origUrl += "&contentRating[]=$rating";
        }
      } else {
        origUrl += "&$_contentRatingParams";
      }

      // filter status
      if (statuses.isNotEmpty) {
        for (var status in statuses) {
          origUrl += "&status[]=$status";
        }
      }

      // filter title
      if (title != "") {
        origUrl += "&title=$title";
      }

      Uri url = Uri.parse(origUrl);
      var response = await http.get(url);
      var total = 0;

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["data"];
        total = jsonDecode(response.body)["total"];

        var coverIds = data
            .map((e) => (e["relationships"] as List<dynamic>)
                .where((e) => e["type"] == "cover_art")
                .first)
            .toList();

        List<Book> books = [];

        for (var i = 0; i < data.length; i++) {
          var href =
              "$_baseUrl/manga/${data[i]["id"]}/feed?$_contentRatingParams&includeEmptyPages=0&includeExternalUrl=0&translatedLanguage[]=en&translatedLanguage[]=id";
          var img = await getCoverImage(coverIds[i]["id"]);
          var id = data[i]["id"];
          var name = data[i]["attributes"]["title"]
              .toString()
              .split("{")[1]
              .split(":")[1]
              .split("}")[0]
              .trim();
          var status = data[i]["attributes"]["status"] ?? "";
          var contentRating = data[i]["attributes"]["contentRating"] ?? "";
          var tags = data[i]["attributes"]["tags"].isNotEmpty
              ? data[i]["attributes"]["tags"]
                  .map(
                    (e) => {
                      "name": e["attributes"]["name"]["en"] ?? "",
                      "id": e["id"] ?? ""
                    },
                  )
                  .toList()
              : [];
          var description = data[i]["attributes"]["description"]["en"] ?? "";

          books.add(Book(
              id: id,
              href: href,
              image: img,
              title: name,
              description: description,
              status: status,
              contentRating: contentRating,
              tags: tags));
        }

        return {"success": true, "data": books, "total": total};
      } else {
        return {"success": false, "data": [], "total": 0};
      }
    } catch (err) {
      return {"success": false, "data": [], "total": 0};
    }
  }

  Future<Map<String, dynamic>> fetchTags() async {
    try {
      String origUrl = "$_baseUrl/manga/tag";
      Uri url = Uri.parse(origUrl);

      var headers = {
        'User-Agent':
            "Mozilla/5.0 (Series40; Nokia5220XpressMusic/04; Profile/MIDP-2.1 Configuration/CLDC-1.1) Gecko/20100401 S40OviBrowser/1.0.0.11.8"
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["data"];
        return {
          "success": true,
          "data": data
              .map((e) => BookTag(
                  id: e["id"],
                  name: e["attributes"]["name"]["en"] ?? "",
                  group: e["attributes"]["group"] ?? ""))
              .toList()
        };
      }

      return {"success": false, "data": []};
    } catch (err) {
      return {"success": false, "data": []};
    }
  }
}
