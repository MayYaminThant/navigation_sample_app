part of '../../views.dart';

class ArticleEventDetailSection extends StatefulWidget {
  const ArticleEventDetailSection({super.key});

  @override
  State<ArticleEventDetailSection> createState() =>
      _ArticleEventDetailSectionState();
}

class _ArticleEventDetailSectionState extends State<ArticleEventDetailSection> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textUpdateController = TextEditingController();
  late Box box;
  final ScrollController _scrollController = ScrollController();
  bool isExpanded = false;
  bool showForm = true;
  String? _token;
  ArticleDetail? _articleDetail;
  int? articleId = 0;
  Map? candidateData;
  bool _disableUpVote = false;
  bool _disableDownVote = false;
  List<String> _articleVotedUp = [];
  List<String> _articleVotedDown = [];
  List<String> _articleComplainList = [];
  String route = '';
  FocusNode focus = FocusNode();
  FocusNode focusUpdate = FocusNode();
  bool isKeyboardVisible = false;
  String responseName = '';
  bool isReplyComment = false;
  int? _commentId;
  bool isLoading = true;
  bool showLikes = false;
  List<Comment> comments = [];
  int currentPage = 0;
  int lastPage = 0;
  bool _upVoteEnabled = true;
  bool _downVoteEnabled = true;
  bool commentLoading = true;
  bool _isComplaining = false;
  bool showScrollToTop = false;
  int? commentIdToBeDeleted;

  bool isEditingComment = false;
  Map<String, dynamic> editingComment = {
    'commentId': 0,
    'comment': '',
  };
  bool isLoggedIn = false;

  @override
  void dispose() {
    _token = null;
    _scrollController.dispose();
    _textController.dispose();
    _textUpdateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initLoad();
    _getInitializeData();
    _textController.addListener(() {
      if (_textController.text.length >= kCommentCharacterLimitation) {
        showAlertLimitCharModal(context);
      }
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
  }

  void _getInitializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      showLikes = Get.parameters['showLikes'] == 'true';
    }
  }

  Future<void> _getCandidateData() async {
    box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    setState(() {
      isLoggedIn = candidateData != null;
    });

    if (candidateData != null) {
      _token = candidateData!['token'];
    }
    if (Get.parameters.isNotEmpty) {
      articleId = int.parse(Get.parameters['id'].toString());
      _requestArticlesDetail();
    }
  }

  void _requestComplainArticle() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleCreateComplainRequestParams params =
        ArticleCreateComplainRequestParams(
            token: candidateData != null ? candidateData!['token'] : null,
            articleId: articleId);
    articleBloc.add(ArticleCreateComplainRequested(params: params));
  }

  void _requestArticleComments({int? page}) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCommentListRequestParams params = ArticlesCommentListRequestParams(
      token: candidateData != null ? candidateData!['token'] : null,
      articleId: articleId,
      page: page ?? 1,
    );
    articleBloc.add(ArticlesGetCommentRequested(params: params));
    setState(() {
      responseName = '';
      isEditingComment = false;
    });
  }

  void _requestCreateComment({required String text}) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCreateCommentCommentRequestParams params =
        ArticlesCreateCommentCommentRequestParams(
            token: candidateData!['token'],
            articleId: articleId.toString(),
            message: text,
            userId: candidateData!['user_id']);
    articleBloc.add(ArticlesCreateCommentCommentRequested(params: params));
    _textController.clear();
    FocusScope.of(context).unfocus();
    _requestArticleComments(page: lastPage);
  }

  void _requestArticlesDetail() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCommentListRequestParams params = ArticlesCommentListRequestParams(
      token: candidateData != null ? candidateData!['token'] : null,
      articleId: articleId,
    );
    articleBloc.add(ArticlesDetailRequested(params: params));
    responseName = '';
    setEditingComment(isEditing: false);
  }

  void _requestReplyComment({required int commentId, String? message}) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesReplyCommentRequestParams params =
        ArticlesReplyCommentRequestParams(
            token: candidateData!['token'],
            commentId: commentId,
            replyMessage: message,
            userId: candidateData!['user_id']);
    articleBloc.add(ArticlesReplyCommentRequested(params: params));
    _textController.clear();
    responseName = '';
    isReplyComment = false;
    FocusScope.of(context).unfocus();
    // _requestArticleComments(page: currentPage);
  }

  void _requestUpdateComment(int commentId, String updateMessage) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesUpDateCommentRequestParams params =
        ArticlesUpDateCommentRequestParams(
      token: candidateData!['token'],
      commentId: commentId,
      messageUpdate: updateMessage,
    );
    articleBloc.add(ArticlesUpdateCommentRequested(params: params));
    // _requestArticleComments(page: currentPage);
  }

  void _requestDeleteComment(int commentId) {
    showForm = true;
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesDeleteCommentRequestParams params =
        ArticlesDeleteCommentRequestParams(
      token: candidateData!['token'],
      commentId: commentId,
    );
    articleBloc.add(ArticlesDeleteCommentRequested(params: params));
    setCommentIdToBeDeleted(commentId);
    // _requestArticleComments(page: currentPage);
  }

  void _requestCreateUpvoteArticle() {
    setState(() {
      _upVoteEnabled = false;
    });
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesUpvoteRequestParams params = ArticlesUpvoteRequestParams(
      token: candidateData!['token'],
      articleId: articleId,
    );
    articleBloc.add(ArticlesCreateUpvoteRequested(params: params));
  }

  void _requestCreateDownvoteArticle() {
    setState(() {
      _downVoteEnabled = false;
    });
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesDownvoteRequestParams params = ArticlesDownvoteRequestParams(
      token: candidateData!['token'],
      articleId: articleId,
    );
    articleBloc.add(ArticlesCreateDownvoteRequested(params: params));
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
        // Comment? parentComment;
        // Replies? replyById;
        // Replies? subReplyById;

        // for (final comment in comments) {
        //   for (final reply in (comment.replies ?? [])) {
        //     if (reply.commenterId == commentId) {
        //       replyById = reply;
        //       parentComment = comment;
        //       break;
        //     }
        //     for (final subReply in (reply.replies ?? [])) {
        //       if (subReply.commenterId == commentId) {
        //         replyById = reply;
        //         subReplyById = subReply;
        //         parentComment = comment;
        //         break;
        //       }
        //     }
        //   }
        // }

        // if (parentComment == null) throw Exception("Parent comment is null");

        // if (replyById != null && subReplyById != null) {
        //   subReplyById.comment = data['article_comment'];
        //   subReplyById.updatedAt = DateTime.now().toString();
        //   int commentIndex = comments.indexOf(parentComment);
        //   int replyIndex = comments[commentIndex].replies!.indexOf(replyById);
        //   int subReplyIndex = comments[commentIndex]
        //       .replies![replyIndex]
        //       .replies!
        //       .indexOf(subReplyById);
        //   comments[commentIndex].replies![replyIndex].replies![subReplyIndex] =
        //       subReplyById;
        //   setState(() {});
        // } else if (replyById != null) {
        //   replyById.comment = data['article_comment'];
        //   replyById.updatedAt = DateTime.now().toString();
        //   int commentIndex = comments.indexOf(parentComment);
        //   int replyIndex = comments[commentIndex].replies!.indexOf(replyById);
        //   comments[commentIndex].replies![replyIndex] = replyById;
        //   setState(() {});
        // } else {}
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

  setkeyboardVisible(bool value) {
    isKeyboardVisible = value;
  }

  /// check if the loggedin user is the owner of the article
  bool get isTheOwner {
    if (candidateData == null || _articleDetail == null) return false;
    return candidateData!['user_id'] == _articleDetail!.creator!.userId;
  }

  /// checks if the article id is in the list of articles that have been complained
  bool get articleAlreadyComplained {
    if (_articleDetail == null) return false;
    return _articleComplainList.contains(_articleDetail!.articleId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    setkeyboardVisible(mediaQuery.viewInsets.bottom > 0);

    return BackgroundScaffold(
        availableBack: false,
        onWillPop: _isComplaining
            ? () async => false
            : () async {
                if (route != '') {
                  if (route == articlesListPageRoute) {
                    Get.back();
                  } else {
                    Get.toNamed(articlesListPageRoute);
                  }
                } else {
                  Get.offAllNamed(rootRoute);
                }
                return false;
              },
        scaffold: _getArticleEventScaffold);
  }

  Scaffold get _getArticleEventScaffold => Scaffold(
      appBar: _getAppBar,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _getArticleEventDetailContainer,
            if (showScrollToTop && !isKeyboardVisible) _scrollToTopButton,
          ],
        ),
      ));

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            if (_isComplaining) return;
            if (route != '') {
              if (route == articlesListPageRoute) {
                Get.back();
              } else {
                Get.toNamed(articlesListPageRoute);
              }
            } else {
              Get.offAllNamed(rootRoute);
            }
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.survivingOverseas.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
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

  Widget get _getArticleEventDetailContainer =>
      BlocConsumer<ArticleBloc, ArticleState>(
        builder: (_, state) {
          return isLoading
              ? LoadingScaffold.getLoading()
              : _articleDetail != null
                  ? _isComplaining
                      ? LoadingScaffold.getLoading()
                      : _getArticleDetailListView
                  : const NoArticle();
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
            commentLoad(false);
          }

          if (state is ArticleDetailSuccess) {
            _articleDetail =
                ArticleDetailModel.fromJson(state.articleData.data!['data']);
            showFormField();
            _getCacheVoteUpData();
            _getCacheVoteDownData();
            _getComplainArticle();
            if (_articleDetail!.category! == "USER_GENERATED_CONTENT") {
              _requestArticleComments(page: currentPage);
            }
            _setLoading(false);
          }

          if (state is ArticleDetailFail) {
            _setLoading(false);
          }

          if (state is ArticleCreateComplainSuccess) {
            changeComplaining(false);
            if (state.newsData.data != null) {
              _articleComplainList.add(articleId.toString());
              saveArticleVoted('complained_articles', _articleComplainList);
              if (route != '') {
                Get.toNamed(articlesListPageRoute);
              } else {
                Get.offAllNamed(rootRoute);
              }
              showInfoModal(
                title: 'This article has been successfully reported.',
                message:
                    'Thanks for contributing to Phluid community to be a better place.',
                type: 'success',
                barrierDismissible: true,
              );
              // showSuccessSnackBar(state.newsData.data!['message']);
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
            _setLoading(false);
            changeComplaining(false);
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
            Future.delayed(const Duration(seconds: 2), () {
              scrollToBottom();
            });
          }

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

          if (state is ArticleCreateComplainLoading) {
            changeComplaining(true);
          }
        },
      );

  Widget get _getArticleDetailListView => Stack(
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
              padding: EdgeInsets.only(
                  left: 15, right: 20, bottom: isLoggedIn ? 60 : 90),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _articleDetail!.title ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w100),
                    ),
                    _getDateAndCreator,
                    ImageSlider(media: _articleDetail!.media),
                    _getContentDetail,
                    const Divider(color: AppColors.secondaryGrey),
                    _getLikesAndShare,
                    _articleDetail!.category! == "USER_GENERATED_CONTENT"
                        ? BlocConsumer<ArticleBloc, ArticleState>(
                            builder: (_, state) => _getCommentContent,
                            listener: (context, state) {
                              if (state is ArticlesGetCommentListLoading) {
                                commentLoad(true);
                              }
                              if (state is ArticlesReplyCommentLoading) {
                                commentLoad(true);
                              }
                              if (state is ArticlesUpdateCommentLoading) {
                                commentLoad(true);
                              }

                              if (state is ArticlesReplyCommentSuccess) {
                                commentLoad(false);
                              }
                              if (state is ArticlesUpdateCommentSuccess) {
                                commentLoad(false);
                              }
                              if (state is ArticlesGetCommentListFail) {
                                commentLoad(false);
                              }
                              if (state is ArticlesReplyCommentFail) {
                                commentLoad(false);
                              }
                              if (state is ArticlesUpdateCommentFail) {
                                commentLoad(false);
                              }
                              if (state is ArticlesDeleteCommentLoading) {
                                commentLoad(true);
                              }
                              if (state is ArticlesDeleteCommentSuccess) {
                                commentLoad(false);
                              }
                              if (state is ArticlesDeleteCommentFail) {
                                commentLoad(false);
                              }
                            },
                          )
                        : Container(),
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
          ],
        ],
      );

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

  Widget get _getDateAndCreator => Padding(
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
                    !isExpanded ? 'See More' : 'See Less',
                    style: const TextStyle(
                      color: AppColors.brandBlue,
                      fontSize: 10,
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

  Widget get _getLikesAndShare => Column(
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
                        child: Icon(Iconsax.dislike,
                            color: isArticleVoted('downvoted', "$articleId")
                                ? AppColors.primaryColor
                                : AppColors.white,
                            size: 20)),
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

  Widget get _getCommentContent => Container(
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

  Widget get buildUpvote => BlocBuilder<ArticleBloc, ArticleState>(
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

  Widget get buildDownvote => BlocBuilder<ArticleBloc, ArticleState>(
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
            int newDownvote =
                state.downVoteData.data!['data']['down_vote_count'];
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

  Widget get _emptyCommentList => SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'noComments'.tr,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

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
              label: Text('Share'.tr,
                  style: const TextStyle(fontSize: 10, color: AppColors.white)))
        ],
      );

  Widget get _scrollToTopButton => Positioned(
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

  bool isVideoFile(String fileName) {
    RegExp regExp = RegExp(
      r'\.(mp4|avi|flv|wmv|mov|mkv|webm)$',
      caseSensitive: false,
    );
    return regExp.hasMatch(fileName);
  }

  bool checkNewLines(String input) {
    int count = countNewlines(input);
    if (count > 5) {
      return true;
    } else {
      return false;
    }
  }

  int countNewlines(String input) {
    int count = 0;
    for (int i = 0; i < input.length; i++) {
      if (input[i] == '\n') {
        count++;
      }
    }
    return count;
  }

  void showFormField() {
    setState(() {
      showForm = true;
    });
  }

  void commentLoad(bool value) {
    if (currentPage == 1) {
      setState(() {
        commentLoading = value;
      });
    } else {
      setState(() {
        commentLoading = false;
      });
    }
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
    int userId = candidateData!['user_id'];
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
  }

  void closeDialog() {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _complainArticle() async {
    if (articleAlreadyComplained) {
      showInfoModal(
        title: 'You have already reported this article.',
        message:
            'Thanks for contributing to Phluid community to be a better place.',
        type: 'info',
      );
      return;
    }
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => CustomDialogSimple(
            message: 'complainArticleConfirm',
            negativeText: 'Cancel',
            positiveText: _isComplaining ? 'Please wait' : 'Yes',
            onButtonClick: _isComplaining
                ? null
                : () {
                    _requestComplainArticle();
                    closeDialog();
                  },
          ),
        );
      },
    );
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _checkCommentCreateValidation(String value) {
    if (value.isEmpty) {
      showErrorSnackBar("You cannot send empty comment.");
      return;
    }
    FocusScope.of(context).unfocus();
    if (_textController.text.length > kCommentCharacterLimitation) {
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
  Future<bool?> shareArticleLink() async {
    Uri data = await _getShareLink();
    return await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.shareArticleText,
        linkUrl: "$data",
        chooserTitle: kMaterialAppTitle);
  }

  Future<Uri> _getShareLink() async {
    return await ShortLink.createArticleShortLink(
        "$articleId", kArticleShortLink, 'articles');
  }

  void changeComplaining(bool value) {
    setState(() {
      _isComplaining = value;
    });
  }

  Future<void> showAlertLimitCharModal(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogSimple(
          message: StringConst.charLimit,
          positiveText: 'OK',
          onButtonClick: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _getCacheVoteUpData() async {
    List<String>? articleVoteUpCacheData = box.get('upvoted');

    if (articleVoteUpCacheData != null) {
      setState(() {
        _articleVotedUp = articleVoteUpCacheData;
        _disableUpVote =
            _articleVotedUp.contains(_articleDetail!.articleId.toString());
      });
    }
  }

  Future<void> _getCacheVoteDownData() async {
    List<String>? articleVoteDownCacheData = box.get('downvoted');
    if (articleVoteDownCacheData != null) {
      setState(() {
        _articleVotedDown = articleVoteDownCacheData;
        _disableDownVote =
            _articleVotedDown.contains(_articleDetail!.articleId.toString());
      });
    }
  }

  Future<void> _getComplainArticle() async {
    List<String>? articleComplainCacheData = box.get('complained_articles');
    if (articleComplainCacheData != null) {
      setState(() {
        _articleComplainList = articleComplainCacheData;
      });
    }
  }

  void saveArticleVoted(
    String name,
    List<String> list,
  ) async {
    box.put(name, list);
  }

  void _scrollListener() {
    final scrollTop =
        _scrollController.offset >= (MediaQuery.of(context).size.height * 0.5);
    setState(() {
      showScrollToTop = scrollTop;
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
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  bool isArticleVoted(String type, String articleId) {
    if (type == 'upvoted') {
      return _articleVotedUp.contains(articleId);
    } else if (type == 'downvoted') {
      return _articleVotedDown.contains(articleId);
    }
    return false;
  }

  /// set the id of the comment to be deleted to the state
  void setCommentIdToBeDeleted(int? commentId) {
    setState(() {
      commentIdToBeDeleted = commentId;
    });
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
              title: Text(StringConst.editArticle.tr),
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
            token: candidateData != null ? candidateData!['token'] : null,
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
