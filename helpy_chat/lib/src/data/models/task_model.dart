part of 'models.dart';

class TasksModel extends Tasks {
  const TasksModel({
    String? taskType,
    String? taskDesc,
  }) : super(
    taskType: taskType,
    taskDesc: taskDesc
        );

  factory TasksModel.fromJson(Map<dynamic, dynamic> map) {
    return TasksModel(
      taskType: map['task_type'] != null ? map['task_type'] as String: null,
      taskDesc: map['task_desc'] != null ? map['task_desc'] as String: null,
    );
  }

}
