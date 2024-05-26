part of 'entities.dart';

class NotificationData extends Equatable {
  final String? title;
  final String? message;
  final String? screenName;
  final int? id;
  final String? expiry;
  final String? currency;
  final String? salary;
  final String? action;
  final String? employerId;

  const NotificationData(
      {this.title,
      this.message,
      this.screenName,
      this.id,
      this.expiry,
      this.currency,
      this.salary,
      this.action,
      this.employerId
      });

  @override
  List<Object?> get props =>
      [title, message, screenName, id, expiry, currency, salary, employerId, action];

  @override
  bool get stringify => true;
}
