part of 'entities.dart';

class ClaimRewardModel {
  String? message;

  ClaimRewardModel({
    this.message,
  });

  factory ClaimRewardModel.fromJson(String str) =>
      ClaimRewardModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClaimRewardModel.fromMap(Map<String, dynamic> json) {
    return ClaimRewardModel(
      message: json["message"],
    );
  }

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
