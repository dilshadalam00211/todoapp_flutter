import 'package:flutter/material.dart';
import 'package:flutter_todo/base/base_bloc.dart';
import 'package:flutter_todo/task/model/task.dart';
import 'package:flutter_todo/task/repo/app_task_repository.dart';
import 'package:flutter_todo/task/state/delete_task_state.dart';
import 'package:flutter_todo/task/state/edit_task_state.dart';
import 'package:flutter_todo/task/state/get_task_list_state.dart';
import 'package:rxdart/rxdart.dart';

class TaskListingBloc extends BaseBloc {
  static final TaskListingBloc _singleton = TaskListingBloc._internal();

  factory TaskListingBloc() {
    return _singleton;
  }

  TaskListingBloc._internal();

  final getTaskListState = BehaviorSubject<GetTaskListState>();
  final editTaskState = BehaviorSubject<EditTaskState>();
  final deleteTaskState = BehaviorSubject<DeleteTaskState>();
  final taskList = BehaviorSubject<List<Task>>.seeded([]);
  List<Task> tempTaskList = [];

  void getTaskList() {
    subscriptions.add(
      AppTaskRepository()
          .getTasks()
          .map((event) => GetTaskListState.completed(event))
          .startWith(GetTaskListState.loading())
          .listen(
        (state) {
          if (state.isCompleted()) {
            taskList.add(state.data ?? []);
          }
          debugPrint('///// State : $state');
          getTaskListState.add(state);
        },
        onError: (error) {
          debugPrint('// Error is $error');
        },
      ),
    );
  }

  void updateTask(int index) {
    Task task = TaskListingBloc().taskList.value[index];
    subscriptions.add(
      AppTaskRepository()
          .editTask(Task(
            taskName: task.taskName,
            taskDescription: task.taskDescription,
            timestamp: task.timestamp,
            id: task.id,
            isCompleted: !(task.isCompleted ?? false),
          ))
          .map((event) => EditTaskState.completed(event))
          .startWith(EditTaskState.loading())
          .listen(
        (state) {
          if (state.isCompleted()) {}
          debugPrint('///// State : $state');
          editTaskState.add(state);
          if (editTaskState.value.isCompleted()) {
            getTaskList();
          }
        },
        onError: (error) {
          debugPrint('// Error is $error');
        },
      ),
    );
  }

  void deleteTask(int index) {
    subscriptions.add(
      AppTaskRepository()
          .deleteTask(index)
          .map((event) => DeleteTaskState.completed(event))
          .startWith(DeleteTaskState.loading())
          .listen(
        (state) {
          if (state.isCompleted()) {
            debugPrint('task is completed');
          }
          debugPrint('///// State : $state');
          deleteTaskState.add(state);
          if (deleteTaskState.value.isCompleted()) {
            getTaskList();
          }
        },
        onError: (error) {
          debugPrint('// Error is $error');
        },
      ),
    );
  }
}
