class Task {
  int? id;
  DateTime? timestamp;
  String? taskName;
  String? taskDescription;
  bool? isCompleted;

  Task({
    this.id,
    required this.taskName,
    required this.taskDescription,
    required this.timestamp,
    this.isCompleted = false
  });

  Task.fromJson(Map<String, dynamic> json) {
    timestamp = DateTime.tryParse(json['timeStamp']);
    taskName = json["taskName"];
    taskDescription = json['taskDescription'];
    id = json["UUID"];
    isCompleted = json['isCompleted'] == 0 ? false : true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskName'] = taskName;
    data['taskDescription'] = taskDescription;
    data['timeStamp'] = timestamp.toString();
    data['isCompleted'] = isCompleted == true ? 1 : 0;
    return data;
  }
}
