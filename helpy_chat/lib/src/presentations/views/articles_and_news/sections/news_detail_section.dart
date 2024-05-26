part of '../../views.dart';

class NewsDetailSection extends StatefulWidget {
  const NewsDetailSection({super.key});

  @override
  State<NewsDetailSection> createState() => _NewsDetailSectionState();
}

class _NewsDetailSectionState extends State<NewsDetailSection> {
  bool isExpanded = false;
  bool showForm = true;
  String token = "";
  NewsDetail? _newsDetail;
  int? newsId = 0;
  Map? candidateData;
  String route = '';
  FocusNode focus = FocusNode();
  bool isKeyboardVisible = false;
  bool isLoading = true;

  @override
  void initState() {
    _initLoad();
    _getInitializeData();
    super.initState();
  }

  void disponse() {
    token = "";
    super.dispose();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
  }

  Future<void> _getCandidateData() async {
    if (Get.parameters.isNotEmpty) {
      newsId = int.parse(Get.parameters['id'].toString());
      _requestNewsDetail();
    }
  }

  String get _getViewCount => _newsDetail!.viewTotalCount! >= 1000
      ? "${(_newsDetail!.viewTotalCount! / 1000).floor()}k"
      : "${_newsDetail!.viewTotalCount!}";

  void _requestNewsDetail() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsDetailRequestParams params = NewsDetailRequestParams(newsId: newsId);
    articleBloc.add(NewsDetailRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    isKeyboardVisible = mediaQuery.viewInsets.bottom > 0;
    return WillPopScope(
        onWillPop: () async {
          route != '' ? Get.offNamed(route) : Get.offAllNamed(rootRoute);
          return false;
        },
        child: BackgroundScaffold(scaffold: _getArticleEventScaffold));
  }

  Scaffold get _getArticleEventScaffold {
    return Scaffold(
        appBar: _getAppBar,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: false,
          child: _getArticleEventDetailContainer,
        ));
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () =>
              route != '' ? Get.offNamed(route) : Get.offAllNamed(rootRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          "Adventures".tr,
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

  Widget get _getArticleEventDetailContainer {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return isLoading
            ? LoadingScaffold.getLoading()
            : _newsDetail != null
                ? _getArticleDetailListView
                : const NoNews();
      },
      listener: (_, state) {
        if (state is NewsDetailSuccess) {
          _setLoading(false);
          setState(() {
            _newsDetail =
                NewsDetailModel.fromJson(state.articleData.data!['data']);
          });
        }

        if (state is NewsDetailFail) {
          _setLoading(false);
        }
      },
    );
  }

  Widget get _getArticleDetailListView {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
          height: MediaQuery.of(context)
              .size
              .height, //_articleDetail!.comments!.length < 3 ? MediaQuery.of(context).size.height : null,
          padding: const EdgeInsets.only(left: 15, right: 20, bottom: 60),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _newsDetail!.title ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w100),
                    ),
                    GestureDetector(
                        child: Transform.rotate(
                          angle: 1.5708,
                          child: const Icon(Iconsax.more, color: Colors.white),
                        ),
                        onTap: () {})
                  ],
                ),
                _getDateCreatedAtDetail(
                    "${_newsDetail!.newsExpirationDatetime}"),
                _getImageDetail,
                const SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [_buildVendorChat, _buildReserveNow]),
                // ),
                _getContentDetail
              ],
            ),
          )),
    );
  }

  Widget get _buildVendorChat => OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(150, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: AppColors.primaryColor)),
      child: Text("Vendor Chat",
          style: GoogleFonts.poppins(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600)));

  Widget get _buildReserveNow => CustomPrimaryButton(
        heightButton: 48,
        widthButton: 150,
        text: "Reserve Now",
        onPressed: () {},
      );

  Widget get _getViewCountContainer => Row(
        children: [
          const Icon(
            Iconsax.eye,
            color: AppColors.white,
            size: 14,
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              '$_getViewCount views',
              style: const TextStyle(color: AppColors.white, fontSize: 10),
            ),
          ),
        ],
      );

  Widget get _getImageDetail {
    return ImageSlider(media: _newsDetail!.media);
  }

  Widget _getDateCreatedAtDetail(String date) {
    // DateTime createdAt = DateTime.parse(date);
    // DateTime now = DateTime.now();
    // Duration difference = now.difference(createdAt);

    // String timeAgoText;
    // if (difference.inMinutes < 60) {
    //   timeAgoText = '${difference.inMinutes} minutes ago';
    // } else if (difference.inHours < 24) {
    //   timeAgoText = '${difference.inHours} hours ago';
    // } else {
    //   timeAgoText = '${difference.inDays} days ago';
    // }
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(top: 0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: AppColors.red,
                size: 13,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Exp: $formattedDate",
                style: const TextStyle(
                    color: AppColors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          _getViewCountContainer
        ],
      ),
    );
  }

  Widget get _getContentDetail {
    return Text(
      _newsDetail!.content ?? '',
      style: const TextStyle(
        color: AppColors.secondaryGrey,
        height: 3.0,
        fontSize: 14,
      ),
      textAlign: TextAlign.justify,
    );
  }

  // Widget get _getSeeMoreDivider {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       _newsDetail!.content!.length > 230 ||
  //               '\n'.allMatches(_newsDetail!.content!).length > 4
  //           ? TextButton(
  //               onPressed: () {
  //                 setState(() {
  //                   isExpanded = !isExpanded;
  //                 });
  //               },
  //               child: Text(
  //                 !isExpanded ? 'See More'.tr : 'See Less'.tr,
  //                 style: const TextStyle(
  //                   color: AppColors.articleBackgroundColor,
  //                   fontSize: 8,
  //                   decoration: TextDecoration.underline,
  //                 ),
  //               ),
  //             )
  //           : const SizedBox(
  //               height: 10,
  //             ),
  //       const Divider(color: AppColors.secondaryGrey),
  //     ],
  //   );
  // }

  Widget get _getLikesAndShare {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_getArticleShare],
    );
  }

  void showFormField() {
    setState(() {
      showForm = true;
    });
  }

  void _getInitializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  //Article Share
  Widget get _getArticleShare => Row(
        children: [
          TextButton.icon(
              onPressed: () => shareArticleLink(),
              icon: const Icon(
                Iconsax.send_24,
                color: AppColors.white,
                size: 20,
              ),
              label: const Text('Share',
                  style: TextStyle(fontSize: 10, color: AppColors.white)))
        ],
      );

  //Article Share
  Future<void> shareArticleLink() async {
    Uri data = await _getShareLink();
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.shareAdventureText,
        linkUrl: "$data",
        chooserTitle: kMaterialAppTitle);
  }

  Future<Uri> _getShareLink() async {
    return await ShortLink.createArticleShortLink(
        newsId.toString(), kArticleShortLink, 'news');
  }
}
