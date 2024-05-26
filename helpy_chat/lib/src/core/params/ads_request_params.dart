part of 'params.dart';

class AdsListRequestParams {
  final String? displayType;
  final String? appLocale;

  AdsListRequestParams({this.displayType, this.appLocale});
}

class AdsCountRequestParams {
  final String? ads;

  AdsCountRequestParams({
    this.ads,
  });
}
