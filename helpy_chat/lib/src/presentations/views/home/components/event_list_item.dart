import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? createdAt;
  final String? thumbnail;
  final String? thumbnailImage;
  const EventListItem(
      {this.title,
      this.subtitle,
      this.createdAt,
      this.thumbnail,
      required this.thumbnailImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return _getEventListItem(context);
  }

  Widget _getEventListItem(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.articleBackgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: thumbnail != null
                ? CustomImageView(
                    image: "$thumbnailImage",
                  )
                : const CustomImageView(image: 'assets/images/article-1.png'),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(color: AppColors.white),
                  maxLines: 1,
                ),
                Text(
                  subtitle ?? '',
                  style: const TextStyle(
                      color: AppColors.primaryGrey, fontSize: 12),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  createdAt!.substring(0, 10),
                  style: const TextStyle(
                      color: AppColors.primaryGrey, fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
