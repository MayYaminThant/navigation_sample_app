import 'dart:convert';

import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/data/models/models.dart';
import 'package:dh_mobile/src/domain/entities/article_model.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/articles_and_news/components/article_language_dropdown.dart';
import 'package:dh_mobile/src/presentations/views/articles_and_news/components/delete_article_modal.dart';
import 'package:dh_mobile/src/presentations/views/home/components/article_list_item.dart';
import 'package:dh_mobile/src/presentations/views/views.dart';
import 'package:dh_mobile/src/presentations/widgets/app_article_skeleton.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../blocs/blocs.dart';
import '../../articles_and_news/components/article_sortby_dropdown.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ConfigLanguage selectedValue = const ConfigLanguage();
  List<ConfigLanguage> languageList = [];
  Map? candidateData;
  SortByClass selectedSortBy =
      SortByClass(id: 1, title: "Latest", data: "latest");
  List<SortByClass> sortByList = [
    SortByClass(id: 1, title: "Latest", data: "latest"),
    SortByClass(id: 2, title: "Popular", data: "popular"),
    SortByClass(id: 3, title: "My Articles", data: "myArticles")
  ];
  bool isLoading = true;
  bool loadMore = false;
  // final ScrollController _controller = ScrollController();
  int deleteArticleId = 0;
  List<String> _articleComplainList = [];
  //update
  ArticleModel articleModel = ArticleModel();
  int lenghtOfArticle = 0;
  int perPage = 0;
  int total = 0;
  int loadMorePage = 1;
  bool nextPageAvailable = true;

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    _getCandidateData();
    initLoad();
    super.initState();
  }

  Future<void> initLoad() async {
    await _getLanguageData();
    _requestArticleList(1);
    _getComplainArticle();
  }

  void _loadMoreData() {
    loadMore ? null : _requestArticleList(loadMorePage);
    setState(() {
      loadMore = true;
    });
  }

  // void _scrollDown() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final doubleOffset = _controller.offset + perPage * 28.8;
  //     final double offset = _controller.position.maxScrollExtent < doubleOffset
  //         ? _controller.position.maxScrollExtent
  //         : doubleOffset;
  //     if (_controller.hasClients) {
  //       _controller.animateTo(
  //         offset,
  //         curve: Curves.easeOut,
  //         duration: const Duration(seconds: 3),
  //       );
  //     }
  //   });
  // }

  void _setLoading(bool value) {
    if (!loadMore) {
      setState(() {
        isLoading = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(rootRoute);
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: _getAppBar,
          drawerScrimColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          drawer: const SideMenu(
            menuName: StringConst.articlesList,
          ),
          body: _getArticleListViewContainer,
        ),
      ),
    );
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Get.offAllNamed(rootRoute);
        },
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      title: Text(
        StringConst.survivingOverseas.tr,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
      ),
      leadingWidth: 52,
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Future<void> _getComplainArticle() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? articleComplainCacheData = box.get('complained_articles');

    if (articleComplainCacheData != null) {
      setState(() {
        _articleComplainList = articleComplainCacheData;
      });
    }
  }

  //Language Data List with top Countries
  Future<void> _getLanguageData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    final lan = box.get(DBUtils.language);
    List<ConfigLanguage> dataList = List<ConfigLanguage>.from(
        (await DBUtils.getKeyDataList(ConfigsKeyHelper.articleLanguageKey))
            .map((e) => ConfigLanguageModel.fromJson(e)));
    setState(() {
      languageList.addAll(dataList);
      selectedValue = languageList.singleWhere(
          (element) => element.language == lan,
          orElse: () => const ConfigLanguage(
              language: "English", languageName: "English"));
    });
  }

  // DH article listView container
  Widget get _getArticleListViewContainer => RefreshIndicator(
        onRefresh: () => Future.delayed(
            const Duration(seconds: 1), () => _requestArticleList(1)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.padding20,
            ),
            child: Wrap(
              children: [
                _getArticleListViewHeader,
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ArticleLanguageDropDown(
                        initialValue: selectedValue,
                        languageList: languageList,
                        onValueChanged: isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                                _requestArticleList(1);
                              },
                      ),
                      ArticleSortByDropDown(
                        sortByList: sortByList,
                        onValueChanged: isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  selectedSortBy = value;
                                });
                                _requestArticleList(1);
                              },
                      ),
                    ],
                  ),
                ),
                _getArticleListView()
              ],
            ),
          ),
        ),
      );

  Widget _getArticleListView() {
    return BlocConsumer<ArticleBloc, ArticleState>(
        builder: (_, state) => _buildArticleListWidget,
        listener: (_, state) {
          if (state is ArticlesListLoading) {
            _setLoading(true);
          }
          if (state is ArticlesListSuccess) {
            final DataResponseModel data = state.articleData;
            if (loadMorePage == 1) {
              if (state.articleData.data != null) {
                if (data.data != null) {
                  articleModel = ArticleModel.fromMap(data.data!);
                  if (articleModel.data != null) {
                    if (articleModel.data!.data != null) {
                      if (articleModel.data!.nextPageUrl != null) {
                        loadMorePage++;
                        nextPageAvailable = true;
                      } else {
                        nextPageAvailable = false;
                      }
                      lenghtOfArticle = articleModel.data!.to ?? 0;
                      perPage = articleModel.data!.perPage ?? 0;
                      total = articleModel.data!.total == null
                          ? 0
                          : articleModel.data!.total!;
                    }
                  }
                }
              }
            } else {
              if (nextPageAvailable == true) {
                if (data.data != null) {
                  final ArticleModel loadmoredata =
                      ArticleModel.fromMap(data.data!);
                  if (loadmoredata.data != null) {
                    final dataList = loadmoredata.data!.data ?? [];
                    for (var element in dataList) {
                      articleModel.data!.data!.add(element);
                    }
                    if (loadmoredata.data!.nextPageUrl == null) {
                      nextPageAvailable = false;
                    } else {
                      nextPageAvailable = true;
                      loadMorePage++;
                    }
                    lenghtOfArticle = loadmoredata.data!.to ?? 0;
                    perPage = loadmoredata.data!.perPage ?? 0;
                    total = articleModel.data!.total == null
                        ? 0
                        : articleModel.data!.total!;
                  }
                }
              }
            }
            // loadMore ? _scrollDown() : null;
            setState(() {
              loadMore = false;
            });
            _setLoading(false);
          }
          if (state is ArticlesListFail) {
            _setLoading(false);
            Navigator.pop(context);
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }

          if (state is ArticleDeleteSuccess) {
            Navigator.pop(context);
            showInfoModal(
              title: 'Your article has been successfully deleted.',
              type: 'success',
            );
            showSuccessSnackBar(state.articleData.data!['message']);
            _requestArticleList(1);
          }
        });
  }

  // DH article listView header
  Widget get _getArticleListViewHeader => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Let's Discover!".tr,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (candidateData != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () => Get.toNamed(articleCreate),
                  child: Text(
                    StringConst.createArticle.tr,
                    style: const TextStyle(
                      color: AppColors.brandBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  Widget get _buildArticleListWidget => isLoading
      ? const AppArticlesSkeleton(
          itemCount: 10,
        )
      : articleModel.data == null
          ? const AppArticlesSkeleton(
              itemCount: 10,
            )
          : articleModel.data!.data == null
              ? const AppArticlesSkeleton(
                  itemCount: 10,
                )
              : articleModel.data!.data!.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        Wrap(
                          children: articleModel.data!.data!
                              .where((article) => !_articleComplainList
                                  .contains(article.articleId.toString()))
                              .map((e) {
                            return GestureDetector(
                              onTap: () {
                                final res = Get.toNamed(
                                    articlesAndEventsDetailPageRoute,
                                    parameters: {
                                      'id': e.articleId.toString(),
                                      'route': articlesListPageRoute,
                                      'showLikes': 'true',
                                    });
                                if (res == null) return;
                                res.then((value) {
                                  if (value == 'delete') {
                                    _deleteArticle(e.articleId!);
                                  } else if (value == 'edit') {
                                    DBUtils.saveString(
                                      json.encode(e.toMap()),
                                      'article_update',
                                    );
                                    Get.offNamed(articleEditPageRoute);
                                  } else {}
                                });
                              },
                              child: ArticleListItem(
                                title: e.title ?? '',
                                subtitle: e.content ?? '',
                                createdAt: e.articleCreationDatetime ?? '',
                                thumbnail: e.media!.isNotEmpty
                                    ? e.media!.first.mediaFilepath
                                    : '',
                                thumbnailImage: e.media!.isNotEmpty
                                    ? e.media!.first.mediaThumbnailFilepath
                                    : '',
                                articleId: e.articleId.toString(),
                                creator: e.creator,
                                showLikes: true,
                                upVote: e.upVoteCount,
                                downVote: e.downVoteCount,
                                commentCount: e.commentCount,
                                viewCount: e.viewTotalCount,
                                showActions:
                                    selectedSortBy.data == 'myArticles',
                                onValueChanged: (String value) {
                                  if (value == 'delete') {
                                    _showDeleteModal(e.articleId!);
                                  } else {
                                    DBUtils.saveString(json.encode(e.toMap()),
                                        'article_update');
                                    Get.offNamed(articleEditPageRoute);
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        nextPageAvailable
                            ? loadMore
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: 17,
                                        height: 17,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2.0)),
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

  void _requestArticleList(int page) {
    loadMorePage = page;
    if (page == 1) {
      setState(() {
        loadMore = false;
      });
    }
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params = ArticlesListRequestParams(
        token: candidateData != null ? candidateData!['token'] : null,
        language: selectedValue.language ?? "English",
        sortBy: selectedSortBy.data,
        page: page);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
      selectedSortBy = sortByList.first;
    });
    if (candidateData == null) {
      setState(() {
        sortByList.removeWhere((element) => element.id == 3);
      });
    }
  }

  void _showDeleteModal(int articleId) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: SizedBox(
                width: 300,
                child: DeleteArticleModal(
                  onPressed: () => _deleteArticle(articleId),
                ),
              ),
            ));
  }

  void _deleteArticle(int articleId) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleDeleteRequestParams params = ArticleDeleteRequestParams(
        token: candidateData != null ? candidateData!['token'] : null,
        articleId: articleId);
    articleBloc.add(ArticleDeleteRequested(params: params));
  }
}

class SortByClass {
  final int id;
  final String title;
  final String data;

  SortByClass({required this.id, required this.title, required this.data});
}
