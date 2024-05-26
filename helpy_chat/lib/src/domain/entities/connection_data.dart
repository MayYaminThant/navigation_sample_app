
part of 'entities.dart';

class ConnectionData extends Equatable {
  final int? employerUserId;
  final int? candidateUserId;
  final String? createdTime;
  final int? connectionID;
  final Candidate? candidate;
  final Employer? employer;

  const ConnectionData({this.employerUserId, this.candidateUserId, this.createdTime, this.connectionID, this.candidate, this.employer,});

  @override
  List<Object?> get props => [employerUserId, candidateUserId, createdTime, connectionID, candidate, employer];

  @override
  bool get stringify => true;
}

