import 'package:flutter_bloc/flutter_bloc.dart';

class BookFilterTagCubit extends Cubit<List<String>> {
  BookFilterTagCubit() : super([]);

  addTag(String status) {
    emit([...state, status]);
  }

  void removeTag(String status) {
    emit([...state.where((s) => s != status)]);
  }

  void removeTags(List<dynamic> tags) {
    emit([...state.where((s) => !tags.contains(s))]);
  }

  void addTags(List<dynamic> tags, List<dynamic> s) {
    emit([
      ...state,
      ...tags
          .map((e) => e.id)
          .toList()
          .where((element) => s.contains(element))
          .toList()
    ]);
  }

  clear() {
    emit([]);
  }
}
