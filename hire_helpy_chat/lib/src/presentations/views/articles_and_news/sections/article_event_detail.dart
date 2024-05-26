part of '../../views.dart';

class ArticleEventDetailSection extends StatefulWidget {
  const ArticleEventDetailSection({super.key});

  @override
  State<ArticleEventDetailSection> createState() =>
      _ArticleEventDetailSectionState();
}

class _ArticleEventDetailSectionState extends State<ArticleEventDetailSection> {
  final _scrollController = ScrollController();
  final _articleContainerKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textUpdateController = TextEditingController();

  bool isExpanded = false;
  bool showForm = true;
  String? _token;
  ArticleDetail? _articleDetail;
  int? articleId = 0;
  Map? employerData;
  bool _disableUpVote = false;
  bool _disableDownVote = false;
  List<String> _articleVotedUp = [];
  List<String> _articleVotedDown = [];
  List<String> _articleComplainList = [];
  String basePhotoUrl = '';
  String route = '';
  FocusNode focus = FocusNode();
  FocusNode focusUpdate = FocusNode();
  bool isKeyboardVisible = false;
  String responseName = '';
  bool isReplyComment = false;
  int? _commentId;
  bool isLoading = true;
  bool backDisabled = false;
  bool showLikes = false;
  List<Comment> comments = [];
  int currentPage = 0;
  int lastPage = 0;
  bool _upVoteEnabled = true;
  bool _downVoteEnabled = true;
  bool showScrollToTop = false;

  int? commentIdToBeDeleted;

  bool isEditingComment = false;
  Map<String, dynamic> editingComment = {
    'commentId': 0,
    'comment': '',
  };

  bool isLoggedIn = false;

  @override
  void initState() {
    _getPhotoUrl();
    _getemployerData();
    _checkIfUserIsLoggedIn();
    _getInitializeData();
    _textController.addListener(() {
      if (_textController.text.length >= kCommentCharacterLimitation) {
        showAlertLimitCharModal(context);
      }
    });
    initScrollListener();
    super.initState();
  }

