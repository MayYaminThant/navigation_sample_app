import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({super.key, required this.review});
  final Review review;

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  String basePhotoUrl = '';
  @override
  void initState() {
    _getPhotoUrl();
    super.initState();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getReviewContainer;
  }

  Widget get _getReviewContainer => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Table(
        columnWidths: const {0: FixedColumnWidth(50)},
        children: [
          TableRow(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.white,
                backgroundImage: CachedNetworkImageProvider(
                    '$basePhotoUrl/${widget.review.reviewer!.avatar}'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          '${widget.review.reviewer!.firstName} ${widget.review.reviewer!.lastName}',
                          style: const TextStyle(
                            color: AppColors.primaryGrey,
                            fontSize: 14,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      RatingBar.builder(
                        initialRating: double.parse(
                            (widget.review.reviewStarRating ?? 0).toString()),
                        minRating: 1,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18,

                        //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Iconsax.star1,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          superPrint(rating);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _getReviewText,
                  const SizedBox(
                    height: 10,
                  ),
                  _getCreatedDateTime,
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: AppColors.primaryGrey,
                    height: 0.1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ],
      ));

  //Review Text
  Widget get _getReviewText => Text(widget.review.review ?? '',
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 14,
      ));

  //Created DateTime
  Widget get _getCreatedDateTime =>
      Text(widget.review.reviewCreationDatetime ?? '',
          style: const TextStyle(
            color: AppColors.primaryGrey,
            fontSize: 12,
          ));
}
