import 'package:flutter_todo/task/bloc/add_task_bloc.dart';
import 'package:flutter_todo/task/bloc/task_listing_bloc.dart';
import 'package:flutter_todo/task/database/db_helper.dart';
import 'package:flutter_todo/task/model/task.dart';

class TaskLocalSource {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Stream<List<Task>> getTasks() {
    List<Task> tasksList = [];
    return Stream.fromFuture(databaseHelper.getTaskList()).map((event) {
      event?.forEach((element) {
        tasksList.add(Task.fromJson(element));
      });
      return tasksList;
    });
  }

  Stream<int?> addTask(Task task) {
    return Stream.fromFuture(
      databaseHelper.insertTask(task),
    );
  }

  Stream<int?> editTask(Task task) {
    return Stream.fromFuture(
      databaseHelper.updateTask(
        Task(
          taskName: task.taskName,
          taskDescription: task.taskDescription,
          timestamp: task.timestamp,
          id: task.id,
          isCompleted: task.isCompleted ?? false,
        ),
      ),
    );
  }

  Stream<int?> deleteTask(int index) {
    return Stream.fromFuture(
        databaseHelper.deleteFromPhotoCollection(TaskListingBloc().taskList.value[index].id));
  }

  Stream<int?> updateTask(Task task) {
    return Stream.fromFuture(databaseHelper.updateTask(task));
  }
}
