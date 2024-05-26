import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/data/models/models.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/home/components/article_list_item.dart';
import 'package:dh_mobile/src/presentations/widgets/app_article_skeleton.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../blocs/blocs.dart';

class NewList extends StatefulWidget {
  const NewList({super.key});

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  bool isLoading = true;
  bool loadMore = false;
  final ScrollController _controller = ScrollController();
  String country = '';
  //update
  int perPage = 0;
  int total = 0;
  int loadMorePage = 1;
  bool nextPageUrl = true;
  List<NewsDetail> newsDetailList = [];
  int loadMorePageNews = 1;
  bool nextPageUrlNews = true;

  void _setLoading(bool value) {
    if (!loadMore) {
      setState(() {
        isLoading = value;
      });
    }
  }

  void _loadMoreData() {
    _requestNewsList();
    setState(() {
      loadMore = true;
    });
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    country = box.get(DBUtils.country) ?? '';
    _requestNewsList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getEventListViewContainer;
  }

  //DH Event listView
  Widget get _getEventListViewContainer {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getEventListViewHeader,
        BlocConsumer<ArticleBloc, ArticleState>(builder: (_, state) {
          return _getEventListView;
        }, listener: (_, state) {
          if (state is NewsListLoading) {
            _setLoading(true);
            setState(() {
              loadMore = false;
            });
          }
          if (state is NewsListSuccess) {
            final data = state.newsData;
            if (loadMorePageNews == 1) {
              if (data.data != null) {
                newsDetailList.clear();
                final String? lastPage = data.data!["data"]['next_page_url'];
                Iterable iterable = data.data!['data']["data"];
                for (var element in iterable) {
                  newsDetailList.add(NewsDetailModel.fromJson(element));
                }
                if (lastPage != null) {
                  loadMorePageNews++;
                } else {
                  nextPageUrlNews = false;
                }
              }
            } else {
              if (nextPageUrlNews == true) {
                if (data.data != null) {
                  final String? lastPage = data.data!["data"]['next_page_url'];
                  List<NewsDetail> loadmoredata = [];
                  Iterable iterable = data.data!['data']["data"];
                  for (var element in iterable) {
                    loadmoredata.add(NewsDetailModel.fromJson(element));
                  }
                  if (loadmoredata.isNotEmpty) {
                    for (var element in loadmoredata) {
                      newsDetailList.add(element);
                    }
                    if (lastPage == null) {
                      nextPageUrlNews = false;
                    } else {
                      loadMorePageNews++;
                    }
                  }
                }
              }
            }
            _setLoading(false);
            setState(() {
              loadMore = false;
            });
            loadMore ? _scrollDown() : null;
          }
          if (state is NewsListFail) {
            _setLoading(false);
            setState(() {
              loadMore = false;
            });
          }
        })
      ],
    );
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final doubleOffset = _controller.offset + perPage * 28.8;
      final double offset = _controller.position.maxScrollExtent < doubleOffset
          ? _controller.position.maxScrollExtent
          : doubleOffset;
      if (_controller.hasClients) {
        _controller.animateTo(
          offset,
          curve: Curves.easeOut,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }

  //DH Event listView header
  Widget get _getEventListViewHeader {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        "Let's see what’s new today.",
        style: TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget get _getEventListView => isLoading
      ? const AppArticlesSkeleton(
          itemCount: 5,
        )
      : Column(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: newsDetailList
                  .map((e) => GestureDetector(
                        onTap: () {
                          Get.offNamed(newsDetailPageRoute, parameters: {
                            'id': e.newsId.toString(),
                            'route': newsListPageRoute,
                          });
                        },
                        child: ArticleListItem(
                          title: e.title ?? '',
                          subtitle: e.content ?? '',
                          createdAt: e.createdAt ?? '',
                          thumbnail: e.media!.isNotEmpty
                              ? e.media![0].mediaFilePath
                              : '',
                          showLikes: false,
                          upVote: e.upvote,
                          downVote: e.downvote,
                          viewCount: e.viewTotalCount,
                          commentCount: e.commentCount,
                          thumbnailImage: e.media!.isNotEmpty
                              ? e.media![0].mediaThumbnailFilepath
                              : '',
                        ),
                      ))
                  .toList(),
            ),
            nextPageUrlNews
                ? loadMore
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(strokeWidth: 2.0)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomPrimaryButton(
                          heightButton: 40,
                          widthButton: 70,
                          text: 'See More',
                          onPressed: () => _loadMoreData(),
                          fontSize: 10,
                        ),
                      )
                : Container()
          ],
        );

  void _requestNewsList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsListRequestParams params =
        NewsListRequestParams(appLocale: country, page: loadMorePageNews);
    articleBloc.add(NewsListRequested(params: params));
  }
}
