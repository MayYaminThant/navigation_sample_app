part of 'models.dart';

class BidDataModel extends BidData {
  const BidDataModel({
    int? userId,
    String? salary,
    int? restDay,
  }) : super(userId: userId, salary: salary, restDay: restDay);

  factory BidDataModel.fromJson(Map<dynamic, dynamic> map) {
    return BidDataModel(
        userId: map['user_id'] != null ? map['user_id'] as int : null,
        salary: map['salary'] != null ? "${map['salary']}" : null,
        restDay: map['restDay'] != null ? map['restDay'] as int : null);
  }
}
