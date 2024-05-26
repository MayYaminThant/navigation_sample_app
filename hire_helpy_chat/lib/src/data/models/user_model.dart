part of 'models.dart';

class UserModel extends User {
  UserModel({
    int? id,
    int? mentorId,
    String? loginName,
    String? firstName,
     String? lastName,
    int? countryCallingCode,
    int? phoneNumber,
    String? phoneNumberVerifiedDateTime,
    String? email,
    String? emailVerifiedDateTime,
    String? fbUserId,
    String? googleUserId,
    String? appleUserId,
    String? gender,
    String? nationality,
    String? religion,
    String? avatar,
    String? token,
    int? pCoin,
    int? pVoucher,
    String? shareableLink,
    Employer? employer,
    String? countryOfResidence
  }) : super(
          id: id,
          mentorId: mentorId,
          loginName: loginName,
          firstName: firstName,
          lastName: lastName,
          countryCallingCode: countryCallingCode,
          phoneNumber: phoneNumber,
          phoneNumberVerifiedDateTime: phoneNumberVerifiedDateTime,
          email: email,
          emailVerifiedDateTime: emailVerifiedDateTime,
          fbUserId: fbUserId,
          googleUserId: googleUserId,
          appleUserId: appleUserId,
          gender: gender,
          nationality: nationality,
          religion: religion,
          avatar: avatar,
          pCoin: pCoin,
          pVoucher: pVoucher,
          token: token,
          shareableLink: shareableLink,
          employer: employer,
          countryOfResidence: countryOfResidence
        );

  factory UserModel.fromJson(Map<dynamic, dynamic> map) {
  return UserModel(
    id: map['user_id'] != null ? map['user_id'] as int : null,
    mentorId: map['mentor_id'] != null ? map['mentor_id'] as int : null,
    loginName: map['login_name'] != null ? map['login_name'] as String : null,
    firstName: map['first_name'] != null ? map['first_name'] as String : null,
    lastName: map['last_name'] != null ? map['last_name'] as String : null,
    countryCallingCode: map['country_calling_code'] != null ? int.parse(map['country_calling_code'].toString()) : null,
    phoneNumber: map['phone_number'] != null ? int.parse(map['phone_number'].toString()): null,
    phoneNumberVerifiedDateTime: map['phone_number_p_verified_datetime'] != null ? map['phone_number_p_verified_datetime'] as String : null,
    email: map['email'] != null ? map['email'] as String : null,
    emailVerifiedDateTime: map['email_p_verified_datetime'] != null ? map['email_p_verified_datetime'] as String : null,
    fbUserId: map['fb_userid'] != null ? map['fb_userid'] as String : null,
    googleUserId: map['google_useruid'] != null ? map['google_useruid'] as String : null,
    appleUserId: map['apple_userid'] != null ? map['apple_userid'] as String : null,
    gender: map['gender'] != null ? map['gender'] as String : null,
    nationality: map['nationality'] != null ? map['nationality'] as String : null,
    religion: map['religion'] != null ? map['religion'] as String : null,
    avatar: map['avatar_s3_filepath'] != null ? map['avatar_s3_filepath'] as String : null,
    pCoin: map['p_coin'] != null ? map['p_coin'] as int : null,
    pVoucher: map['p_voucher'] != null ? map['p_voucher'] as int : null,
    token : map['token'] != null ? map['token'] as String : null,
    shareableLink: map['qr_code_shareable_link'] != null ? map['qr_code_shareable_link'] as String: null,
    employer: map[DBUtils.employerTableName] != null ? EmployerModel.fromJson(map[DBUtils.employerTableName]) : null,
    countryOfResidence: map['country_of_residence'] != null
          ? map['country_of_residence'] as String
          : null,
  );
}


}
