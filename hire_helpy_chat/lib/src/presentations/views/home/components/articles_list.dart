import 'dart:convert';

import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/core/utils/language_utils.dart';
import 'package:dh_employer/src/domain/entities/entities.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/views/articles_and_news/components/article_language_dropdown.dart';
import 'package:dh_employer/src/presentations/views/articles_and_news/components/delete_article_modal.dart';
import 'package:dh_employer/src/presentations/views/home/components/article_list_item.dart';
import 'package:dh_employer/src/presentations/views/views.dart';
import 'package:dh_employer/src/presentations/widgets/app_article_skeleton.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Map? employerData;
  SortByClass selectedSortBy =
      SortByClass(id: 1, title: "Latest", data: "latest");
  List<SortByClass> sortByList = [
    SortByClass(id: 1, title: "Latest", data: "latest"),
    SortByClass(id: 2, title: "Popular", data: "popular"),
    SortByClass(id: 3, title: "My Articles", data: "myArticles")
  ];
  bool isLoading = true;
  bool loadMore = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _getEmployerData();
    selectedSortBy = sortByList.first;
    initLoad();
    super.initState();
  }

  void initLoad() async {
    await _getLanguageData();
    _requestArticleList();
  }

  void _loadMoreData() {
    loadMore ? null : _requestArticleList();
    setState(() {
      loadMore = true;
    });
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final doubleOffset =
          _controller.offset + context.read<ArticleBloc>().perPage * 28.8;
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

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
      loadMore = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            _backButtonPressed();
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
        ));
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          _backButtonPressed();
        },
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      title: Text(
        StringConst.articleTitle.tr,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
      ),
      leadingWidth: 52,
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  void _backButtonPressed() {
    resetState;
    Get.offAllNamed(rootRoute);
  }

  //Language Data List with top Countries
  Future<void> _getLanguageData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    final lan = box.get(DBUtils.language);
    List<ConfigLanguage> dataList =
        await LanguageUtils.getArticleConfigLanguages();

    setState(() {
      languageList.addAll(dataList);
      selectedValue = languageList.singleWhere(
          (element) => element.language == lan,
          orElse: () => const ConfigLanguage(
              language: "English", languageName: "English"));
    });
  }

  // DH article listView container
  Widget get _getArticleListViewContainer => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          child: Column(
            children: [
              _getArticleListViewHeader,
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArticleLanguageDropDown(
                      disabled: isLoading,
                      initialValue: selectedValue,
                      languageList: languageList,
                      onValueChanged: (value) {
                        resetState;
                        setState(() {
                          selectedValue = value;
                        });
                        _requestArticleList();
                      },
                    ),
                    ArticleSortByDropDown(
                      disabled: isLoading,
                      sortByList: sortByList,
                      onValueChanged: (value) {
                        resetState;
                        setState(() {
                          selectedSortBy = value;
                        });
                        _requestArticleList();
                      },
                    ),
                  ],
                ),
              ),
              _getArticleListView()
            ],
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
            if (BlocProvider.of<ArticleBloc>(context).articleModel.data !=
                null) {
              if (BlocProvider.of<ArticleBloc>(context)
                      .articleModel
                      .data!
                      .data !=
                  null) {
                var datas = BlocProvider.of<ArticleBloc>(context)
                    .articleModel
                    .data!
                    .data!;
                if (datas.isNotEmpty) {
                  if (Get.parameters.isNotEmpty) {
                    final previewPageCreateArticle =
                        Get.parameters['preview'] ?? '';
                    if (previewPageCreateArticle == 'true') {
                      Get.parameters['preview'] = '';
                    }
                  }
                }
              }
            }
            loadMore ? _scrollDown() : null;
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
            resetState;
            _requestArticleList();
          }
          if (state is ArticleDeleteFail) {
            _setLoading(false);
            Navigator.pop(context);
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }
        });
  }

  void get resetState => BlocProvider.of<ArticleBloc>(context).resetState();

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
            if (employerData != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(articleCreate);
                  },
                  child: const Text(
                    'Create Article',
                    style: TextStyle(
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
      : BlocProvider.of<ArticleBloc>(context).articleModel.data == null
          ? const AppArticlesSkeleton(
              itemCount: 10,
            )
          : BlocProvider.of<ArticleBloc>(context).articleModel.data!.data ==
                  null
              ? const AppArticlesSkeleton(
                  itemCount: 10,
                )
              : BlocProvider.of<ArticleBloc>(context)
                      .articleModel
                      .data!
                      .data!
                      .isEmpty
                  ? Center(
                      child: Text(
                        "No data!",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      ),
                    )
                  : Column(
                      children: [
                        Wrap(
                          children: BlocProvider.of<ArticleBloc>(context)
                              .articleModel
                              .data!
                              .data!
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      var toNamedCall = Get.toNamed(
                                          articlesAndEventsDetailPageRoute,
                                          parameters: {
                                            'id': e.articleId.toString(),
                                            'route': articlesListPageRoute,
                                            'showLikes': 'true',
                                          });
                                      if (toNamedCall == null) return;
                                      toNamedCall.then((value) {
                                        if (value == 'delete') {
                                          _deleteArticle(e.articleId!);
                                        } else if (value == 'edit') {
                                          DBUtils.saveString(
                                            json.encode(e.toMap()),
                                            'article_update',
                                          );
                                          Get.offNamed(articleEditPageRoute);
                                        } else {
                                          _requestArticleList();
                                        }
                                      });
                                    },
                                    child: ArticleListItem(
                                      title: e.title ?? '',
                                      subtitle: e.content ?? '',
                                      createdAt:
                                          e.articleCreationDatetime ?? '',
                                      thumbnail: e.media!.isNotEmpty
                                          ? e.media!.first
                                                  .mediaThumbnailFilepath ??
                                              e.media!.first.mediaFilepath
                                          : '',
                                      creator: e.creator,
                                      articleId: e.articleId.toString(),
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
                                          DBUtils.saveString(
                                            json.encode(e.toMap()),
                                            'article_update',
                                          );
                                          Get.offNamed(articleEditPageRoute);
                                        }
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                        context.read<ArticleBloc>().nextPageUrl
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
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No More Data!",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 11.0)),
                              )
                      ],
                    );

  _requestArticleList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params = ArticlesListRequestParams(
        token: employerData != null ? employerData!['token'] : null,
        language: selectedValue.language ?? "English",
        sortBy: selectedSortBy.data,
        page: articleBloc.loadMorePage);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    if (employerData == null) {
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
        content: Builder(
          builder: (context) {
            return SizedBox(
              width: 300,
              child: DeleteArticleModal(
                onPressed: () => _deleteArticle(articleId),
              ),
            );
          },
        ),
      ),
    );
  }

  void _deleteArticle(int articleId) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleDeleteRequestParams params = ArticleDeleteRequestParams(
        token: employerData != null ? employerData!['token'] : null,
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
