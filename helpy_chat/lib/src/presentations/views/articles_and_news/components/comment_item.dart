import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class CommentItem extends StatefulWidget {
  final String? user;
  final String? comment;
  final String? urlImage;
  final String? length;
  final VoidCallback? onReply;
  final bool isComment;
  final bool isReply;
  final int? commentId;
  final Function()? onDeleteComment;
  final int? userId;
  final Function()? onEditComment;
  final Function()? onReportComment;
  final bool isEditing;
  final bool isDeleted;
  final bool isUpdated;
  final String? replyToUser;

  const CommentItem({
    super.key,
    required this.commentId,
    this.user,
    this.comment,
    this.urlImage,
    this.length,
    this.onReply,
    this.userId,
    this.onDeleteComment,
    this.onEditComment,
    this.isComment = false,
    this.isReply = false,
    this.isEditing = false,
    this.isDeleted = false,
    this.isUpdated = false,
    this.replyToUser,
    this.onReportComment,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isExpandedReply = false;
  String basePhotoUrl = '';
  Map? candidateData;
  List<String> _commentComplainList = [];
  final TextEditingController _commentController = TextEditingController();
  int clickedId = 0;
  bool isTheOwner = false;
  bool isLoggedIn = false;
  bool isCommentLoading = false;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getCandidateData();
    _commentController.text = widget.comment ?? '';
  }

  Future<void> _getComplainComment() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? commentComplainCacheData = box.get('complained_comments');
    if (commentComplainCacheData != null) {
      setState(() {
        _commentComplainList = commentComplainCacheData;
      });
    }
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    setState(() {
      isLoggedIn = data != null;
    });

    if (data != null) {
      candidateData = data;
      _checkIsTheOwner();
      _getComplainComment();
    }
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  void _checkIsTheOwner() {
    if (candidateData != null) {
      setState(() {
        isTheOwner = candidateData!['user_id'] == widget.userId;
      });
    }
  }

  bool _hasAlreadyComplained() {
    return _commentComplainList
        .toString()
        .contains(widget.commentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(builder: (_, state) {
      return _getCommentContainer;
    }, listener: (_, state) {
      if (state is CommentCreateComplainSuccess) {
        if (state.newsData.data != null) {
          _commentComplainList.add(clickedId.toString());
          DBUtils.saveListData(_commentComplainList, 'complained_comments');
        }
      }
    });
  }

  Widget get _getCommentContainer {
    return widget.isDeleted
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  child: Text(
                    '- This comment has been deleted by user -',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryGrey,
                    ),
                  ),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: !isLoggedIn ? null : () => showOptionsBottomSheet(),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.replyToUser != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 35),
                      child: Text.rich(
                        TextSpan(
                          text: 'Reply to',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.white),
                          children: [
                            TextSpan(
                              text: '  ${widget.replyToUser}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '$basePhotoUrl/${widget.urlImage}',
                        imageBuilder: (context, imageProvider) => SizedBox(
                          height: 28,
                          width: 28,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: imageProvider,
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(
                          width: 28,
                          height: 28,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.cardColor.withOpacity(0.1),
                            border: widget.isEditing
                                ? Border.all(color: AppColors.white)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.user ?? '',
                                style: const TextStyle(
                                    fontSize: 14, color: AppColors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.comment ?? '',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.secondaryGrey),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          width: widget.isComment
                              ? 40
                              : widget.isReply
                                  ? 20
                                  : 0),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      if (widget.isUpdated) Expanded(child: _getEditedStatus()),
                      _getReplys(),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  void closeDialog() {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _complainArticle() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => CustomDialogSimple(
          message: 'Are you sure you want to report this comment?',
          negativeText: 'Cancel',
          positiveText: 'Yes',
          onButtonClick: () {
            setState(() {
              clickedId = widget.commentId ?? 0;
            });
            _requestCommentComplain();
            if (widget.onReportComment != null) widget.onReportComment!();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _requestCommentComplain() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleCommentCreateComplainRequestParams params =
        ArticleCommentCreateComplainRequestParams(
            token: candidateData != null ? candidateData!['token'] : null,
            commentId: widget.commentId);
    articleBloc.add(CommentCreateComplainRequested(params: params));
  }

  Widget _getEditedStatus() {
    return const Padding(
      padding: EdgeInsets.only(top: 3),
      child: Text(
        'Edited',
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: 12, color: AppColors.secondaryGrey),
      ),
    );
  }

  Widget _getReplys() {
    const double width = 50;
    if (widget.length == null) return const SizedBox(width: width);
    final int length = int.tryParse(widget.length!) ?? 0;
    if (length <= 0) return const SizedBox(width: width);

    String getReplyNum() {
      if (widget.length != null) {
        if (length == 1) {
          return '${widget.length} Reply';
        }
        return '${widget.length} Replies';
      }
      return '';
    }

    return Container(
      constraints: const BoxConstraints(minWidth: width - 10),
      padding: const EdgeInsets.only(top: 3, left: 10),
      child: Text(
        getReplyNum(),
        textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 12, color: AppColors.primaryColor),
      ),
    );
  }

  void showOptionsBottomSheet() {
    final bool canReport = candidateData != null &&
        !_commentComplainList.toString().contains(widget.commentId.toString());

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: ListTile.divideTiles(
              color: AppColors.secondaryGrey,
              context: context,
              tiles: [
                if (widget.onReply != null)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Reply Comment'),
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onReply != null) {
                        widget.onReply!();
                      }
                    },
                  ),
                if (isTheOwner) ...[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Edit Comment'),
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onEditComment != null) {
                        widget.onEditComment!();
                      }
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Delete Comment'),
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onDeleteComment != null) {
                        widget.onDeleteComment!();
                      }
                    },
                  ),
                ],
                if (!isTheOwner && !_hasAlreadyComplained())
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Report Comment'),
                    onTap: () {
                      Navigator.pop(context);
                      if (canReport) _complainArticle();
                    },
                  ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ).toList(),
          ),
        );
      },
    );
  }
}
