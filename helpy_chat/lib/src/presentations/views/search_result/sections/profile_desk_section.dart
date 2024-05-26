part of '../../views.dart';

class ProfilDeskSection extends StatefulWidget {
  const ProfilDeskSection({super.key});

  @override
  State<ProfilDeskSection> createState() => _ProfilDeskSectionState();
}

class _ProfilDeskSectionState extends State<ProfilDeskSection> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  int maxFailedLoadAttempts = 5;
  bool isInitial = false;
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
  }

  void changeLoading(bool value) {
    setState(() {
      _isAdLoaded = value;
    });
  }

  Future<void> _loadInterstitialAd() async {
    final adCompleter = Completer<void>();
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
          changeLoading(true);
          adCompleter.complete();
        },
        onAdFailedToLoad: (error) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
          changeLoading(false);
          _goToNextPage();
          adCompleter.complete();
        },
      ),
    );
    await adCompleter.future;
  }

  void _showInterstitialAd() {
    if (_isAdLoaded) {
      Loading.cancelLoading();
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          _goToNextPage();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          changeLoading(false);
        },
      );
      _interstitialAd?.show();
    }
    _goToNextPage();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    isInitial = false;
    Loading.cancelLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getStarInfoMessageContainer;
  }

  get _getStarInfoMessageContainer {
    return Stack(
      children: [
        EmptyMessage(
          title: 'Hey! There are still more.'.tr,
          image: 'assets/images/profile-desk.png',
          description: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text:
                        'For more Employer Profiles, please go to our Search Section or Search again. Click on Button below to go to the Search..'
                            .tr,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.primaryGrey, height: 2)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(bottom: 10, right: 20, left: 20, child: _getSearchNowButton)
      ],
    );
  }

  //Search Now Button
  Widget get _getSearchNowButton {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        height: Sizes.button47,
        child: CustomPrimaryButton(
            text: StringConst.goToAdvancedSearchText,
            onPressed: () async {
              setState(() {
                isInitial = true;
              });
              Loading.showLoading(message: "Loading Ads! Please Wait....");
              await _loadInterstitialAd();
              _showInterstitialAd();
            }));
  }

  void _goToNextPage() {
    Loading.cancelLoading();
    setState(() {
      isInitial = false;
    });
    candidateData != null
        ? Get.toNamed(advancedSearchPageRoute)
        : Get.offAllNamed(signInPageRoute);
  }
}
