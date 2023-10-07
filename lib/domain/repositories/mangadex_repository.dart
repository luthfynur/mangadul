import 'package:mangadul/domain/entities/response_data_entity.dart';

abstract class MangaDexRepository {
  Future<ResponseData> fetchManga(
      int limit,
      int offset,
      String title,
      String sort,
      List<dynamic> tags,
      List<dynamic> contentRatings,
      List<dynamic> statuses);
  Future<ResponseData> fetchTags();
}
