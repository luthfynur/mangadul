import 'package:flutter_bloc/flutter_bloc.dart';

class BookFilterCRCubit extends Cubit<List<String>> {
  BookFilterCRCubit() : super([]);

  List<dynamic> contentRatings = [
    {"name": "Safe", "value": "safe"},
    {"name": "Suggestive", "value": "suggestive"},
    {"name": "Erotica", "value": "erotica"},
    {"name": "Pornographic", "value": "pornographic"}
  ];

  addCR(String status) {
    emit([...state, status]);
  }

  void removeCR(String status) {
    emit([...state.where((s) => s != status)]);
  }

  void removeCRs(List<dynamic> statuses) {
    emit([...state.where((s) => !statuses.contains(s))]);
  }

  void addCrs(List<dynamic> s) {
    emit([
      ...state,
      ...contentRatings
          .map((e) => e["value"])
          .toList()
          .where((element) => s.contains(element))
          .toList()
    ]);
  }

  clear() {
    emit([]);
  }
}
