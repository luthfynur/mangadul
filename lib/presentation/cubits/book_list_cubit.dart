import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangadul/data/repositories/mangadex_repository.dart';
import 'package:mangadul/domain/entities/response_data_entity.dart';
import 'package:mangadul/domain/repositories/mangadex_repository.dart';
import 'package:mangadul/presentation/cubits/loading_cubit.dart';

class BookListCubit extends Cubit<List<dynamic>> {
  BookListCubit() : super([]) {
    resetProperties(false);
    fetchManga(false, null);
    fetchTags();
  }
  final MangaDexRepository _repository = MangaDexRepositoryImpl();

  // properties
  bool isLoading = false;
  bool isLoadingMore = false;
  int page = 1;
  int total = 0;
  String sortBy = "latestUploadedChapter.desc";
  String searchKeyword = "";
  List<dynamic> tags = [];
  List<dynamic> includedTags = [];
  List<dynamic> includedCR = [];
  List<dynamic> includedStatuses = [];
  List<dynamic> appliedFilters = [];

  void resetProperties(bool emitData) {
    page = 1;
    total = 0;
    sortBy = "latestUploadedChapter.desc";
    searchKeyword = "";
    includedStatuses.clear();
    includedCR.clear();
    includedTags.clear();
    appliedFilters.clear();
    if (emitData) emit([]);
  }

  List<dynamic> unusedFilters() {
    List<dynamic> unappliedFilters = [];
    for (var filter in includedStatuses) {
      if (!appliedFilters.contains(filter)) {
        unappliedFilters.add(filter);
      }
    }

    for (var filter in includedCR) {
      if (!appliedFilters.contains(filter)) {
        unappliedFilters.add(filter);
      }
    }

    for (var filter in includedTags) {
      if (!appliedFilters.contains(filter)) {
        unappliedFilters.add(filter);
      }
    }

    includedStatuses
        .removeWhere((element) => unappliedFilters.contains(element));
    includedCR.removeWhere((element) => unappliedFilters.contains(element));
    includedTags.removeWhere((element) => unappliedFilters.contains(element));

    return unappliedFilters;
  }

  void syncAppliedFilters() {
    List<String> statuses = ["ongoing", "completed", "hiatus", "cancelled"];
    List<String> contentRatings = [
      "safe",
      "suggestive",
      "erotica",
      "pornographic"
    ];

    for (var filter in appliedFilters) {
      if (statuses.contains(filter) && !includedStatuses.contains(filter)) {
        includedStatuses.add(filter);
      }

      if (contentRatings.contains(filter) && !includedCR.contains(filter)) {
        includedCR.add(filter);
      }

      if (![...contentRatings, ...statuses].contains(filter) &&
          !includedTags.contains(filter)) {
        includedTags.add(filter);
      }
    }
  }

  Future<void> fetchManga(bool isLoadMore, LoadingCubit? loadingCubit) async {
    if (isLoadMore) {
      page++;
      isLoadingMore = true;
      if (loadingCubit != null) {
        loadingCubit.setLoading(true);
      }
    } else {
      emit([]);
      isLoading = true;
    }

    appliedFilters = [...includedTags, ...includedCR, ...includedStatuses];

    ResponseData response = await _repository.fetchManga(10, (page - 1) * 10,
        searchKeyword, sortBy, includedTags, includedCR, includedStatuses);

    total = response.total;

    List<dynamic> curState = [...state, ...response.data];
    emit(curState);
    isLoading = false;
    isLoadingMore = false;
    if (loadingCubit != null) {
      loadingCubit.setLoading(false);
    }
  }

  Future<void> fetchTags() async {
    ResponseData response = await _repository.fetchTags();

    if (response.success) {
      tags = response.data;
      tags.sort((a, b) => a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase()));
    }
  }
}
