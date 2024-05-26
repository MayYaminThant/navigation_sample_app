/*
{
  "data": {
    "employer_user_id": 4,
    "candidate_user_id": 195,
    "chat_connect_creation_datetime": "2023-08-03T10:54:05.998116Z",
    "chat_connect_id": 4,
    "candidate": {
      "user_id": 195,
      "first_name": "Adriana",
      "last_name": "Murray",
      "avatar": "default/avatar.png"
    },
    "employer": {
      "user_id": 4,
      "first_name": "Kiarra",
      "last_name": "Stamm",
      "avatar": "default/avatar.png"
    }
  },
  "message": "Chat Request Send."
}
*/
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

