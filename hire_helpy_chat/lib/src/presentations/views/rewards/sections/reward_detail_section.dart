part of '../../views.dart';

class RewardDetailSection extends StatefulWidget {
  const RewardDetailSection({super.key});

  @override
  State<RewardDetailSection> createState() => _RewardDetailSectionState();
}

class _RewardDetailSectionState extends State<RewardDetailSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _carouselController =
      PageController(viewportFraction: 0.6, initialPage: 0);
  int _currentPage = 0;
  int _currentCoin = 0;
  int _itemLength = 0;
  int coinRequire = 0;
  String itemLeft = "";
  String itemDesc = "";
  bool isLoading = false;
  RewardListModel? value;
  Map? employerData = {};
  String countryName = '';
  String basePhotoUrl = '';

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _carouselController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    changeCurrentPage();
  }

  void _nextPage() {
    if (_currentPage < _itemLength - 1) {
      _currentPage++;
      _carouselController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changeCurrentPage();
    }
  }

  void changeCurrentPage() {
    BlocProvider.of<RewardBloc>(context).setCurrentPage(_currentPage);
    setState(() {
      coinRequire = value!.data!.data![_currentPage].phcRequired ?? 0;
      itemLeft = "${value!.data!.data![_currentPage].itemCount}" == "Unlimited"
          ? "${value!.data!.data![_currentPage].itemCount}".tr
          : "${value!.data!.data![_currentPage].itemCount} ${'items left'.tr}";
      itemDesc = value!.data!.data![_currentPage].desc ?? StringConst.itemDesc;
    });
  }

  @override
  void initState() {
    _getPhotoUrl();
    _getEmployerData();
    _currentPage = BlocProvider.of<RewardBloc>(context).currentPage;
    value = BlocProvider.of<RewardBloc>(context).rewardListModel;
    _carouselController =
        PageController(viewportFraction: 0.6, initialPage: _currentPage);
    changeCurrentPage();
    super.initState();
    _carouselController.addListener(_onPageChanged);
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      countryName = box.get(DBUtils.country) ?? '';
      _currentCoin = employerData!['p_coin'] ?? 0;
    });
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix) ?? '';
    if (data != '') {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final carouselCubit = context.read<CarouselCubit>();
    final page = _carouselController.page?.round() ?? _currentPage;
    if (carouselCubit.state.selectedCardIndex != page) {
      carouselCubit.selectCard(page);
      _currentPage = page;
      changeCurrentPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _homeScaffold;
  }

  Widget get _homeScaffold => BackgroundScaffold(
        onWillPop: () => Get.back(),
          scaffold: Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        appBar: _getAppBar,
        body: _getRewardDetailContainer,
      ));

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.rewardTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: const [],
      );

  get _getRewardDetailContainer => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getRewardHeader,
            const SizedBox(
              height: 10,
            ),
            ExpandablePageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _carouselController,
              allowImplicitScrolling: true,
              itemCount: value!.data!.data!.length,
              itemBuilder: (_, index) {
                _itemLength = value!.data!.data!.length;
                if (!_carouselController.position.haveDimensions) {
                  return const SizedBox();
                }
                return AnimatedBuilder(
                  animation: _carouselController,
                  builder: (context, child) {
                    final double currentPage = _carouselController.page ?? 0;
                    final double position = index - currentPage;
                    final double scale = max(
                      0.8,
                      (1 - (position.abs()) / 2.5),
                    );
                    final String? src =
                        value!.data!.data![index].imageS3Filepath;
                    final String? reward = value!.data!.data![index].reward;
                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.89,
                            height: MediaQuery.of(context).size.height * 0.28,
                            child: Transform.translate(
                              offset: const Offset(0.0, 0.0),
                              filterQuality: FilterQuality.high,
                              child: Transform.scale(
                                alignment: Alignment.center,
                                scale: scale,
                                child: CarouselCard(
                                  src: "$basePhotoUrl/$src",
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _buildAnimatedText(null,
                            data: "$reward",
                            opacity: _currentPage != index ? 0.0 : 1.0)
                      ],
                    );
                  },
                );
              },
            ),
            _buildControl,
            _buildBody,
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  Widget _buildAnimatedText(TextStyle? textStyle,
          {required String data, double? opacity}) =>
      AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity ?? 1.0,
        child: Text(
          data,
          maxLines: 2,
          style: textStyle ??
              GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
        ),
      );

  Widget get _getRewardHeader => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            StringConst.currentBalanceText,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.white,
                fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset('assets/svg/coin.svg',
                    // ignore: deprecated_member_use
                    color: AppColors.primaryColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${employerData!['p_coin'] ?? 0} Coins',
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );

  Widget get _buildControl => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _previousPage(),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.amber,
                    size: 22,
                  ),
                ),
              ),
              Chip(
                  label: SizedBox(
                width: 130,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset('assets/svg/coin.svg',
                          // ignore: deprecated_member_use
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('$coinRequire Coins',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              )),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _nextPage(),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.amber,
                    size: 22,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              itemLeft,
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          )
        ],
      );
  Widget get _buildBody => Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            padding: const EdgeInsets.all(8.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Text(
                    itemDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          coinRequire > _currentCoin
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 26,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Insufficient phluid coins",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 47,
                      child: const CustomPrimaryButton(
                          customColor: Color(0xFFBEBEBE),
                          textColor: Colors.white,
                          fontSize: 20,
                          text: 'Claim Reward',
                          onPressed: null),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 26,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 47,
                      child: CustomPrimaryButton(
                          fontSize: 20,
                          text: 'Claim Reward',
                          onPressed: () {
                            _showDialog(
                                rewardId:
                                    value!.data!.data![_currentPage].rewardId ??
                                        0,
                                src:
                                    "$basePhotoUrl/${value!.data!.data![_currentPage].imageS3Filepath}",
                                reward: value!.data!.data![_currentPage]
                                        .rewardDisplayTitle ??
                                    "");
                          }),
                    ),
                  ],
                ),
        ],
      );

  void _showDialog(
          {required int rewardId,
          required String src,
          required String reward}) =>
      Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                      height: 160,
                      imageUrl: src,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                            height: 160,
                            width: 240,
                            child: LinearProgressIndicator(
                              color: Colors.grey.shade200,
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                      errorWidget: (context, imageUrl, dynamic) => Container(
                            height: 160,
                            width: 240,
                            decoration:
                                BoxDecoration(color: Colors.grey.shade200),
                            child: const Icon(
                              Icons.broken_image,
                              size: 35,
                              color: Colors.grey,
                            ),
                          )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "${StringConst.doYouWantClaim} $reward?",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF595959),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Text(
                      "$coinRequire ${StringConst.willBeDeducted}",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFA8A6A6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StatefulBuilder(builder: (context, stateSetter) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 45,
                          child: CustomPrimaryButton(
                              fontSize: 14,
                              customColor: const Color(0xFFA8A6A6),
                              text: "Cancel",
                              onPressed: () {
                                stateSetter(
                                  () => _setLoading(false),
                                );
                                Navigator.of(context).pop();
                              }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 45,
                          child: BlocConsumer<RewardBloc, RewardState>(
                              builder: (_, state) {
                            if (isLoading) {
                              return CustomPrimaryButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => stateSetter(
                                            () {
                                              _setLoading(true);
                                            },
                                          ),
                                  text: '',
                                  child: const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                        color: Colors.white,
                                      )));
                            } else {
                              return CustomPrimaryButton(
                                  fontSize: 14,
                                  text: 'Claim Now',
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                          await _claimReward(rewardId);
                                          stateSetter(
                                            () => _setLoading(true),
                                          );
                                        });
                            }
                          }, listener: (_, state) {
                            switch (state.runtimeType) {
                              case ClaimRewardLoading:
                                _setLoading(true);
                                break;
                              case ClaimRewardSuccess:
                                _setLoading(false);
                                Navigator.of(context).pop();
                                final successState =
                                    state as ClaimRewardSuccess;
                                if (successState.rewardData.data != null) {
                                  final data = ClaimRewardModel.fromMap(
                                      successState.rewardData.data!);
                                  showToast(
                                      context: context,
                                      message: "${data.message}",
                                      desc: StringConst.checkYourPhone);
                                }
                                break;
                              case ClaimRewardSuccessWithFail:
                                _setLoading(false);
                                Navigator.of(context).pop();
                                final successState =
                                    state as ClaimRewardSuccessWithFail;
                                if (successState.rewardData.data != null) {
                                  final data = ClaimRewardModel.fromMap(
                                      successState.rewardData.data!);
                                  showToast(
                                      context: context,
                                      message: "${data.message}",
                                      color: const Color(0xFFF50707),
                                      desc: StringConst.tryAgainLater);
                                }
                                break;
                              case ClaimRewardFail:
                                _setLoading(false);
                                Navigator.of(context).pop();
                                break;
                              default:
                                _setLoading(false);
                                showToast(
                                    context: context,
                                    message:
                                        "Session Expired! Please logout and login again!",
                                    color: const Color(0xFFF50707),
                                    desc: StringConst.tryAgainLater);
                                Navigator.of(context).pop();
                                break;
                            }
                          }),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
          barrierDismissible: false);

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void showToast(
      {required BuildContext context,
      required String message,
      String? desc,
      Color color = const Color(0xFF06B506),
      int duration = 5}) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return ToastMessage(
        message: message,
        desc: desc,
        color: color,
      );
    });

    overlayState.insert(overlayEntry);

    Timer(Duration(seconds: duration), () => overlayEntry.remove());
  }

  Future<ClaimRewardModel?> _claimReward(int rewardId) async {
    final rewardBloc = BlocProvider.of<RewardBloc>(context);
    RewardDetailRequestParams params = RewardDetailRequestParams(
        appLocale: countryName,
        rewardId: rewardId,
        bearerToken: employerData!['token']);
    rewardBloc.add(ClaimRewardRequested(params: params));
    return rewardBloc.claimRewardModel;
  }
}
