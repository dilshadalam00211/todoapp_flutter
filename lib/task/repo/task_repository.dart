import 'package:flutter_todo/task/model/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> getTasks();
  Stream<int?> addTask(Task task);
  Stream<int?> editTask(Task task);
  Stream<int?> deleteTask(int index);
  Stream<int?> updateTask(Task task);
}