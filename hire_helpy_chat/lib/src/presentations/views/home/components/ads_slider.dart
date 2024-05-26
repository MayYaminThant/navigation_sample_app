import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/core/utils/snackbar_utils.dart';
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
  String basePhotoUrl = '';
  String appLocale = '';
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _getPhotoUrl();
    _loadBannerAd();
    super.initState();
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

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    Box box = await Hive.openBox(DBUtils.dbName);
    String country = box.get(DBUtils.country) ?? '';
    setState(() {
      basePhotoUrl = data;
      appLocale = country;
    });
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
    return _isBannerAdReady? Center(
      child: SizedBox(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd, ),
                ),
    ): adsList.isNotEmpty
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Image.network(
                            '$basePhotoUrl/${e.imageUrl}',
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/phluid_coin.png",fit: BoxFit.cover,),
                            fit: BoxFit.fill,
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
                    child: CachedNetworkImage(
                      imageUrl: '$basePhotoUrl/${fadeList[index].imageUrl}',
                      fit: BoxFit.fill,
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

  _requestAds() {
    final adsBloc = BlocProvider.of<AdsBloc>(context);
    AdsListRequestParams params = AdsListRequestParams(
        displayType: widget.displayType, appLocale: appLocale);
    adsBloc.add(widget.displayType == 'fade'
        ? CandidateFadeAdsListRequested(params: params)
        : CandidateAdsListRequested(params: params));
  }
}
