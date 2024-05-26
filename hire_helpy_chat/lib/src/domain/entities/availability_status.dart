part of 'entities.dart';

class AvailabilityStatus extends Equatable {
  final String? availabilityStatusType;
  final String? colorCode;

  const AvailabilityStatus({this.availabilityStatusType, this.colorCode});

  @override
  List<Object?> get props => [availabilityStatusType, colorCode];

  @override
  bool get stringify => true;
}
