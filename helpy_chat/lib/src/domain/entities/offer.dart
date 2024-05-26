part of 'entities.dart';

class Offer extends Equatable {
  final int? userId;
  final String? salary;
  final int? restDay;

  const Offer({this.userId, this.salary, this.restDay});

  @override
  List<Object?> get props => [userId, salary, restDay];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "salary": salary,
        "restDay": restDay
      };
}
