import 'package:flutter_todo/base/base_ui_state.dart';

class EditTaskState extends BaseUiState<int?> {
  EditTaskState.loading() : super.loading();

  EditTaskState.completed(int? data) : super.completed(data: data);

  EditTaskState.error(dynamic error) : super.error(error);
}