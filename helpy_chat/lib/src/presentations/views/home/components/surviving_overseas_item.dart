import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../domain/entities/entities.dart';

class SurvivingOverseasItem extends StatelessWidget {
  const SurvivingOverseasItem({super.key, required this.article});

  final ArticleDetail article;

  @override
  Widget build(BuildContext context) {
    return _getSurvivingOverseasItem(context);
  }

  Widget _getSurvivingOverseasItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      width: 160,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.1),
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xFFFFB6A0),
              Color(0xFFA5E3FD),
              Color(0xFF778AFF),
              Color(0xFFFFCBF2),
            ]),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getArticleImage,
          _getDateTime,
          SizedBox(
            height: 55,
            child: Text(
              article.title ?? '',
              style: const TextStyle(color: AppColors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const Divider(
            color: AppColors.primaryGrey,
          ),
          _getLikes
        ],
      ),
    );
  }

  Widget get _getArticleImage => Stack(
        children: [
          Container(
            width: 140,
            height: 100,
            decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.0)),
            child: CustomImageView(
              fit: article.media!.isNotEmpty ? BoxFit.cover : BoxFit.contain,
              image: article.media != null
                  ? article.media!.isEmpty
                      ? 'assets/images/logo.png'
                      : article.media![0].mediaThumbnailFilepath != null
                          ? "${article.media![0].mediaThumbnailFilepath}"
                          : "${article.media![0].mediaFilePath}"
                  : 'assets/images/logo.png',
              radius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _getViewAndComments,
          )
        ],
      );

  Widget get _getDateTime => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              article.createdAt?.substring(0, 10) ?? '',
              style:
                  const TextStyle(color: AppColors.primaryGrey, fontSize: 10),
            ),
          ],
        ),
      );

  Widget get _getLikes {
    return Row(
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
              article.upvote.toString(),
              style: const TextStyle(fontSize: 10, color: AppColors.white),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Iconsax.dislike,
              color: AppColors.white,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              article.downvote.toString(),
              style: const TextStyle(fontSize: 10, color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _getViewAndComments {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.eye,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                article.viewDayCount.toString(),
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
              const SizedBox(
                width: 10,
              ),
              Text(
                article.commentCount.toString(),
                style: const TextStyle(fontSize: 10, color: AppColors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
