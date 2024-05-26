part of 'entities.dart';

class RewardDetailModel {
    RewardDetailData? data;
    String? message;

    RewardDetailModel({
        this.data,
        this.message,
    });

    factory RewardDetailModel.fromJson(String str) => RewardDetailModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RewardDetailModel.fromMap(Map<String, dynamic> json) => RewardDetailModel(
        data: json["data"] == null ? null : RewardDetailData.fromMap(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
    };
}

class RewardDetailData {
    int? rewardId;
    String? appLocale;
    String? appType;
    String? reward;
    String? rewardDisplayTitle;
    String? desc;
    int? phcRequired;
    String? iconS3Filepath;
    String? imageS3Filepath;
    int? itemCount;

    RewardDetailData({
        this.rewardId,
        this.appLocale,
        this.appType,
        this.reward,
        this.rewardDisplayTitle,
        this.desc,
        this.phcRequired,
        this.iconS3Filepath,
        this.imageS3Filepath,
        this.itemCount,
    });

    factory RewardDetailData.fromJson(String str) => RewardDetailData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RewardDetailData.fromMap(Map<String, dynamic> json) => RewardDetailData(
        rewardId: json["reward_id"],
        appLocale: json["app_locale"],
        appType: json["app_type"],
        reward: json["reward"],
        rewardDisplayTitle: json["reward_display_title"],
        desc: json["desc"],
        phcRequired: json["PHC_required"],
        iconS3Filepath: json["icon_s3_filepath"],
        imageS3Filepath: json["image_s3_filepath"],
        itemCount: json["item_count"],
    );

    Map<String, dynamic> toMap() => {
        "reward_id": rewardId,
        "app_locale": appLocale,
        "app_type": appType,
        "reward": reward,
        "reward_display_title": rewardDisplayTitle,
        "desc": desc,
        "PHC_required": phcRequired,
        "icon_s3_filepath": iconS3Filepath,
        "image_s3_filepath": imageS3Filepath,
        "item_count": itemCount,
    };
}
