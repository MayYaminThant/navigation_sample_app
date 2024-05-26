part of 'entities.dart';

class Tasks extends Equatable {
  final String? taskType;
  final int? taskDisplayOrder;

  const Tasks({this.taskType, this.taskDisplayOrder});

  @override
  List<Object?> get props => [taskType, taskDisplayOrder];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "task_type": taskType,
        "task_display_order": taskDisplayOrder,
      };
}
