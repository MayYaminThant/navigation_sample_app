// {
//       "ads_id": 4,
//       "title": "Voluptatibus consequatur neque ut consequuntur odit et neque maiores fugit.",
//       "image_url": "dh/ads/grab/JFFKq2zZPjPhLW8ADpTdWjioGwHHjDK81efvyHlr.png",
//       "app_silo_name": "DH_Candidate",
//       "display_type": "slide"
//     },

part of 'entities.dart';

class Ads extends Equatable {
  final int? adsId;
  final String? title;
  final String? imageUrl;
  final String? appSiloName;
  final String? displayType;
  final String? adExternalUrl;

  const Ads(
      {this.adsId,
      this.title,
      this.imageUrl,
      this.appSiloName,
      this.displayType,
      this.adExternalUrl});

  @override
  List<Object?> get props =>
      [adsId, title, imageUrl, appSiloName, displayType, adExternalUrl];

  @override
  bool get stringify => true;
}
