import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_todo/base/base_bloc.dart';
import 'package:flutter_todo/route/route_constant.dart';
import 'package:flutter_todo/route/route_manager.dart';
import 'package:flutter_todo/task/model/task.dart';
import 'package:flutter_todo/task/repo/app_task_repository.dart';
import 'package:flutter_todo/task/state/add_task_state.dart';
import 'package:rxdart/rxdart.dart';

class AddTaskBloc extends BaseBloc {
  final addTaskState = BehaviorSubject<AddTaskState?>();
  final taskName = BehaviorSubject<String>();
  final taskDescription = BehaviorSubject<String>();
  final taskDueDate = BehaviorSubject<DateTime>();
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDueDateController = TextEditingController();

  void addTask() {
    subscriptions.add(
      AppTaskRepository()
          .addTask(
            Task(
              taskName: taskName.value,
              taskDescription: taskDescription.value,
              timestamp: taskDueDate.value,
            ),
          )
          .map((event) => AddTaskState.completed(event ?? 3))
          .startWith(AddTaskState.loading())
          .listen(
        (state) {
          if (state.isCompleted()) {
            AppRouteManager.pushNamedAndRemoveUntil(RouteConstant.home, (route) => false);
          }
          debugPrint('///// State : $state');
          addTaskState.add(state);
        },
        onError: (error) {
          debugPrint('// Error is $error');
        },
      ),
    );
  }

  void updateTask(Task task) {
    subscriptions.add(
      AppTaskRepository()
          .updateTask(task)
          .map((event) => AddTaskState.completed(event ?? 3))
          .startWith(AddTaskState.loading())
          .listen(
        (state) {
          if (state.isCompleted()) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AppRouteManager.pushNamedAndRemoveUntil(RouteConstant.home, (route) => false);
            });
          }
          debugPrint('///// State : $state');
          addTaskState.add(state);
        },
        onError: (error) {
          debugPrint('// Error is $error');
        },
      ),
    );
  }
}
