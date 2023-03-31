import 'package:flutter_todo/base/base_ui_state.dart';

class DeleteTaskState extends BaseUiState<int?> {
  DeleteTaskState.loading() : super.loading();

  DeleteTaskState.completed(int? data) : super.completed(data: data);

  DeleteTaskState.error(dynamic error) : super.error(error);
}