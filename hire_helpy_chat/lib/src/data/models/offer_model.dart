part of 'models.dart';

class OfferModel extends Offer {
  const OfferModel({
    int? userId,
    String? salary,
    int? restDay,
  }) : super(
    userId: userId,
    salary: salary,
    restDay: restDay
        );

  factory OfferModel.fromJson(Map<dynamic, dynamic> map) {
    return OfferModel(
      userId: map['user_id'] != null ? map['user_id'] as int: null,
      // ignore: prefer_null_aware_operators
      salary: map['salary'] != null ? map['salary'].toString(): null,
      restDay: map['restDay'] != null ? map['restDay'] as int: null
    );
  }

}
