part of 'entities.dart';

class Tasks extends Equatable {
  final String? taskType;
  final String? taskDesc;

  const Tasks({this.taskType, this.taskDesc});

  @override
  List<Object?> get props => [taskType, taskDesc];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "task_type": taskType,
        "task_desc": taskDesc,
      };
}
