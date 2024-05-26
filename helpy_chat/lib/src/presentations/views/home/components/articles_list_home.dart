import 'package:carousel_slider/carousel_slider.dart';
import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/data/models/models.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/home/components/marquee_text_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../blocs/blocs.dart';
import 'surviving_overseas_item.dart';

class ArticleListHome extends StatefulWidget {
  final bool? hiddenViewMore;
  final int? itemCount;
  final bool? isArticleCampaignEnabled;
  final String? campaignMessage;
  final String? campaignbkColor;

  const ArticleListHome(
      {super.key,
      this.hiddenViewMore,
      this.itemCount,
      this.isArticleCampaignEnabled = false,
      this.campaignMessage = "",
      this.campaignbkColor = ""});

  @override
  State<ArticleListHome> createState() => _ArticleListHomeState();
}

class _ArticleListHomeState extends State<ArticleListHome> {
  Map data = {};
  Map articles = {};
  late List<ArticleDetail> _articleList = [];
  String basePhotoUrl = '';
  String country = '';

  @override
  void initState() {
    _getPhotoUrl();
    super.initState();
  }

  Future<void> _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    Box box = await Hive.openBox(DBUtils.dbName);
    country = box.get(DBUtils.country) ?? '';
    if (data != null) {
      setState(() {
        basePhotoUrl = data;
      });
    }
    _requestArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return _getArticleListViewContainer;
  }

  // DH article listView container
  Widget get _getArticleListViewContainer =>
      BlocConsumer<ArticleBloc, ArticleState>(
        builder: (_, state) {
          return _buildArticleHome;
        },
        listener: (_, state) {
          if (state is ArticlesListSuccess) {
            if (state.articleData.data!['data'] != null) {
              var datas = state.articleData.data!['data'];
              List<ArticleDetail> data = List<ArticleDetail>.from(
                  (datas['data'] as List<dynamic>).map((e) =>
                      ArticleDetailModel.fromJson(e as Map<String, dynamic>)));
              setState(() {
                _articleList = data;
              });

              _requestNewsList();
            }
            return;
          }
        },
      );

  Widget get _buildArticleHome => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Sizes.padding20, right: Sizes.padding20),
            child: _getArticleListViewHeader(),
          ),
          if (widget.isArticleCampaignEnabled!)
            MarqueeTextHome(
                message: widget.campaignMessage!,
                colorCode: widget.campaignbkColor!,
                fontColor: Colors.black,
                isShowIcon: false),
          Padding(
            padding: const EdgeInsets.only(
                left: Sizes.padding20, right: Sizes.padding20),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                height: 270,
                child: CarouselSlider(
                  items: _articleList.map((article) {
                    return GestureDetector(
                        onTap: () {
                          Get.offNamed(articlesAndEventsDetailPageRoute,
                              parameters: {
                                'id': article.articleId.toString(),
                                'showLikes': 'true',
                              });
                        },
                        child: SurvivingOverseasItem(article: article));
                  }).toList(),
                  options: CarouselOptions(
                      viewportFraction: 0.48,
                      initialPage: 0,
                      height: 250,
                      autoPlay: true,
                      padEnds: false,
                      autoPlayInterval: const Duration(milliseconds: 3000)),
                )),
          ),
        ],
      );

  // DH article listView header
  Widget _getArticleListViewHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              StringConst.survivingOverseas.tr,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Offstage(
              offstage: widget.hiddenViewMore ?? false,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(articlesListPageRoute);
                },
                child: Text(
                  'View More Articles'.tr,
                  style: const TextStyle(
                    color: AppColors.primaryGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _requestArticleList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params = ArticlesListRequestParams(
        language: "English", sortBy: "latest", page: 1);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  void _requestNewsList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsListRequestParams params =
        NewsListRequestParams(appLocale: country, page: 1);
    articleBloc.add(NewsListRequested(params: params));
  }
}
