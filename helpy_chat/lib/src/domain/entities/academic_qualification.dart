part of 'entities.dart';

class AcademicQualification extends Equatable {
  final String? qualification;
  final String? qualificationDesc;

  const AcademicQualification({this.qualification, this.qualificationDesc});

  @override
  List<Object?> get props => [qualification, qualificationDesc];

  @override
  bool get stringify => true;
}
