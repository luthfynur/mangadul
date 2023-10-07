import 'package:mangadul/data/data_sources/remote/mangadex_data_source.dart';
import 'package:mangadul/domain/entities/response_data_entity.dart';
import 'package:mangadul/domain/repositories/mangadex_repository.dart';

class MangaDexRepositoryImpl implements MangaDexRepository {
  final MangaDexDataSource _dataSource = MangaDexDataSource();

  @override
  Future<ResponseData> fetchManga(
      int limit,
      int offset,
      String title,
      String sort,
      List<dynamic> tags,
      List<dynamic> contentRatings,
      List<dynamic> statuses) async {
    var response = await _dataSource.fetchManga(
        limit, offset, title, sort, tags, contentRatings, statuses);

    return ResponseData(
        success: response["success"],
        data: response["data"],
        total: response["total"]);
  }

  @override
  Future<ResponseData> fetchTags() async {
    var response = await _dataSource.fetchTags();

    return ResponseData(
        success: response["success"],
        data: response["data"],
        total: response["data"].length);
  }
}
