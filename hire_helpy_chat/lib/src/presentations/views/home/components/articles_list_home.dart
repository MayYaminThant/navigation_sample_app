import 'package:carousel_slider/carousel_slider.dart';
import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/data/models/models.dart';
import 'package:dh_employer/src/domain/entities/entities.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
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
  const ArticleListHome({super.key, this.hiddenViewMore, this.itemCount});

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
    initLoad();
    super.initState();
    _getPhotoUrl();
  }

  void initLoad() async {
    await _getPhotoUrl();
    _requestArticleList();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    Box box = await Hive.openBox(DBUtils.dbName);
    country = box.get(DBUtils.country) ?? '';
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return _getArticleListViewContainer();
      },
      listener: (_, state) {
        if (state is ArticlesListLoading) {
          //return const AppArticlesSkeleton();
        }

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
  }

  // DH article listView container
  Widget _getArticleListViewContainer() {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 40),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            height: 270,
            child: CarouselSlider(
              items: _articleList.map((article) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed(articlesAndEventsDetailPageRoute,
                              parameters: {
                                'id': article.articleId.toString(),
                                'showLikes': 'true',
                              });
                        },
                        child: SurvivingOverseasItem(article: article));
                  },
                );
              }).toList(),
              options: CarouselOptions(
                  viewportFraction: 0.48,
                  initialPage: 0,
                  autoPlay: true,
                  height: 250,
                  padEnds: false,
                  autoPlayInterval: const Duration(milliseconds: 3000)),
            )),
        Positioned(
          top: -10,
          left: 0,
          right: 0,
          child: _getArticleListViewHeader(),
        )
      ],
    );
  }

  // DH article listView header
  Widget _getArticleListViewHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConst.articleTitle.tr,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Offstage(
            offstage: widget.hiddenViewMore ?? false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<ArticleBloc>(context).resetState();
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

  _requestArticleList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params = ArticlesListRequestParams(
        language: "English", sortBy: "latest", page: 1);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  _requestNewsList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsListRequestParams params =
        NewsListRequestParams(appLocale: country, page: 1);
    articleBloc.add(NewsListRequested(params: params));
  }
}
