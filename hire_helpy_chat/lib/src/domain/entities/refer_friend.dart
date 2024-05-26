part of 'entities.dart';

class ReferFriend extends Equatable {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumberPVerifiedDatetime;

  const ReferFriend({
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNumberPVerifiedDatetime,
  });

  @override
  List<Object?> get props =>
      [userId, firstName, lastName, phoneNumberPVerifiedDatetime];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() => {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumberPVerifiedDatetime': phoneNumberPVerifiedDatetime,
    };
}
