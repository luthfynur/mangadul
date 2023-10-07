import 'package:flutter_bloc/flutter_bloc.dart';

class BookFilterStatusCubit extends Cubit<List<String>> {
  BookFilterStatusCubit() : super([]);

  List<dynamic> statuses = [
    {"name": "Ongoing", "value": "ongoing"},
    {"name": "Completed", "value": "completed"},
    {"name": "Hiatus", "value": "hiatus"},
    {"name": "Cancelled", "value": "cancelled"}
  ];

  addStatus(String status) {
    emit([...state, status]);
  }

  void removeStatus(String status) {
    emit([...state.where((s) => s != status)]);
  }

  void removeStatuses(List<dynamic> statuses) {
    emit([...state.where((s) => !statuses.contains(s))]);
  }

  void addStatuses(List<dynamic> s) {
    emit([
      ...state,
      ...statuses
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
