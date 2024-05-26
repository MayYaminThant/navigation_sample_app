import 'package:dh_employer/src/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({super.key, required this.coinHistory});

  final VoucherHistory coinHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 150),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.black.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        coinHistory.transactionDetail ?? '',
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      coinHistory.debit != 0
                          ? '-${coinHistory.debit} Coins'
                          : '+${coinHistory.credit} Coins',
                      style: TextStyle(
                          fontSize: 15,
                          color: coinHistory.debit != 0
                              ? AppColors.red
                              : AppColors.green,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (coinHistory.subTitle != null)
                  Text(
                    "${coinHistory.subTitle}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.normal),
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (coinHistory.description != null)
                  Text(
                    "${coinHistory.description}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.normal),
                  ),
                if (coinHistory.description != null) const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      coinHistory.transactionType ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      // DateFormat("yyyy-MM-dd   HH:mm:ss").format(DateTime.parse(coinHistory.date ?? '')),
                      coinHistory.date != null
                          ? datetimeToLocal(DateTime.parse(coinHistory.date!),
                              "dd.MM.yyyy    HH:mm")
                          : '',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
