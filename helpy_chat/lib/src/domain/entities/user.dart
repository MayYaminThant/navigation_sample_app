part of 'entities.dart';

// ignore: must_be_immutable
class User extends Equatable {
  final int? id;
  final int? mentorId;
  final String? loginName;
  final String? firstName;
  final String? lastName;
  final int? countryCallingCode;
  final int? phoneNumber;
  final String? phoneNumberVerifiedDateTime;
  final String? email;
  final String? emailVerifiedDateTime;
  final String? fbUserId;
  final String? googleUserId;
  final String? appleUserId;
  final String? gender;
  final String? nationality;
  final String? religion;
  final String? avatar;
  late String? token;
  final int? pCoin;
  final int? pVoucher;
  final String? shareableLink;
  final Candidate? candidate;
  final String? countryOfResidence;
  User(
      {this.id,
      this.mentorId,
      this.loginName,
      this.firstName,
      this.lastName,
      this.countryCallingCode,
      this.phoneNumber,
      this.phoneNumberVerifiedDateTime,
      this.email,
      this.emailVerifiedDateTime,
      this.fbUserId,
      this.googleUserId,
      this.appleUserId,
      this.gender,
      this.nationality,
      this.religion,
      this.avatar,
      this.pCoin,
      this.pVoucher,
      this.token,
      this.shareableLink,
      this.candidate,
      this.countryOfResidence});

  @override
  List<Object?> get props => [
        id,
        mentorId,
        loginName,
        firstName,
        lastName,
        countryCallingCode,
        phoneNumber,
        phoneNumberVerifiedDateTime,
        email,
        emailVerifiedDateTime,
        fbUserId,
        googleUserId,
        appleUserId,
        gender,
        nationality,
        religion,
        avatar,
        pCoin,
        pVoucher,
        token,
        shareableLink,
        candidate,
        countryOfResidence
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": id,
        "mentor_id": mentorId,
        "login_name": loginName,
        "first_name": firstName,
        "last_name": lastName,
        "country_calling_code": countryCallingCode,
        "phone_number": phoneNumber,
        "phone_number_p_verified_datetime": phoneNumberVerifiedDateTime,
        "email": email,
        "email_p_verified_datetime": emailVerifiedDateTime,
        "fb_userid": fbUserId,
        "google_useruid": googleUserId,
        "apple_userid": appleUserId,
        "gender": gender,
        "nationality": nationality,
        "religion": religion,
        "avatar_s3_filepath": avatar,
        "p_coin": pCoin,
        "p_voucher": pVoucher,
        "token": token,
        "qr_code_shareable_link": shareableLink,
        "candidate": candidate,
        "country_of_residence": countryOfResidence,
      };
}
