part of 'models.dart';

class NotificationDataModel extends NotificationData {
  const NotificationDataModel(
      {String? title,
      String? message,
      String? screenName,
      int? id,
      String? expiry,
      String? currency,
      String? salary,
      String? employerId,
      String? action})
      : super(
            title: title,
            message: message,
            screenName: screenName,
            id: id,
            expiry: expiry,
            currency: currency,
            salary: salary,
            action: action,
            employerId: employerId);

  factory NotificationDataModel.fromJson(Map<String, dynamic> map) {
    return NotificationDataModel(
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      screenName: map['data'] != null && map['data']['screen'] != null
          ? map['data']['screen'] as String
          : null,
      id: map['data']['id'] != null ? int.parse(map['data']['id'].toString()) : null,
      expiry: map['data'] != null && map['data']['expiry'] != null
          ? map['data']['expiry'].toString()
          : null,
      currency: map['data'] != null && map['data']['currency'] != null
          ? map['data']['currency'].toString()
          : null,
      salary: map['data'] != null && map['data']['salary'] != null
          ? map['data']['salary'].toString()
          : null,
      action: map['data'] != null && map['data']['action'] != null
          ? map['data']['action'].toString()
          : null,
      employerId: map['data'] != null && map['data']['employer_id'] != null
          ? map['data']['employer_id'].toString()
          : null,
    );
  }
}
