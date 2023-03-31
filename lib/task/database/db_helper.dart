import 'dart:async';
import 'dart:io';

import 'package:flutter_todo/task/model/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  static const String taskTable = 'task_table';

  Database? taskDataBase;

  final String _taskName = 'taskName';
  final String _taskTimeStamp = 'timeStamp';
  final String _id = 'UUID';
  final String _taskDescription = 'taskDescription';
  final String isCompletedTask = 'isCompleted';

  Future<Database?> get getTaskDB async {
    taskDataBase ??= await initDatabase();
    return taskDataBase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}tasks.db';
    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $taskTable($_id INTEGER PRIMARY KEY, $_taskName TEXT,$_taskDescription TEXT,$_taskTimeStamp TEXT,$isCompletedTask INTEGER)');
  }

  Future<List<Map<String, dynamic>>?> getTaskList() async {
    Database? db = await getTaskDB;
    var result = await db?.rawQuery('SELECT * FROM $taskTable order by $_id DESC');
    return result;
  }

  Future<int?> insertTask(Task task) async {
    Database? db = await getTaskDB;
    var result = await db?.insert(taskTable, task.toJson());
    return result;
  }

  Future<int?> updateTask(Task task) async {
    var db = await getTaskDB;
    var result = await db?.update(taskTable, task.toJson(), where: '$_id = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int?> deleteFromPhotoCollection(int? deleteId) async {
    var db = await getTaskDB;
    var result = await db?.rawDelete('DELETE FROM $taskTable WHERE $_id = $deleteId');
    return result;
  }

  Future<int?> getCount() async {
    var db = await getTaskDB;
    List<Map<String, Object?>>? x = await db?.rawQuery('SELECT COUNT (*) from $taskTable');
    var result = Sqflite.firstIntValue(x ?? []);
    print(result);
    print(await db?.query(taskTable));
    return result;
  }
}
