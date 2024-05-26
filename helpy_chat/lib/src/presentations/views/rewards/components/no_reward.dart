import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class NoRewardItem extends StatefulWidget {
  const NoRewardItem({super.key});

  @override
  State<NoRewardItem> createState() => _NoRewardItemState();
}

class _NoRewardItemState extends State<NoRewardItem> {
  String countryName = 'Singapore';
  Map? candidateData = {};
  final int _coins = 600;

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    if (candidateData != null &&
        candidateData![DBUtils.candidateTableName] != null) {}
  }

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return candidateData == null
        ? BlocProvider.of<RewardBloc>(context).rewardListModel == null
            ? _buildNonLogInBody
            : _buildEmptyCoinNonLoggedInbody
        : _coins.isEqual(0)
            ? _buildEmptyCoinbody
            : _buildBody;
  }

  Widget get _buildBody => Column(
        children: [_buildbody],
      );

  Widget get _buildNonLogInBody => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset("assets/images/no_reward.png"),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  StringConst.noRewardsYet,
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 180,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        StringConst.noRewardsBodyNonLoggedIn,
                        style: GoogleFonts.poppins(
                            height: 2.0,
                            fontSize: 15,
                            color: const Color(0xFFBEBEBE)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 47,
                  child: CustomPrimaryButton(
                      fontSize: 20,
                      text: StringConst.gotoLoginText,
                      onPressed: () => Get.offNamed(signInPageRoute)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: StringConst.dontHaveYouAccount,
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFBEBEBE), fontSize: 15)),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => Get.offNamed(registerPageRoute),
                          child: Text(
                            StringConst.registerNow,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF03CBFB),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      );

  Widget get _buildEmptyCoinbody => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Column(
          children: [
            _getRewardEmptyHeader,
            const SizedBox(
              height: 20.0,
            ),
            Image.asset("assets/images/empty_state.png"),
            const SizedBox(
              height: 20.0,
            ),
            Text(StringConst.emptyCoinTitle,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: StringConst.collectByCompleting,
                        style: GoogleFonts.poppins(
                            color: const Color(0xFFBEBEBE),
                            fontSize: 15,
                            height: 1.5)),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () => Get.offNamed(registerPageRoute),
                        child: Text(
                          StringConst.profile,
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFFF8E03),
                              fontSize: 15,
                              height: 1.5),
                        ),
                      ),
                    ),
                    TextSpan(
                        text: " or ",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFFBEBEBE),
                            fontSize: 15,
                            height: 1.5)),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () => Get.offNamed(registerPageRoute),
                        child: Text(
                          StringConst.referring,
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFFF8E03),
                              fontSize: 15,
                              height: 1.5),
                        ),
                      ),
                    ),
                    TextSpan(
                        text: StringConst.toFriends,
                        style: GoogleFonts.poppins(
                            color: const Color(0xFFBEBEBE),
                            fontSize: 15,
                            height: 1.5)),
                  ],
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      );

  Widget get _buildEmptyCoinNonLoggedInbody => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset("assets/images/empty_state.png"),
                const SizedBox(
                  height: 20.0,
                ),
                Text(StringConst.emptyCoinTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  StringConst.emptyCoinsBodyNonLoggedIn,
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: const Color(0xFFBEBEBE)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 47,
                  child: CustomPrimaryButton(
                      fontSize: 20,
                      text: StringConst.gotoLoginText,
                      onPressed: () => Get.offNamed(signInPageRoute)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: StringConst.dontHaveYouAccount,
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFBEBEBE), fontSize: 15)),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => Get.offNamed(registerPageRoute),
                          child: Text(
                            StringConst.registerNow,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF03CBFB),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )
          ],
        ),
      );

  Widget get _getRewardEmptyHeader {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              StringConst.totalCoin,
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                SizedBox(
                  width: 26,
                  height: 26,
                  child: SvgPicture.asset('assets/svg/coin.svg',
                      // ignore: deprecated_member_use
                      color: AppColors.primaryColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$_coins Coins',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget get _buildbody => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/images/no_reward.png"),
              const SizedBox(
                height: 15,
              ),
              Text(
                StringConst.noRewardsYet,
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                StringConst.noRewardsBodyLoggedIn,
                style: GoogleFonts.poppins(
                    fontSize: 15, color: const Color(0xFFBEBEBE)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
