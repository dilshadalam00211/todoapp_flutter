import 'package:flutter_todo/base/base_ui_state.dart';
import 'package:flutter_todo/task/model/task.dart';

class GetTaskListState extends BaseUiState<List<Task>> {
  GetTaskListState.loading() : super.loading();

  GetTaskListState.completed(List<Task> data) : super.completed(data: data);

  GetTaskListState.error(dynamic error) : super.error(error);
}
