part of '../../views.dart';

class NewsDetailSection extends StatefulWidget {
  const NewsDetailSection({super.key});

  @override
  State<NewsDetailSection> createState() =>
      _NewsDetailSectionState();
}

class _NewsDetailSectionState extends State<NewsDetailSection> {
  final TextEditingController _textController = TextEditingController();

  bool isExpanded = false;
  bool showForm = true;
  String? _token;
  NewsDetail? _newsDetail;
  int? newsId = 0;
  Map? candidateData;

  String basePhotoUrl = '';
  final int _currentPage = 0;
  String route = '';
  FocusNode focus = FocusNode();
  bool isKeyboardVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    _getPhotoUrl();
    _getCandidateData();
    _getInitializeData();
    super.initState();
  }

  void disponse() {
    _token = null;
    super.dispose();
  }

  _getCandidateData() async {
    if (Get.parameters.isNotEmpty) {
      newsId = int.parse(Get.parameters['id'].toString());
      _requestNewsDetail();
    }
  }

  _requestNewsDetail() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsDetailRequestParams params = NewsDetailRequestParams(
      newsId: newsId
    );
    articleBloc.add(NewsDetailRequested(params: params));
  }

  void _getPhotoUrl() async {
    String? data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data ?? '';
    });
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
        actions: const [
        ],
      );

  Widget get _getArticleEventDetailContainer {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return isLoading
            ? LoadingScaffold.getLoading()
            : _newsDetail != null
                ? _getArticleDetailListView
                : const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ));
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
          Get.offAllNamed(emptyNewsPageRoute);
        }

      },
    );
  }

  Widget get _getArticleDetailListView {
    return SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height, //_articleDetail!.comments!.length < 3 ? MediaQuery.of(context).size.height : null,
                padding: const EdgeInsets.only(left: 15, right: 20, bottom: 60),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      _getDateCreatedAtDetail(_newsDetail!.createdAt!),
                      _getImageDetail,
                      _getContentDetail,
                      _getSeeMoreDivider,
                      _getLikesAndShare,
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                )),
          );
  }

  Widget get _getImageDetail {
    return ImageSlider(media: _newsDetail!.media);
  }

  Widget _getDateCreatedAtDetail(String date) {
    DateTime createdAt = DateTime.parse(date);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    String timeAgoText;
    if (difference.inMinutes < 60) {
      timeAgoText = '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      timeAgoText = '${difference.inHours} hours ago';
    } else {
      timeAgoText = '${difference.inDays} days ago';
    }

    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(top: 0, bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.schedule,
            color: AppColors.primaryGrey,
            size: 10,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            timeAgoText,
            style: const TextStyle(
                color: AppColors.secondaryGrey,
                fontSize: 10,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget get _getContentDetail {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        _newsDetail!.content ?? '',
        style: const TextStyle(
          color: AppColors.secondaryGrey,
          fontSize: 14,
        ),
        textAlign: TextAlign.justify,
        maxLines: isExpanded ? null : 5,
      ),
    );
  }

  Widget get _getSeeMoreDivider {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _newsDetail!.content!.length > 230 || '\n'.allMatches(_newsDetail!.content!).length > 4
            ? TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  !isExpanded ? 'See More' : 'See Less',
                  style: const TextStyle(
                    color: AppColors.articleBackgroundColor,
                    fontSize: 8,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            : const SizedBox(
                height: 10,
              ),
        const Divider(color: AppColors.secondaryGrey),
      ],
    );
  }

  Widget get _getLikesAndShare {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _getArticleShare
      ],
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
  get _getArticleShare => Row(
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
    String link = (await _getShareLink()).toString();
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.shareAdvetureText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle,
        );
  }

  _getShareLink() async {
    return await ShortLink.createArticleShortLink(
        newsId.toString(), kArticleShortLink, 'news');
  }
}
