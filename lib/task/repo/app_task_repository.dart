import 'package:flutter_todo/task/model/task.dart';
import 'package:flutter_todo/task/repo/task_repository.dart';
import 'package:flutter_todo/task/source/task_local_source.dart';

class AppTaskRepository extends TaskRepository {
  final TaskLocalSource _taskLocalSource = TaskLocalSource();

  @override
  Stream<int?> addTask(Task task) {
    return _taskLocalSource.addTask(task);
  }

  @override
  Stream<int?> deleteTask(int index) {
    return _taskLocalSource.deleteTask(index);
  }

  @override
  Stream<int?> editTask(Task task) {
    return _taskLocalSource.editTask(task);
  }

  @override
  Stream<List<Task>> getTasks() {
    return _taskLocalSource.getTasks();
  }

  @override
  Stream<int?> updateTask(Task task) {
    return _taskLocalSource.updateTask(task);
  }
}
