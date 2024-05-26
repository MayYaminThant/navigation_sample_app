import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/data/models/models.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/views/home/components/article_list_item.dart';
import 'package:dh_mobile/src/presentations/widgets/app_article_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';

class EventListHome extends StatefulWidget {
  final bool? hiddenViewMore;
  final int? itemCount;

  const EventListHome({super.key, this.hiddenViewMore, this.itemCount});

  @override
  State<EventListHome> createState() => _EventListHomeState();
}

class _EventListHomeState extends State<EventListHome> {
  String basePhotoUrl = '';
  String country = "";
  bool isLoading = false;
  bool isOffstage = false;
  //update
  List<NewsDetail> newsDetailList = [];

  void toggleVisibility() {
    setState(() {
      isOffstage = !isOffstage;
    });
  }

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  void initLoad() async {
    await _getPhotoUrl();
    _requestNewsList();
  }

  _requestNewsList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsListRequestParams params =
        NewsListRequestParams(appLocale: country, page: 1);
    articleBloc.add(NewsListRequested(params: params));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    Box box = await Hive.openBox(DBUtils.dbName);
    country = box.get(DBUtils.country) ?? '';
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getEventListViewContainer;
  }

  //DH Event listView
  Widget get _getEventListViewContainer {
    return Column(
      children: [_getEventListViewHeader, _getEventListView()],
    );
  }

  //DH Event listView header
  Widget get _getEventListViewHeader {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Adventures'.tr,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          Offstage(
            offstage: newsDetailList.isNotEmpty
                ? widget.hiddenViewMore ?? false
                : widget.hiddenViewMore ?? true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => Get.toNamed(newsListPageRoute),
                child: const Text(
                  'View More',
                  style: TextStyle(
                      color: AppColors.primaryGrey,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEventListView() {
    return BlocConsumer<ArticleBloc, ArticleState>(
        builder: (context, state) => _buildNewsList,
        listener: (context, state) {
          if (state is NewsListLoading) {
            _setLoading(true);
          }
          if (state is NewsListSuccess) {
            final data = state.newsData;
            if (data.data != null) {
              newsDetailList.clear();
              Iterable iterable = data.data!['data']["data"];
              for (var element in iterable) {
                newsDetailList.add(NewsDetailModel.fromJson(element));
              }
            }
            _setLoading(false);
          }
          if (state is NewsListFail) {
            _setLoading(false);
          }
        });
  }

  Widget get _buildNewsList => isLoading
      ? const AppArticlesSkeleton()
      : newsDetailList.isNotEmpty
          ? ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: newsDetailList
                  .sublist(
                      0,
                      widget.itemCount != null &&
                              widget.itemCount! < newsDetailList.length
                          ? widget.itemCount
                          : newsDetailList.length)
                  .map((e) => GestureDetector(
                        onTap: () {
                          Get.toNamed(newsDetailPageRoute, parameters: {
                            'id': e.newsId.toString(),
                            'showLikes': 'false',
                          });
                        },
                        child: ArticleListItem(
                          title: e.title ?? '',
                          subtitle: e.content ?? '',
                          createdAt: e.createdAt ?? '',
                          thumbnailImage: e.media!.isNotEmpty
                              ? e.media![0].mediaThumbnailFilepath
                              : '',
                          viewCount: e.viewTotalCount ?? 0,
                          showLikes: false,
                        ),
                      ))
                  .toList(),
            )
          : Container();
}