  _checkIfUserIsLoggedIn() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      isLoggedIn = box.get(DBUtils.employerTableName) != null;
    });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void initScrollListener() {
    _scrollController.addListener(() {
      setState(() {
        showScrollToTop = _scrollController.offset >=
            (MediaQuery.of(context).size.height * 0.5);
      });

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = context.height * 0.2;
      final bool isLoading =
          context.read<ArticleBloc>().state is ArticlesGetCommentListLoading;
      if (!isLoading && maxScroll - currentScroll <= delta) {
        final canLoadMore = lastPage > currentPage;
        if (canLoadMore) _requestArticleComments(page: currentPage + 1);
      }
    });
  }

  /// set the id of the comment to be deleted to the state
  void setCommentIdToBeDeleted(int? commentId) {
    setState(() {
      commentIdToBeDeleted = commentId;
    });
  }

  void showAlertLimitCharModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogSimple(
          message:
              'You have hit the $kCommentCharacterLimitation character limit. Great job sharing your thoughts!',
          positiveText: 'OK',
          onButtonClick: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  _getCacheVoteUpData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? articleVoteUpCacheData = box.get('upvoted');

    if (articleVoteUpCacheData != null) {
      setState(() {
        _articleVotedUp = articleVoteUpCacheData;
        _disableUpVote =
            _articleVotedUp.contains(_articleDetail!.articleId.toString());
      });
    }
  }

  _getCacheVoteDownData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? articleVoteDownCacheData = box.get('downvoted');

    if (articleVoteDownCacheData != null) {
      setState(() {
        _articleVotedDown = articleVoteDownCacheData;
        _disableDownVote =
            _articleVotedDown.contains(_articleDetail!.articleId.toString());
      });
    }
  }

  _getComplainArticle() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? articleComplainCacheData = box.get('complained_articles');

    if (articleComplainCacheData != null) {
      setState(() {
        _articleComplainList = articleComplainCacheData;
      });
    }
  }

  /// checks if the article id is in the list of articles that have been complained
  bool get articleAlreadyComplained {
    if (_articleDetail == null) return false;
    return _articleComplainList.contains(_articleDetail!.articleId.toString());
  }

  @override
  void dispose() {
    _token = null;
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void setEditingComment(
      {required bool isEditing, String comment = '', int commentId = 0}) {
    setState(() {
      isEditingComment = isEditing;
      editingComment = {
        'commentId': commentId,
        'comment': comment,
      };
    });
    if (isEditing) {
      focusUpdate.requestFocus();
      _textUpdateController.text = comment;
    }
  }

  _getemployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);

    if (employerData != null) {
      _token = employerData!['token'];
    }
    if (Get.parameters.isNotEmpty) {
      articleId = int.parse(Get.parameters['id'].toString());
      _requestArticlesDetail();
    }
  }

  _requestCreateComment({required String text}) {
    //  _articleDetail = null;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCreateCommentCommentRequestParams params =
        ArticlesCreateCommentCommentRequestParams(
            token: employerData!['token'],
            articleId: articleId.toString(),
            message: text,
            userId: employerData!['user_id']);
    articleBloc.add(ArticlesCreateCommentCommentRequested(params: params));
    _textController.clear();
    FocusScope.of(context).unfocus();
    print("LAST PAGE IS");
    print(lastPage);
    _requestArticleComments(page: lastPage);
  }

  _requestArticlesDetail() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCommentListRequestParams params = ArticlesCommentListRequestParams(
      token: employerData != null ? employerData!['token'] : null,
      articleId: articleId,
    );
    articleBloc.add(ArticlesDetailRequested(params: params));
    responseName = '';
    setEditingComment(isEditing: false);
  }

  _requestReplyComment({required int commentId, String? message}) {
    // _articleDetail = null;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesReplyCommentRequestParams params =
        ArticlesReplyCommentRequestParams(
            token: employerData!['token'],
            commentId: commentId,
            replyMessage: message,
            userId: employerData!['user_id']);
    articleBloc.add(ArticlesReplyCommentRequested(params: params));
    _textController.clear();
    responseName = '';
    isReplyComment = false;
    FocusScope.of(context).unfocus();
    // _requestArticleComments();
  }

  _requestUpdateComment(int commentId, String updateMessage) {
    // _articleDetail = null;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesUpDateCommentRequestParams params =
        ArticlesUpDateCommentRequestParams(
      token: employerData!['token'],
      commentId: commentId,
      messageUpdate: updateMessage,
    );
    articleBloc.add(ArticlesUpdateCommentRequested(params: params));
    // _requestArticleComments();
  }

  _requestDeleteComment(int commentId) {
    //  _articleDetail = null;
    showForm = true;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesDeleteCommentRequestParams params =
        ArticlesDeleteCommentRequestParams(
      token: employerData!['token'],
      commentId: commentId,
    );
    articleBloc.add(ArticlesDeleteCommentRequested(params: params));
    setCommentIdToBeDeleted(commentId);
    // _requestArticleComments();
  }

  _requestCreateUpvoteArticle() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesUpvoteRequestParams params = ArticlesUpvoteRequestParams(
      token: employerData!['token'],
      articleId: articleId,
    );
    articleBloc.add(ArticlesCreateUpvoteRequested(params: params));
  }

  _requestCreateDownvoteArticle() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesDownvoteRequestParams params = ArticlesDownvoteRequestParams(
      token: employerData!['token'],
      articleId: articleId,
    );
    articleBloc.add(ArticlesCreateDownvoteRequested(params: params));
  }

  saveArticleVoted(
    String name,
    List<String> list,
  ) async {
    Box box = await Hive.openBox(DBUtils.dbName);
    box.put(name, list);
  }

  /// check if the article is voted
  ///
  /// @param type - upvoted or downvoted
  /// @param articleId - the article id
  ///
  /// @return bool
  bool isArticleVoted(String type, String articleId) {
    if (type == 'upvoted') {
      return _articleVotedUp.contains(articleId);
    } else if (type == 'downvoted') {
      return _articleVotedDown.contains(articleId);
    }
    return false;
  }

  void _getPhotoUrl() async {
    String? data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data ?? '';
    });
  }

  /// on comment success update the comment in the list of comments
  ///
  /// if the comment is a reply, update the reply in the list of replies
  /// else update the comment in the list of comments
  void onCommentUpdateSuccess(DataResponseModel articleData) {
    if (articleData.data == null) return;
    try {
      final data = articleData.data!['data'];
      final commentId = data['article_comment_id'];
      final commentChildId = data['article_comment_child_id'];

      if (commentChildId != null) {
        for (final comment in comments) {
          if (_updateReplyInComment(
              comment, commentId, data['article_comment'])) {
            setState(() {});
            return;
          }
        }
      } else {
        final commentById = comments.firstWhereOrNull(
          (comment) => comment.id == commentId,
        );
        if (commentById != null) {
          commentById.articleComment = data['article_comment'];
          commentById.updatedAt = DateTime.now().toString();
          int index = comments.indexWhere((comment) => comment.id == commentId);
          comments[index] = commentById;
          setState(() {});
        }
      }
    } catch (e) {
      print("LOG => ERROR ON COMMENT UPDATE SUCCESS $e");
    }
  }

  bool _updateReplyInComment(
      Comment comment, int commentId, String newComment) {
    for (final reply in (comment.replies ?? <Replies>[])) {
      if (reply.commenterId == commentId) {
        reply.comment = newComment;
        reply.updatedAt = DateTime.now().toString();
        return true;
      }
      if (_updateReplyInReplies(reply.replies, commentId, newComment)) {
        return true;
      }
    }
    return false;
  }

  bool _updateReplyInReplies(
      List<Replies>? replies, int commentId, String newComment) {
    if (replies == null) return false;
    for (final reply in replies) {
      if (reply.commenterId == commentId) {
        reply.comment = newComment;
        reply.updatedAt = DateTime.now().toString();
        return true;
      }
      if (_updateReplyInReplies(reply.replies, commentId, newComment)) {
        return true;
      }
    }
    return false;
  }

  /// remove comment by id from the list of comments
  void removeCommentById(int? commentId) {
    if (commentId == null) return;
    final commentById = comments.firstWhereOrNull(
      (comment) => comment.id == commentId,
    );
    if (commentById != null) {
      commentById.deletedAt = DateTime.now().toString();
      if (commentById.replies != null) {
        commentById.replies = [];
      }
      setState(() {});
    } else {
      _markCommentRepliesAsDeleted(commentId);
    }
    setState(() {});
    setCommentIdToBeDeleted(null);
  }

  void _markCommentRepliesAsDeleted(int? commentId) {
    if (commentId == null) return;
    for (var comment in comments) {
      _markRepliesAsDeleted(comment.replies, commentId);
    }
  }

  void _markRepliesAsDeleted(List<Replies>? replies, int commentId) {
    if (replies == null) return;
    for (var reply in replies) {
      if (reply.commenterId == commentId) {
        reply.deletedAt = DateTime.now().toString();
        return;
      }
      _markRepliesAsDeleted(reply.replies, commentId);
    }
  }

  /// on reply success, add the reply to associated comment or reply
  void onCommentReplySuccess(DataResponseModel articleData) {
    if (articleData.data == null) return;
    try {
      final data = articleData.data!['data'];
      final articleCommentId = data['parent']['article_comment_id'];
      final replyMsg = Replies(
        data['article_comment_id'],
        comment: data['article_comment'],
        userId: data['user_id'],
        commenter: Commenter(
          userId: data!['commenter']['user_id'],
          firstName: data!['commenter']['first_name'],
          lastName: data!['commenter']['last_name'],
          avatar: data!['commenter']['avatar_s3_filepath'],
        ),
        parentCommentId: int.tryParse(data['article_comment_child_id']),
      );
      _addReplyToCommentOrReply(comments, articleCommentId, replyMsg);
      setState(() {});
    } catch (e) {
      print("LOG => ERROR ON COMMENT REPLY SUCCESS $e");
    }
  }

  void _addReplyToCommentOrReply(
    List<Comment> comments,
    int articleCommentId,
    Replies replyMsg,
  ) {
    for (var comment in comments) {
      if (comment.id == articleCommentId) {
        if (comment.replies == null) {
          comment.replies = [replyMsg];
        } else {
          comment.replies!.add(replyMsg);
        }
        return;
      }

      if (comment.replies != null) {
        _addReplyToReply(comment.replies ?? [], articleCommentId, replyMsg);
      }
    }
  }

  void _addReplyToReply(
    List<Replies> replies,
    int articleCommentId,
    Replies replyMsg,
  ) {
    for (var reply in replies) {
      if (reply.commenterId == articleCommentId) {
        if (reply.replies == null || reply.replies!.isEmpty) {
          reply.replies = [replyMsg];
        } else {
          reply.replies!.add(replyMsg);
        }
        return;
      }

      if (reply.replies != null) {
        _addReplyToReply(reply.replies ?? [], articleCommentId, replyMsg);
      }
    }
  }

  /// check if the loggedin user is the owner of the article
  bool get isTheOwner {
    if (employerData == null || _articleDetail == null) return false;
    return employerData!['user_id'] == _articleDetail!.creator!.userId;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    isKeyboardVisible = mediaQuery.viewInsets.bottom > 0;
    return WillPopScope(
        onWillPop: () async {
          if (backDisabled) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('pleaseWait'.tr)));
            return false;
          }
          if (route != '') {
            if (route == articlesListPageRoute) {
              Get.back();
            } else {
              BlocProvider.of<ArticleBloc>(context).resetState();
              Get.toNamed(articlesListPageRoute);
            }
          } else {
            Get.offAllNamed(rootRoute);
          }
          return false;
        },
        child: BackgroundScaffold(scaffold: _getArticleEventScaffold));
  }

  Scaffold get _getArticleEventScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _getArticleEventDetailContainer,
            if (showScrollToTop && !isKeyboardVisible) _scrollToTopButton,
          ],
        ),
      ),
    );
  }

  Widget get _scrollToTopButton {
    return Positioned(
      bottom: 100,
      right: 15,
      child: FloatingActionButton(
        backgroundColor: AppColors.indigoA100Da,
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        mini: true,
        child: const Icon(Iconsax.arrow_up),
      ),
    );
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            if (backDisabled) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('pleaseWait'.tr)));
              return;
            }
            if (route != '') {
              if (route == articlesListPageRoute) {
                Get.back();
              } else {
                BlocProvider.of<ArticleBloc>(context).resetState();
                Get.toNamed(articlesListPageRoute);
              }
            } else {
              Get.offAllNamed(rootRoute);
            }
          },
          child: Opacity(
              opacity: backDisabled ? 0.4 : 1.0,
              child: const Icon(
                Iconsax.arrow_left,
                color: AppColors.white,
              )),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.articleTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w100,
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: [
          if (isLoggedIn)
            IconButton(
              onPressed: showArticleOptions,
              icon: const Icon(Icons.more_vert, color: AppColors.white),
            ),
        ],
      );

  Widget get _getArticleEventDetailContainer {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return isLoading
            ? LoadingScaffold.getLoading()
            : _articleDetail != null
                ? _getArticleDetailListView
                : const Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
      },
      listener: (_, state) {
        if (state is ArticleDetailLoading) {
          _setLoading(true);
        }
        if (state is ArticlesCreateUpvoteSuccess) {
          var result = state.upVoteDate.data!['message'];
          var articleId = state.upVoteDate.data!['data']['article_id'];
          if (result == 'Upvote Saved.') {
            _articleVotedUp.add(articleId.toString());
            saveArticleVoted('upvoted', _articleVotedUp);
          }
          _getCacheVoteUpData();
        }
        if (state is ArticlesCreateDownvoteSuccess) {
          var result = state.downVoteData.data!['message'];
          var articleId = state.downVoteData.data!['data']['article_id'];
          if (result == 'Downvote Saved.') {
            _articleVotedDown.add(articleId.toString());
            saveArticleVoted('downvoted', _articleVotedDown);
          }
          _getCacheVoteDownData();
        }

        if (state is ArticlesGetCommentListSuccess) {
          final dataMap = state.articleData.data;
          if (dataMap != null) {
            List<Comment> data = List<Comment>.from(
                (dataMap['data']['data'] as List<dynamic>)
                    .map((e) => Comment.fromJson(e as Map<String, dynamic>)));

            if (lastPage == 1) comments.clear();
            comments.addAll(data);
            comments.map((e) {
              if (e.deletedAt != null) {
                e.replies = [];
              }
            }).toList();
            showForm = true;
            currentPage = dataMap['data']['current_page'];
            lastPage = dataMap['data']['last_page'];
            setState(() {});
          }
        }

        if (state is ArticleDetailSuccess) {
          _setLoading(false);
          final tempArticleDetail =
              ArticleDetailModel.fromJson(state.articleData.data!['data']);
          print(tempArticleDetail);
          setState(() {
            _articleDetail = tempArticleDetail;
            showFormField();
          });

          _getCacheVoteUpData();
          _getCacheVoteDownData();
          _getComplainArticle();
          if (_articleDetail!.category! == "USER_GENERATED_CONTENT") {
            _requestArticleComments();
          }
        }

        if (state is ArticleDetailFail) {
          Get.offNamed(emptyArticlePageRoute);
          // if (route != '') {
          //   BlocProvider.of<ArticleBloc>(context).resetState();
          //   Get.toNamed(articlesListPageRoute);
          // } else {
          //   Get.offAllNamed(rootRoute);
          // }
          // showErrorSnackBar('articleDeletedError'.tr);
        }

        if (state is ArticleCreateComplainSuccess) {
          if (state.newsData.data != null) {
            showInfoModal(
              title: 'This article has been successfully reported.',
              message:
                  'Thanks for contributing to Phluid community to be a better place.',
              type: 'success',
              barrierDismissible: true,
              durationInSec: 3,
            );
            _setDisableBack(false);
            _articleComplainList.add(articleId.toString());
            saveArticleVoted('complained_articles', _articleComplainList);
          } else if (state.newsData.data == null) {
            Get.offAllNamed(emptyArticlePageRoute);
          }
          _getComplainArticle();
          _setLoading(false);
        }

        if (state is CommentCreateComplainSuccess) {
          _setLoading(false);
          if (state.newsData.data != null) {
            showInfoModal(
              title: 'This comment has been successfully reported.',
              message:
                  'Thanks for contributing to Phluid community to be a better place.',
              type: 'success',
            );

            /// refetch the comments
            currentPage = 1;
            lastPage = 1;
            _requestArticleComments();
          }
        }

        if (state is ArticleCreateComplainFail) {
          _setDisableBack(false);
          _setLoading(false);
          if (state.message != '') {
            showSuccessSnackBar(state.message);
          }
        }

        if (state is ArticlesCreateUpvoteSuccess) {
          setState(() => _upVoteEnabled = false);
        }
        if (state is ArticlesCreateUpvoteFail) {
          _setLoading(false);
          if (state.message != '') {
            showSuccessSnackBar(state.message);
          }
        }
        if (state is ArticlesCreateDownvoteSuccess) {
          setState(() => _downVoteEnabled = false);
        }

        if (state is ArticlesCreateDownvoteFail) {
          _setLoading(false);
          if (state.message != '') {
            showSuccessSnackBar(state.message);
          }
        }

        if (state is ArticlesCreateCommentFail) {
          _setLoading(false);
          if (state.message != '') {
            showSuccessSnackBar(state.message);
          }
        }

        if (state is ArticlesCreateCommentSuccess) {
          Future.delayed(const Duration(milliseconds: 500), () {
            scrollToBottom();
          });
        }
        // if (state is ArticlesReplyCommentSuccess ||
        //     state is ArticlesUpdateCommentSuccess) {
        //   Future.delayed(const Duration(milliseconds: 500), () {
        //     scrollToCommentIndex();
        //   });
        // }

        if (state is ArticlesUpdateCommentSuccess) {
          onCommentUpdateSuccess(state.articleData);
        }

        if (state is ArticlesDeleteCommentSuccess) {
          removeCommentById(commentIdToBeDeleted);
          showInfoModal(
            title: 'Your comment has been successfully deleted.',
            type: 'success',
          );
        }
        if (state is ArticlesReplyCommentSuccess) {
          onCommentReplySuccess(state.articleData);
        }
      },
    );
  }

  Widget get _getArticleDetailListView {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              setEditingComment(isEditing: false);
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            //_articleDetail!.comments!.length < 3 ? MediaQuery.of(context).size.height : null,
            padding: EdgeInsets.only(
                left: 20, right: 20, bottom: isLoggedIn ? 60 : 90),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    key: _articleContainerKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _articleDetail!.title ?? '',
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w100),
                        ),
                        _getDateAndCreator(),
                        _getImageDetail,
                        _getContentDetail,
                        const Divider(color: AppColors.secondaryGrey),
                        _getLikesAndShare,
                      ],
                    ),
                  ),
                  if (_articleDetail!.category! == "USER_GENERATED_CONTENT")
                    _getCommentContent,
                ],
              ),
            ),
          ),
        ),
        if (!isLoggedIn)
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [logInToComment()],
          ),
        if (isLoggedIn) ...[
          /// update the comment form
          Visibility(
            visible: isEditingComment,
            child: CommentForm(
              isReply: false,
              toUser: '',
              onSubmit: (value) {
                _checkCommentUpdateValidation(
                    editingComment['commentId'], value);
              },
              isKeyboardVisible: isKeyboardVisible,
              textController: _textUpdateController,
              isReplyComment: false,
              responseName: '',
              focus: focusUpdate,
            ),
          ),

          /// reply comment form
          Visibility(
            visible: showForm && !isEditingComment && _token != null,
            child: CommentForm(
              isReply: isReplyComment,
              toUser: responseName,
              onSubmit: (value) => _checkCommentCreateValidation(value),
              isKeyboardVisible: isKeyboardVisible,
              textController: _textController,
              isReplyComment: isReplyComment,
              responseName: '',
              focus: focus,
              onCancel: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isReplyComment = false;
                  responseName = '';
                });
              },
            ),
          ),
        ]
      ],
    );
  }

  Widget logInToComment() {
    return Column(
      children: [
        const Text(
          "Only Login user can Comment on Post.",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 12,
              fontWeight: FontWeight.w100),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: SizedBox(
            width: 330,
            child: CustomPrimaryButton(
              text: StringConst.gotoLoginText,
              onPressed: () => Get.offAllNamed(signInPageRoute),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getDateAndCreator() {
    return Padding(
        padding: const EdgeInsets.only(right: 12, top: 8, bottom: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getDateCreatedAtDetail(_articleDetail!.createdAt!),
              _articleDetail!.creator == null
                  ? Container()
                  : ArticleProfileDisplay(creator: _articleDetail!.creator!),
            ]));
  }

  Widget get _getRequestLogin {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Text(
            "Sign in to like and comment article",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w100),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: 330,
                child: CustomPrimaryButton(
                    text: StringConst.getStartedText,
                    onPressed: () => Get.offAllNamed(signInPageRoute)),
              )),
        ],
      ),
    );
  }

  bool isVideoFile(String fileName) {
    RegExp regExp = RegExp(
      r'\.(mp4|avi|flv|wmv|mov|mkv|webm)$',
      caseSensitive: false,
    );
    return regExp.hasMatch(fileName);
  }

  Widget get _getImageDetail {
    return ImageSlider(media: _articleDetail!.media);
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

    return Row(
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
    );
  }

  Widget get _getContentDetail {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: LayoutBuilder(builder: (context, size) {
        const int maxLines = 5;

        final contentTextSpan = TextSpan(
            text: _articleDetail!.content ?? '',
            style: TextStyle(
              color: AppColors.secondaryGrey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 14,
            ));

        final TextPainter textPainter = TextPainter(
          text: contentTextSpan,
          textAlign: TextAlign.justify,
          maxLines: maxLines,
          textDirection: Directionality.of(context),
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
        )..layout(minWidth: size.minWidth, maxWidth: size.maxWidth);

        final contentWillOverflow = textPainter.didExceedMaxLines;

        return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text.rich(
            contentTextSpan,
            textAlign: TextAlign.justify,
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          contentWillOverflow
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    !isExpanded ? 'See more' : 'See less',
                    style: const TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : const SizedBox(
                  height: 10,
                ),
        ]);
      }),
    );
  }

  Widget get _getLikesAndShare {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: !isLoggedIn
                          ? null
                          : () => _disableUpVote || !_upVoteEnabled
                              ? showErrorSnackBar(
                                  "This article has already been up voted.")
                              : _requestCreateUpvoteArticle(),
                      child: Icon(
                        Iconsax.like_1,
                        color: isArticleVoted('upvoted', "$articleId")
                            ? AppColors.primaryColor
                            : AppColors.white,
                        size: 20,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  buildUpvote,
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: !isLoggedIn
                          ? null
                          : () => _disableDownVote || !_downVoteEnabled
                              ? showErrorSnackBar(
                                  "This article has already been down voted.")
                              : _requestCreateDownvoteArticle(),
                      child: Icon(
                        Iconsax.dislike,
                        color: isArticleVoted('downvoted', "$articleId")
                            ? AppColors.primaryColor
                            : AppColors.white,
                        size: 20,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  buildDownvote,
                ],
              ),
              _getArticleShare
            ],
          ),
        )
      ],
    );
  }

  void showFormField() {
    setState(() {
      showForm = true;
    });
  }

  Widget get _getCommentContent {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comments.isEmpty ? _emptyCommentList : _commentAndReplyList,
          if (context.read<ArticleBloc>().state
              is ArticlesGetCommentListLoading)
            const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  void getInfoComment({required int commentId, required String userName}) {
    focus.requestFocus();
    setState(() {
      responseName = userName;
      _commentId = commentId;
      isReplyComment = true;
    });
  }

  void showDeleteCommentDialog(
    BuildContext context,
    int commentUserId,
    int commentId,
  ) {
    int userId = employerData!['user_id'];
    if (userId != commentUserId) return;
    showDialog(
      context: context,
      builder: (context) => CustomDialogSimple(
        message: 'Are you sure you want to delete the comment?',
        negativeText: 'Cancel',
        positiveText: 'Yes',
        onButtonClick: () {
          _requestDeleteComment(commentId);
          Navigator.pop(context);
        },
      ),
    );
    // userId == commentUserId
    //     ? showDialog(
    //         context: context,
    //         builder: (context) => CustomDialogSimple(
    //           message: 'Are you sure you want to delete the comment?',
    //           negativeText: 'Cancel',
    //           positiveText: 'Yes',
    //           onButtonClick: () {
    //             _requestDeleteComment(commentId);
    //             Navigator.pop(context);
    //           },
    //         ),
    //       )
    //     : showDialog(
    //         context: context,
    //         builder: (context) => CustomDialogSimple(
    //           message: 'You cannot delete another user comment',
    //           positiveText: 'Yes',
    //           onButtonClick: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       );
  }

  Widget get buildUpvote {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticlesCreateUpvoteLoading) {
          return const SizedBox(
            height: 8,
            width: 8,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        } else if (state is ArticlesCreateUpvoteSuccess) {
          int newUpvote = state.upVoteDate.data!['data']['up_vote_count'];
          _articleDetail?.upvote = newUpvote;
          return Text(
            _articleDetail?.upvote != null
                ? _articleDetail!.upvote.toString()
                : '0',
            style: const TextStyle(fontSize: 10, color: AppColors.white),
          );
        } else {
          return Text(
            _articleDetail?.upvote != null
                ? _articleDetail!.upvote.toString()
                : '0',
            style: const TextStyle(fontSize: 10, color: AppColors.white),
          );
        }
      },
    );
  }

  Widget get buildDownvote {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticlesCreateDownvoteLoading) {
          return const SizedBox(
            height: 8,
            width: 8,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        } else if (state is ArticlesCreateDownvoteSuccess) {
          int newDownvote = state.downVoteData.data!['data']['down_vote_count'];
          _articleDetail?.downvote = newDownvote;
          return Text(
            _articleDetail?.downvote != null
                ? _articleDetail!.downvote.toString()
                : '0',
            style: const TextStyle(fontSize: 10, color: AppColors.white),
          );
        } else {
          return Text(
            _articleDetail?.downvote != null
                ? _articleDetail!.downvote.toString()
                : '0',
            style: const TextStyle(fontSize: 10, color: AppColors.white),
          );
        }
      },
    );
  }

  void _getInitializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      showLikes = Get.parameters['showLikes'] == 'true';
    }
  }

  void _complainArticle() {
    if (articleAlreadyComplained) {
      showInfoModal(
        title: 'You have already reported this article.',
        message:
            'Thanks for contributing to Phluid community to be a better place.',
        type: 'info',
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => CustomDialogSimple(
        message: 'Are you sure you want to report this article?',
        negativeText: 'Cancel',
        positiveText: 'Yes',
        onButtonClick: () {
          _requestComplainArticle();
          _setDisableBack(true);
          _setLoading(true);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _requestComplainArticle() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleCreateComplainRequestParams params =
        ArticleCreateComplainRequestParams(
            token: employerData != null ? employerData!['token'] : null,
            articleId: articleId);
    articleBloc.add(ArticleCreateComplainRequested(params: params));
  }

  Widget get _commentAndReplyList {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return buildCommentAndReplies(comments[index], index);
      },
    );
  }

  Widget buildCommentAndReplies(Comment comment, int commentIndex) {
    final shortName = StringUtils.getShortName(
        '${comment.commenter?.firstName}', '${comment.commenter?.lastName}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentItem(
          user: shortName,
          comment: comment.articleComment,
          urlImage: comment.commenter?.avatar ?? '',
          length: (comment.replies ?? [])
              .where((e) => e.deletedAt == null)
              .length
              .toString(),
          onReply: () {
            getInfoComment(
              commentId: comment.id!,
              userName: StringUtils.getShortName(
                '${comment.commenter?.firstName}',
                '${comment.commenter?.lastName}',
              ),
            );
          },
          isComment: true,
          commentId: comment.id!,
          userId: comment.userId,
          isEditing: editingComment['commentId'] == comment.id,
          isUpdated: comment.updatedAt != null,
          isDeleted: comment.deletedAt != null,
          onEditComment: () {
            setEditingComment(
              isEditing: true,
              commentId: comment.id!,
              comment: comment.articleComment ?? '',
            );
          },
          onDeleteComment: () {
            showDeleteCommentDialog(
              context,
              comment.userId ?? 0,
              comment.id!,
            );
          },
          onReportComment: () => _setLoading(true),
        ),
        if (comment.replies != null)
          for (var reply in comment.replies!)
            buildRepliesAndReplies(reply, shortName, 25),
      ],
    );
  }

  Widget buildRepliesAndReplies(
    Replies reply,
    String parentShortName, [
    double indent = 0,
    bool isReply = true,
  ]) {
    final shortName = StringUtils.getShortName(
        reply.commenter?.firstName ?? '', reply.commenter?.lastName ?? '');
    final double maxIntend = indent >= 50 ? 50 : indent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: maxIntend),
          child: CommentItem(
            user: shortName,
            comment: reply.comment,
            urlImage: reply.commenter?.avatar,
            isComment: false,
            isReply: isReply,
            commentId: reply.commenterId ?? 0,
            replyToUser: parentShortName,
            onReply: () {
              getInfoComment(
                commentId: reply.commenterId ?? 0,
                userName: shortName,
              );
            },
            length: (reply.replies ?? [])
                .where((e) => e.deletedAt == null)
                .length
                .toString(),
            userId: reply.userId ?? 0,
            isEditing: editingComment['commentId'] == reply.commenterId,
            isUpdated: reply.updatedAt != null,
            isDeleted: reply.deletedAt != null,
            onEditComment: () {
              setEditingComment(
                isEditing: true,
                commentId: reply.commenterId!,
                comment: reply.comment ?? '',
              );
            },
            onDeleteComment: () {
              showDeleteCommentDialog(
                context,
                reply.userId ?? 0,
                reply.commenterId ?? 0,
              );
            },
            onReportComment: () => _setLoading(true),
          ),
        ),
        if (reply.replies != null)
          for (var nestedReply in reply.replies!)
            buildRepliesAndReplies(
              nestedReply,
              reply.deletedAt != null ? 'Deleted Reply' : shortName,
              indent + 25,
              false,
            ),
      ],
    );
  }

  Widget get _emptyCommentList {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'No Comments yet.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _setDisableBack(bool value) {
    setState(() {
      backDisabled = value;
    });
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  //Check Commect/Reply Create Validation
  _checkCommentCreateValidation(String value) {
    if (value.isEmpty) {
      showErrorSnackBar("You cannot send empty comment.");
      return;
    }
    FocusScope.of(context).unfocus();
    if (value.length > kCommentCharacterLimitation) {
      showAlertLimitCharModal(context);
    } else if (isReplyComment) {
      _requestReplyComment(commentId: _commentId!, message: value);
    } else if (!isReplyComment) {
      _requestCreateComment(text: value);
    } else {}
  }

  //Check Commect/Reply update Validation
  _checkCommentUpdateValidation(int commentId, String value) {
    if (value.isEmpty) {
      showErrorSnackBar("You cannot update empty comment.");
      return;
    }
    if (value.length > kCommentCharacterLimitation) {
      showAlertLimitCharModal(context);
    }
    FocusScope.of(context).unfocus();
    _requestUpdateComment(commentId, value);
    setEditingComment(isEditing: false);
    _textUpdateController.clear();
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
        text: StringConst.shareArticleText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  _getShareLink() async {
    return await ShortLink.createArticleShortLink(
        articleId.toString(), kArticleShortLink, 'articles');
  }

  _requestArticleComments({int? page}) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCommentListRequestParams params = ArticlesCommentListRequestParams(
      token: employerData != null ? employerData!['token'] : null,
      articleId: articleId,
      page: page,
    );
    articleBloc.add(ArticlesGetCommentRequested(params: params));
    setState(() {
      responseName = '';
      isEditingComment = false;
    });
  }

  void showArticleOptions() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      items: <PopupMenuEntry<dynamic>>[
        if (!isTheOwner)
          PopupMenuItem(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Report article'),
              onTap: () {
                Navigator.pop(context);
                _complainArticle();
              },
            ),
          ),
        if (isTheOwner) ...[
          PopupMenuItem(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Edit article'),
              onTap: () {
                Navigator.pop(context);
                if (_articleDetail != null &&
                    _articleDetail!.articleId != null) {
                  Navigator.pop(context, 'edit');
                }
              },
            ),
          ),
          const CustomPopupMenuDivider(
            height: 1,
            color: AppColors.black,
            indent: 15,
            endIndent: 15,
          ),
          PopupMenuItem(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Delete article'),
              onTap: () {
                Navigator.pop(context);
                if (_articleDetail != null &&
                    _articleDetail!.articleId != null) {
                  _showDeleteArticleModal(_articleDetail!.articleId!);
                }
              },
            ),
          ),
        ],
      ],
    );
  }

  void _showDeleteArticleModal(int articleId) {
    showDialog(
      context: context,
      builder: (context) => CustomDialogSimple(
        message: 'Are you sure you want to delete the article?',
        negativeText: 'Cancel',
        positiveText: 'Yes',
        onButtonClick: () {
          Navigator.pop(context);
          final articleBloc = BlocProvider.of<ArticleBloc>(context);
          final params = ArticleDeleteRequestParams(
            token: employerData != null ? employerData!['token'] : null,
            articleId: articleId,
          );
          articleBloc.add(ArticleDeleteRequested(params: params));
        },
      ),
    );
  }
}

class CustomPopupMenuDivider extends PopupMenuEntry<Never> {
  const CustomPopupMenuDivider({
    super.key,
    this.height = 16,
    this.color,
    this.indent,
    this.endIndent,
  });
  @override
  final double height;

  final Color? color;
  final double? indent;
  final double? endIndent;

  @override
  bool represents(void value) => false;

  @override
  State<CustomPopupMenuDivider> createState() => _PopupMenuDividerState();
}

class _PopupMenuDividerState extends State<CustomPopupMenuDivider> {
  @override
  Widget build(BuildContext context) => Divider(
        height: widget.height,
        color: widget.color,
        indent: widget.indent,
        endIndent: widget.endIndent,
      );
}
