part of 'entities.dart';

class RewardListModel {
  Data? data;
  String? message;

  RewardListModel({
    this.data,
    this.message,
  });

  factory RewardListModel.fromJson(String str) =>
      RewardListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RewardListModel.fromMap(Map<String, dynamic> json) => RewardListModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? rewardId;
  String? appLocale;
  String? appType;
  String? reward;
  String? rewardDisplayTitle;
  String? desc;
  int? phcRequired;
  String? iconS3Filepath;
  String? imageS3Filepath;
  String? itemCount;

  Datum({
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

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) {
    return Datum(
      rewardId: json["reward_id"],
      appLocale: json["app_locale"],
      appType: json["app_type"],
      reward: json["reward"],
      rewardDisplayTitle: json["reward_display_title"],
      desc: json["desc"],
      phcRequired: json["PHC_required"],
      iconS3Filepath: json["icon_s3_filepath"],
      imageS3Filepath: json["image_s3_filepath"],
      itemCount: "${json["item_count"]}".startsWith("77777")
          ? "Unlimited"
          : '${json["item_count"]}',
    );
  }

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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
