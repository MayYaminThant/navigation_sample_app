import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/presentations/views/home/components/article_list_item.dart';
import 'package:dh_employer/src/presentations/widgets/app_article_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isDataDisabled = false;

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
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    Box box = await Hive.openBox(DBUtils.dbName);
    country = box.get(DBUtils.country) ?? '';
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    isDataDisabled = context.read<ArticleBloc>().newsDetailList.isNotEmpty;
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
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          Offstage(
            offstage: isDataDisabled == true
                ? widget.hiddenViewMore ?? false
                : widget.hiddenViewMore ?? true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => Get.toNamed(newsListPageRoute),
                child: Text(
                  'View More Adventures'.tr,
                  style: const TextStyle(
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
            if (state.country != null) {
              setState(() {
                country = state.country!;
              });
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
      : isDataDisabled == true
          ? ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: context
                  .read<ArticleBloc>()
                  .newsDetailList
                  .sublist(
                      0,
                      widget.itemCount != null &&
                              widget.itemCount! <
                                  context
                                      .read<ArticleBloc>()
                                      .newsDetailList
                                      .length
                          ? widget.itemCount
                          : context.read<ArticleBloc>().newsDetailList.length)
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
                          thumbnail: e.media!.isNotEmpty
                              ? e.media![0].mediaThumbnailFilePath
                              : '',
                          viewCount: e.viewTotalCount ?? 0,
                          showLikes: false,
                        ),
                      ))
                  .toList(),
            )
          : Center(
              child: Text(
                "There are no data in $country",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            );
}
