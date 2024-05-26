/*
"work_permit": {
                "candidate_work_permit_id": 1,
                "user_id": 10001,
                "work_permit_issue_country_name": "Singapore",
                "work_permit_fin_number_hash": "APA91bGdPCSRRzVbu5bXaLGVodwCdVbSFmv_flG801LuY01MLEr_6lwoLCcHFtJcyJxbSFM7xgypZZO78iW8wEF4Baamt3AxbQfsgJSBpq2xMFyv8KqpvhAYIMxdBSF4BBEUL32kry1C",
                "work_permit_dob_info": "1983-08-29T00:00:00.000000Z",
                "work_permit_expiry_datetime": "2024-12-02T04:53:44.000000Z",
                "work_permit_creation_datetime": "2024-01-02T04:53:44.000000Z",
                "work_permit_delete_datetime": null
            }
*/

part of 'entities.dart';

class WorkPermit extends Equatable {
  final int? id;
  final int? userId;
  final String? expiryDate;

  const WorkPermit({this.id, this.userId, this.expiryDate});

  @override
  List<Object?> get props => [id, userId, expiryDate];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "candidate_work_permit_id": id,
        "work_permit_expiry_datetime": expiryDate,
      };
}
