import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class RatingItem extends StatefulWidget {
  const RatingItem({super.key, required this.employer});
  final Employer employer;

  @override
  State<RatingItem> createState() => _RatingItemState();
}

class _RatingItemState extends State<RatingItem> {
  @override
  Widget build(BuildContext context) {
    return _getRatingItem;
  }

  Widget get _getRatingItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              RatingBar.builder(
                initialRating: _getReviewCount(),
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 18,
                //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Iconsax.star1,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${_getReviewCount()}/${widget.employer.reviews != null ? widget.employer.reviews!.length : 0}',
                style: const TextStyle(
                  color: AppColors.brandBlue,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Text(
            '(${widget.employer.reviews != null ? widget.employer.reviews!.length : '0'} ${StringConst.reviewsText.tr})',
            style: const TextStyle(
              color: AppColors.blackShade2,
              fontSize: 15,
            ),
          ),
        ],
      );

  double _getReviewCount() {
    if (widget.employer.reviews == null) {
      return 0;
    }
    int starCount = 0;
    for (int i = 0; i < widget.employer.reviews!.length; i++) {
      starCount += widget.employer.reviews![i].reviewStarRating ?? 0;
    }
    double value = starCount / widget.employer.reviews!.length;
    return value.isNaN ? 0 : double.parse(value.toStringAsFixed(1));
  }
}
