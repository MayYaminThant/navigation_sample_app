part of 'models.dart';

class ConnectionDataModel extends ConnectionData {
  const ConnectionDataModel({
    int? employerUserId,
    int? candidateUserId,
    String? createdTime,
    int? connectionID,
    Candidate? candidate,
    Employer? employer,
  }) : super(
          employerUserId: employerUserId,
          candidateUserId: candidateUserId,
          createdTime: createdTime,
          connectionID: connectionID,
          candidate: candidate,
          employer: employer,
        );

  factory ConnectionDataModel.fromJson(Map<dynamic, dynamic> map) {
    return ConnectionDataModel(
      employerUserId: map['employer_user_id'] != null
          ? map['employer_user_id'] as int
          : null,
      candidateUserId: map['candidate_user_id'] != null
          ? map['candidate_user_id'] as int
          : null,
      createdTime: map['chat_connect_creation_datetime'] != null
          ? map['chat_connect_creation_datetime'] as String
          : null,
      connectionID:
          map['chat_connect_id'] != null ? map['chat_connect_id'] as int : null,
      candidate: map['candidate_info'] != null
          ? CandidateModel.fromJson(map['candidate_info'])
          : null,
      employer:
          map['employer_info'] != null ? EmployerModel.fromJson(map['employer_info']) : null,
    );
  }
}
