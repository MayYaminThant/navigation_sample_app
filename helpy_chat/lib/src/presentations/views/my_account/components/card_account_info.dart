import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/configs_key_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class CardAccountInfo extends StatefulWidget {
  final Function()? onUploadPhoto;
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneNumberController;
  final bool isDeleteAvatar;
  final ValueChanged<String> onStatusValueChanged;
  final String avatarPath;

  const CardAccountInfo(
      {super.key,
      this.onUploadPhoto,
      this.firstNameController,
      this.lastNameController,
      this.emailController,
      this.phoneNumberController,
      required this.isDeleteAvatar,
      required this.onStatusValueChanged,
      required this.avatarPath});

  @override
  State<CardAccountInfo> createState() => _CardAccountInfoState();
}

class _CardAccountInfoState extends State<CardAccountInfo> {
  bool isEditing = false;
  String basePhotoUrl = '';
  User? user;
  List<AvailabilityStatus> availabilityStatusList = [];
  AvailabilityStatus? value;
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    _getPhotoUrl();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CardAccountInfo oldWidget) {
    if (oldWidget.isDeleteAvatar != widget.isDeleteAvatar) {
      _getCandidateData();
    }
    super.didUpdateWidget(oldWidget);
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);

    if (candidateData != null) {
      _getAvailabilityStatusData();
      setState(() {
        user = UserModel.fromJson(candidateData!);
      });
      _initializeData();
    }
  }

  void _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      basePhotoUrl = data;
    }
  }

  _initializeData() {
    // if (Get.parameters.isNotEmpty) {
    //   String path = Get.parameters['file'] ?? '';
    //   file = File(path);
    //   _createAvatar(file);
    // }

    if (user != null) {
      widget.firstNameController!.text = user!.firstName ?? '';
      widget.lastNameController!.text = user!.lastName ?? '';
      widget.emailController!.text = user!.email ?? '-';
      widget.phoneNumberController!.text = user!.phoneNumber != null
          ? '${user!.countryCallingCode}${user!.phoneNumber.toString()}'
          : '-';
    }
  }

  void _getAvailabilityStatusData() async {
    List<AvailabilityStatus> statusList = List<AvailabilityStatus>.from(
        (await DBUtils.getCandidateConfigs(
                ConfigsKeyHelper.availabilityStatusKey))
            .map((e) => AvailabilityStatusModel.fromJson(e)));
    availabilityStatusList.addAll(statusList);

    if (candidateData![DBUtils.candidateTableName] != null &&
        candidateData![DBUtils.candidateTableName]['availability_status'] !=
            null &&
        candidateData![DBUtils.candidateTableName]['availability_status'] !=
            '') {
      value = availabilityStatusList[availabilityStatusList.indexWhere((item) =>
          item.availabilityStatusType ==
          candidateData![DBUtils.candidateTableName]['availability_status'])];
    } else {
      value = availabilityStatusList[availabilityStatusList.length - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getCardDetail;
  }

  Widget get _getCardDetail {
    return Stack(
      children: [
        Container(
            height: 223,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: const GradientBoxBorder(
                gradient: LinearGradient(colors: [
                  Color(0xFFFFB6A0),
                  Color(0xFFA5E3FD),
                  Color(0xFF778AFF),
                  Color(0xFFFFCBF2),
                ]),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                buildAvatarAndUploadPhoto,
                buildInfoAccount,
              ],
            )),
        Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.toNamed(aboutMePageRoute,
                    parameters: {'route': myAccountPageRoute}),
                child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Iconsax.edit,
                        size: 16, color: AppColors.primaryColor))))
      ],
    );
  }

  Widget get buildAvatarAndUploadPhoto {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.bottomRight, children: [
            _getUploadedImageView,
            value != null
                ? Container(
                    height: 30,
                    width: 112,
                    decoration: BoxDecoration(
                      color: AppColors.fromHex(value!.colorCode ?? '')
                          .withAlpha(200),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        value?.availabilityStatusType ?? '',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ]),
          TextButton(
            onPressed: () {
              widget.onUploadPhoto!();
            },
            child: Text(
              'Change Photo'.tr,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColor),
            ),
          ),
          _getAvailabilityStatus,
        ],
      ),
    );
  }

  Widget get buildInfoAccount {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isEditing)
          const SizedBox(
            height: 14,
          ),
        itemAccountNameAndLastName(
          title: 'Display Name'.tr,
          firstName: widget.firstNameController!,
          lastName: widget.lastNameController!,
        ),
        itemAccount(
          title: 'Email Address'.tr,
          info: widget.emailController!,
          isVerified: user != null && user!.emailVerifiedDateTime != null,
          isPhoneNumber: false,
        ),
        itemAccount(
          title: 'Phone Number'.tr,
          info: widget.phoneNumberController!,
          isVerified: user != null && user!.phoneNumberVerifiedDateTime != null,
          isPhoneNumber: true,
        ),
      ],
    );
  }

  Widget itemAccount(
      {required String title,
      required TextEditingController info,
      bool? isVerified,
      required bool isPhoneNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            if (isVerified ?? false)
              const SizedBox(
                width: 16,
              ),
            if (isVerified ?? false)
              const Icon(
                Iconsax.tick_circle,
                size: 14,
                color: AppColors.secondaryColor,
              )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.48,
          child: Text(
              isPhoneNumber && info.text != '-'
                  ? '+${formatPhoneNumber(info.text)}'
                  : info.text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isPhoneNumber
                    ? AppColors.primaryColor
                    : AppColors.primaryGrey,
              )),
        )
      ],
    );
  }

  Widget itemAccountNameAndLastName({
    required String title,
    required TextEditingController firstName,
    required TextEditingController lastName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            isEditing == false
                ? Row(
                    children: [
                      Text(firstName.text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGrey,
                          )),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(lastName.text,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryGrey,
                          ))
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextField(
                          autofocus: true,
                          controller: firstName,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryGrey,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 6),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextField(
                          autofocus: true,
                          controller: lastName,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryGrey,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 6),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ],
    );
  }

  //Uploaded ImageView
  Widget get _getUploadedImageView => CustomImageView(
        height: 102,
        width: 102,
        radius: BorderRadius.circular(50),
        color: AppColors.white,
        fit: BoxFit.cover,
        image: widget.avatarPath.isEmpty
            ? '$basePhotoUrl/$kDefaultAvatar'
            : '$basePhotoUrl/${widget.avatarPath}',
      );

  String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(
      RegExp(r'(\d{2})(?=\d{4}|\d{2}$)'),
      (match) {
        return '${match.group(0)} ';
      },
    );
  }

  //Upload Avatar
  // _createAvatar(File? file) {
  //   final candidateBloc = BlocProvider.of<CandidateBloc>(context);
  //   CandidateCreateAvatarRequestParams params =
  //       CandidateCreateAvatarRequestParams(
  //           token: user!.token, avatarFile: file);
  //   candidateBloc.add(CandidateCreateAvatarRequested(params: params));
  // }

  get _getAvailabilityStatus {
    return user != null && user!.candidate != null
        ? PopupMenuButton<AvailabilityStatus>(
            onSelected: _handleClick,
            constraints: const BoxConstraints.tightFor(width: 150),
            offset: const Offset(0, 48),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            itemBuilder: (BuildContext context) {
              return availabilityStatusList.map((AvailabilityStatus choice) {
                return PopupMenuItem<AvailabilityStatus>(
                    value: choice,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                choice.availabilityStatusType ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 7.0,
                              height: 7.0,
                              decoration: BoxDecoration(
                                  color: getColor(choice),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3.5))),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ));
              }).toList();
            },
            child: Text(
              "Availability Status".tr,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColor),
            ),
          )
        : Container();
  }

  getColor(AvailabilityStatus data) {
    return AppColors.fromHex(data.colorCode ?? '');
  }

  void _handleClick(AvailabilityStatus data) => setState(() {
        widget.onStatusValueChanged(data.availabilityStatusType ?? '');
      });
}
