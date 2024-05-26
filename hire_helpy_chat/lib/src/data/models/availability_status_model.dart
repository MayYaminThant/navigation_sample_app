part of 'models.dart';

class AvailabilityStatusModel extends AvailabilityStatus {
  const AvailabilityStatusModel({
    String? availabilityStatusType,
    String? colorCode,
  }) : super(
    availabilityStatusType: availabilityStatusType,
    colorCode: colorCode,
    );

  factory AvailabilityStatusModel.fromJson(Map<dynamic, dynamic> map) {
    return AvailabilityStatusModel(
      availabilityStatusType: map['availability_status'] != null ? map['availability_status'] as String: null,
      colorCode: map['availability_status_color'] != null ? map['availability_status_color'] as String: null,
    );
  }

}
