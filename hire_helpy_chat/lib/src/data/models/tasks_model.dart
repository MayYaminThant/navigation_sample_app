part of 'models.dart';

class TasksModel extends Tasks {
  const TasksModel({
    String? taskType,
    int? taskDisplayOrder,
  }) : super(
    taskType: taskType,
    taskDisplayOrder: taskDisplayOrder
        );

  factory TasksModel.fromJson(Map<dynamic, dynamic> map) {
    return TasksModel(
      taskType: map['task_type'] != null ? map['task_type'] as String: null,
      taskDisplayOrder: map['task_display_order'] != null ? map['task_display_order'] as int: null,
    );
  }

}
