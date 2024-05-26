
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class RatingCreateModal extends StatefulWidget {
  final String token;
  final int onUserId;
  final int byUserId;
  const RatingCreateModal({
    super.key,
    required this.token,
    required this.onUserId,
    required this.byUserId
  });

  @override
  State<RatingCreateModal> createState() => _RatingCreateModalState();
}

class _RatingCreateModalState extends State<RatingCreateModal> {
  final TextEditingController reviewController = TextEditingController();
  double ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 327,
        height: 480,
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  StringConst.createReviewTitle,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 20),
                const Text(
                  StringConst.selectRatingText,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  ignoreGestures: false,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,

                  //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Iconsax.star1,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  StringConst.writeReviewText,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                _getTextField(reviewController, StringConst.createReviewTitle,
                    false, 4, AppColors.white),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                CustomPrimaryButton(
                  text: StringConst.submitReviewText,
                  fontSize: 16,
                  widthButton: MediaQuery.of(context).size.width,
                  onPressed: () => ratingValue != 0 ? _createCandidateReview(): showErrorSnackBar('Please choose a rating.'),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Transform.scale(
                      scale: 0.6,
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, int? maxLine, Color? backgroundColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
        controller: controller,
        textInputType: TextInputType.text,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        hasPrefixIcon: false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(255),
        ],
        maxLength: 255,
        hasTitle: true,
        isRequired: true,
        hasSuffixIcon: hasSuffixIcon,
        titleStyle: const TextStyle(
          color: AppColors.white,
          fontSize: Sizes.textSize14,
        ),
        hasTitleIcon: false,
        enabledBorder: Borders.noBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  //Create Candidate Reivew
  void _createCandidateReview() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerCreateReviewsRequestParams params =
        EmployerCreateReviewsRequestParams(
            review: reviewController.text,
            reviewStarRating: int.parse(ratingValue.toStringAsFixed(0)),
            token: widget.token,
            byUserId: widget.byUserId,
            onUserId: widget.onUserId
            );
    candidateBloc.add(EmployerCreateReviewRequested(params: params));
  }
}
