import 'package:flutter/material.dart';
import 'package:flutter_todo/common/widget/common_app_bar.dart';
import 'package:flutter_todo/route/route_constant.dart';
import 'package:flutter_todo/route/route_manager.dart';
import 'package:flutter_todo/task/bloc/task_listing_bloc.dart';
import 'package:flutter_todo/task/model/task.dart';
import 'package:flutter_todo/task/state/get_task_list_state.dart';
import 'package:flutter_todo/task/ui/add_task_screen.dart';
import 'package:flutter_todo/task/ui/widget/task_list_item_widget.dart';

class TaskListingScreen extends StatefulWidget {
  const TaskListingScreen({Key? key}) : super(key: key);

  @override
  State<TaskListingScreen> createState() => _TaskListingScreenState();
}

class _TaskListingScreenState extends State<TaskListingScreen> {
  TaskListingBloc taskListingBloc = TaskListingBloc();

  @override
  void initState() {
    super.initState();
    taskListingBloc.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'TODO Task List'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const AddTaskScreen();
          // }));
          AppRouteManager.pushNamed(RouteConstant.addTask);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<GetTaskListState>(
        stream: taskListingBloc.getTaskListState,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state?.isLoading() ?? true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state?.isError() ?? false) {
            return Center(
              child: Text(state?.error?.toString() ?? 'Something went wrong.'),
            );
          }

          final data = state?.data ?? <Task>[];

          if (data.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text('Nothing to see here! Tap on the `+` button add something.'),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return TaskItemWidget(
                taskDescription: data[index].taskDescription ?? '',
                taskName: data[index].taskName ?? '',
                onDelete: () {
                  taskListingBloc.deleteTask(index);
                },
                onDeletePressed: (context) {
                  taskListingBloc.deleteTask(index);
                },
                onChanged: (value) {
                  taskListingBloc.updateTask(index);
                },
                onTap: () {
                  AppRouteManager.pushNamed(
                    RouteConstant.addTask,
                    arguments: {'task': data[index], 'index': index},
                  );
                },
                taskCompleted: data[index].isCompleted ?? false,
                taskTimeStamp: data[index].timestamp,
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    taskListingBloc.dispose();
    super.dispose();
  }
}
