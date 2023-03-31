import 'package:flutter_todo/base/base_ui_state.dart';

class AddTaskState extends BaseUiState<int> {
  AddTaskState.loading() : super.loading();

  AddTaskState.completed(int data) : super.completed(data: data);

  AddTaskState.error(dynamic error) : super.error(error);
}
