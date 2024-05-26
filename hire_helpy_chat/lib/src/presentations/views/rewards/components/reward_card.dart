import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../config/routes/routes.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class RewardCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String imageUrl;
  final String pHCRequired;
  final String itemCount;

  const RewardCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pHCRequired,
    required this.itemCount,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.black.withOpacity(0.3)),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                    height: 30,
                    width: 30,
                    child: LinearProgressIndicator(
                      color: Colors.grey.shade200,
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                  errorWidget: (context, imageUrl, dynamic) => Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: const Icon(
                      Icons.broken_image,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14,
                        
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.normal),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset('assets/svg/coin.svg',
                            // ignore: deprecated_member_use
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$pHCRequired Coins',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 100, child: _buildItemLeft),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CustomPrimaryButton(
                            fontSize: 10,
                            text: 'Details',
                            onPressed: () {
                              BlocProvider.of<RewardBloc>(context)
                                  .setCurrentPage(index);
                              Get.toNamed(rewardDetailPageRoute);
                            }),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _buildItemLeft {
    return Text(
      itemCount == "Unlimited" ? itemCount.tr : '$itemCount ${'items left'.tr}',
      style: const TextStyle(
          fontSize: 12,
          color: AppColors.primaryGrey,
          fontWeight: FontWeight.normal),
    );
  }
}
