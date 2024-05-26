import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/params/params.dart';
import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/ad_helper.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';

class AdsSlider extends StatefulWidget {
  const AdsSlider({super.key, this.displayType});
  final String? displayType;

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  List<Ads> adsList = [];
  List<Ads> fadeList = [];
  String appLocale = '';
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  Future<void> initLoad() async {
    await _getPhotoUrl();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: const AdSize(width: 320, height: 170),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  Future<void> _getPhotoUrl() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    String? country = box.get(DBUtils.country) ?? '';
    if (country != null) {
      setState(() {
        appLocale = country;
      });
    }
    _requestAds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsBloc, AdsState>(builder: (_, state) {
      return widget.displayType == 'SLIDE'
          ? _getHomeAdsSlider
          : _getHomeFadeAdsSlider;
    }, listener: (_, state) {
      if (state is AdsListSuccess) {
        if (state.data.data != null) {
          List<Ads> data = List<Ads>.from(
              (state.data.data!['data'] as List<dynamic>)
                  .map((e) => AdsModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            adsList = data;
          });
        }
      }

      if (state is AdsListFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is AdsFadeListSuccess) {
        if (state.data.data != null) {
          List<Ads> data = List<Ads>.from(
              (state.data.data!['data'] as List<dynamic>)
                  .map((e) => AdsModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            fadeList = data;
          });
        }
      }

      if (state is AdsFadeListFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getHomeAdsSlider {
    return _isBannerAdReady
        ? Center(
            child: SizedBox(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(
                ad: _bannerAd,
              ),
            ),
          )
        : adsList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  height: 170,
                  child: CarouselSlider(
                    unlimitedMode: true,
                    clipBehavior: Clip.none,
                    autoSliderDelay: const Duration(milliseconds: 6000),
                    initialPage: 0,
                    enableAutoSlider: true,
                    children: adsList
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  _requestAdsCount("${e.adsId}");
                                  Navigator.of(context).pushNamed(
                                      webViewPageRoute,
                                      arguments: {"url": e.adExternalUrl});
                                },
                                child: CustomImageView(
                                  image: '${e.imageUrl}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
            : Container();
  }

  Widget get _getHomeFadeAdsSlider {
    return fadeList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              height: 170,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                clipBehavior: Clip.none,
                slideBuilder: (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        _requestAdsCount("${fadeList[index].adsId}");
                        Navigator.of(context).pushNamed(webViewPageRoute,
                            arguments: {"url": fadeList[index].adExternalUrl});
                      },
                      child: CustomImageView(
                          image: '${fadeList[index].imageUrl}',
                          fit: BoxFit.cover),
                    ),
                  );
                },
                autoSliderDelay: const Duration(milliseconds: 3000),
                itemCount: fadeList.length,
                initialPage: 0,
                enableAutoSlider: true,
              ),
            ),
          )
        : Container();
  }

  void _requestAds() {
    final adsBloc = BlocProvider.of<AdsBloc>(context);
    AdsListRequestParams params = AdsListRequestParams(
        displayType: widget.displayType, appLocale: appLocale);
    adsBloc.add(widget.displayType == 'fade'
        ? CandidateFadeAdsListRequested(params: params)
        : CandidateAdsListRequested(params: params));
  }

  void _requestAdsCount(String ads) {
    final adsBloc = BlocProvider.of<AdsBloc>(context);
    AdsCountRequestParams params = AdsCountRequestParams(ads: ads);
    adsBloc.add(CandidateCountRequested(params: params));
  }
}
