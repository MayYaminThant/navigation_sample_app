import 'dart:convert';

class FaqModel {
  Data? data;
  String? message;

  FaqModel({
    this.data,
    this.message,
  });

  factory FaqModel.fromJson(String str) => FaqModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqModel.fromMap(Map<String, dynamic> json) => FaqModel(
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
  List<FAQDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
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
            : List<FAQDatum>.from(json["data"]!.map((x) => FAQDatum.fromMap(x))),
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

class FAQDatum {
  int? faqRankOrder;
  String? language;
  String? appType;
  String? question;
  String? answer;
  int? viewTotalCount;
  bool? hidden;

  FAQDatum({
    this.faqRankOrder,
    this.language,
    this.appType,
    this.question,
    this.answer,
    this.viewTotalCount,
    this.hidden,
  });

  factory FAQDatum.fromJson(String str) => FAQDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FAQDatum.fromMap(Map<String, dynamic> json) => FAQDatum(
        faqRankOrder: json["faq_rank_order"],
        language: json["language"],
        appType: json["app_type"],
        question: json["question"],
        answer: json["answer"],
        viewTotalCount: json["view_total_count"],
        hidden: json["hidden"],
      );

  Map<String, dynamic> toMap() => {
        "faq_rank_order": faqRankOrder,
        "language": language,
        "app_type": appType,
        "question": question,
        "answer": answer,
        "view_total_count": viewTotalCount,
        "hidden": hidden,
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
