part of 'models.dart';

class ReferFriendModel extends ReferFriend {

  const ReferFriendModel({
    int? userId,
    String? firstName,
    String? lastName,
    String? phoneNumberPVerifiedDatetime,
  }) : super(
    userId: userId,
    firstName: firstName,
    lastName: lastName,
    phoneNumberPVerifiedDatetime: phoneNumberPVerifiedDatetime,
  );

  factory ReferFriendModel.fromJson(Map<String, dynamic> map) {
    return ReferFriendModel(
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      phoneNumberPVerifiedDatetime: map['phone_number_p_verified_datetime'] != null ? map['phone_number_p_verified_datetime'] as String : null,
    );
  }

  
}
