import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/views/articles_and_news/components/article_profile_display.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/time_utils.dart';
import '../../../../data/models/article_model.dart';

class ArticleListItem extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? createdAt;
  final String? thumbnail;
  final String? articleId;
  final ArticleCreator? creator;
  final int? upVote;
  final int? downVote;
  final int? commentCount;
  final bool? showLikes;
  final int? viewCount;
  final bool? showActions;
  final ValueChanged<String>? onValueChanged;

  const ArticleListItem({
    super.key,
    this.title,
    this.subtitle,
    this.createdAt,
    this.thumbnail,
    this.articleId,
    this.creator,
    this.upVote,
    this.downVote,
    this.commentCount,
    this.showLikes,
    this.viewCount,
    this.showActions,
    this.onValueChanged,
  });

  @override
  State<ArticleListItem> createState() => _ArticleListItemState();
}

class _ArticleListItemState extends State<ArticleListItem> {
  bool isBackground = false;

  @override
  Widget build(BuildContext context) {
    return _getArticleListItem(context);
  }

  _getArticleListItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CustomImageView(
                  url: widget.thumbnail!.isNotEmpty
                      ? widget.thumbnail
                      : 'assets/images/phluid_logo.png',
                  fit: widget.thumbnail!.isNotEmpty ? BoxFit.cover : BoxFit.contain,
                  radius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 160,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title ?? '',
                                      style: const TextStyle(
                                          color: AppColors.white),
                                      maxLines: 1,
                                    ),
                                  ),
                                  widget.showActions != null &&
                                          widget.showActions!
                                      ? _getArticleActionMenu
                                      : const SizedBox.shrink()
                                ],
                              ),
                              widget.creator != null ?
                                ArticleProfileDisplay(creator: widget.creator!) : const SizedBox(height: 4),
                              Text(
                                widget.subtitle ?? '',
                                style: const TextStyle(
                                    color: AppColors.primaryGrey, fontSize: 12),
                                maxLines: widget.creator != null ? 1 : 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ])),
                        Padding(padding: const EdgeInsets.only(right: 3), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              datetimeToLocal(DateTime.parse(widget.createdAt!),
                                  "dd/MM/yyyy"),
                              style: const TextStyle(
                                  color: AppColors.primaryGrey, fontSize: 10),
                            ),
                            if (widget.viewCount != null) _getViewCountContainer
                          ],
                        )
                        )
                      ],
                    ),
                  )),
            ],
          ),
          if (widget.showLikes ?? false) _getLikes
        ],
      ),
    );
  }

  Widget get _getLikes {
    return Column(
      children: [
        const Divider(color: AppColors.secondaryGrey),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Iconsax.like_1,
                  color: AppColors.white,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.upVote.toString(),
                  style: const TextStyle(fontSize: 10, color: AppColors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Iconsax.dislike,
                  color: AppColors.white,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.downVote.toString(),
                  style: const TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Iconsax.messages_2,
                  color: AppColors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "${widget.commentCount} Comments",
                  style: const TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //ViewCount Container
  Widget get _getViewCountContainer => Row(
        children: [
          const Icon(
            Iconsax.eye,
            color: AppColors.white,
            size: 14,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${_getViewCount()} ${widget.viewCount! == 1 ? 'view' : 'views'}',
            style: const TextStyle(color: AppColors.white, fontSize: 10),
          ),
        ],
      );

  _getViewCount() {
    if (widget.viewCount! >= 1000) {
      return '${(widget.viewCount! / 1000).floor()}k';
    } else {
      return widget.viewCount;
    }
  }

  get _getArticleActionMenu {
    return PopupMenuButton<String>(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(-20, 0),
      elevation: 0,
      onOpened: () {
        setState(() {
          isBackground = true;
        });
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 4,
            value: 'edit',
            child: Container(
              height: 47,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: Center(
                child: Text(
                  'Edit Article'.tr,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            height: 4,
            value: 'delete',
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 47,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.red),
              child: Center(
                child: Text(
                  'Delete'.tr,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) => widget.onValueChanged!(value),
      child: const Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
