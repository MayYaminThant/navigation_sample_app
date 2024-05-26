part of 'models.dart';

class AdsModel extends Ads {
  const AdsModel({
    int? adsId,
    String? title,
    String? imageUrl,
    String? appSiloName,
    String? displayType,
  }) : super(
    adsId: adsId,
    title: title,
    imageUrl: imageUrl,
    appSiloName: appSiloName,
    displayType: displayType
        );

  factory AdsModel.fromJson(Map<dynamic, dynamic> map) {
    return AdsModel(
      adsId: map['ads_id'] != null ? map['ads_id'] as int: null,
      title: map['title'] != null ? map['title'] as String: null,
      imageUrl: map['media_filepath'] != null ? map['media_filepath'] as String: null,
      appSiloName: map['app_locale'] != null ? map['app_locale'] as String: null,
      displayType: map['display_effect'] != null ? map['display_effect'] as String: null,
    );
  }

}
