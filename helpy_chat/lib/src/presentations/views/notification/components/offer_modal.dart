import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/notification/components/reject_offer_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hive/hive.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/widgets.dart';
import '../../employeer/components/jobs_info.dart';
import '../../home/components/currency_field.dart';

class OfferModal extends StatefulWidget {
  const OfferModal(
      {super.key,
      this.expiry,
      this.salary,
      this.currency,
      this.employerId,
      this.notificationId});
  final String? expiry;
  final String? salary;
  final String? currency;
  final int? employerId;
  final int? notificationId;

  @override
  State<OfferModal> createState() => _OfferModalState();
}

class _OfferModalState extends State<OfferModal> {
  Map? candidateData;
  final TextEditingController expectedSalaryController =
      TextEditingController();
  String basePhotoUrl = '';
  String countryName = '';
  String selectedCurrencyCode = '';
  Employer? employer;
  bool isLoading = false;
  bool empLoading = false;

  @override
  void initState() {
    _initLoad();
    setState(() {
      expectedSalaryController.text = widget.salary ?? '';
      selectedCurrencyCode = widget.currency ?? '';
    });
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);

    if (data != null) {
      setState(() {
        candidateData = data;
      });
      _requestEmployerPublicProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(
      builder: (_, state) {
        return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus == null
                ? null
                : FocusManager.instance.primaryFocus!.unfocus(),
            child: _getOfferModalContainer);
      },
      listener: (_, state) {
        if (state is EmployerPublicProfileLoading) {
          setState(() {
            empLoading = true;
          });
        }
        if (state is EmployerPublicProfileSuccess) {
          if (state.employerData.data != null) {
            setState(() {
              empLoading = false;
              employer =
                  EmployerModel.fromJson(state.employerData.data!['data']);
            });
          }
        }

        if (state is EmployerPublicProfileFail) {
          setState(() {
            empLoading = false;
          });
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      },
    );
  }

  //OfferModal Container
  Widget get _getOfferModalContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getEmployerDetail,
          const SizedBox(
            height: 10,
          ),
          Table(
            children: [
              TableRow(children: [_getRejectOfferButton, _getAcceptOfferButton])
            ],
          ),
          _getViewEmployerDetailsButton,
          const SizedBox(
            height: 10,
          ),
          _getExplainText
        ],
      );

  Widget get _getEmployerDetail {
    return empLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color(0xFFFFB6A0),
                    Color(0xFFA5E3FD),
                    Color(0xFF778AFF),
                    Color(0xFFFFCBF2),
                  ]),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                if (employer != null) _getEmployerInfo,
                const SizedBox(
                  height: 10,
                ),
                _getSalaryDropDown,
                const SizedBox(
                  height: 10,
                ),
                if (employer != null)
                  JobsInfo(
                    employer: employer!,
                    fontSize: 12,
                    paddingSize: 10,
                    fontColor: AppColors.black,
                  ),
              ],
            ),
          );
  }

  Widget get _getEmployerInfo => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _getEmployeerProfile,
              SizedBox(
                width: 50,
                child: Text(
                  StringUtils.getShortName(employer!.user!.firstName ?? '',
                      employer!.user!.lastName ?? ''),
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Text(
              employer!.user!.nationality ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: AppColors.primaryGrey.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      );

  //Employeer Profile
  Widget get _getEmployeerProfile => CustomImageView(
        image: '$basePhotoUrl/${employer!.user!.avatar}',
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        radius: const BorderRadius.all(Radius.circular(25.0)),
        fit: BoxFit.cover,
        color: AppColors.white,
        width: 50,
        height: 50,
      );

  Widget get _getSalaryDropDown {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: CurrencyField(
            controller: expectedSalaryController,
            initialValue: countryName,
            textColor: AppColors.black,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.3),
            enabled: false,
            onValueChanged: (String value) {
              setState(() {
                selectedCurrencyCode = value;
              });
            },
            prefix: ConfigsKeyHelper.simpleSearchCurrencyCodeKey),
      ),
      Text(
        'per month'.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 14),
      ),
    ]);
  }

  //Reject Offer
  Widget get _getRejectOfferButton => Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: Sizes.button47,
            child: CustomPrimaryButton(
              text: 'Reject offer'.tr,
              customColor: AppColors.red,
              textColor: AppColors.white,
              fontSize: 15,
              onPressed: () {
                _showRejectOfferModal();
              },
            )),
      );

  Widget get _getAcceptOfferButton => Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: Sizes.button47,
          child: BlocConsumer<CandidateBloc, CandidateState>(
            builder: (context, state) => CustomPrimaryButton(
              text: 'Accept offer'.tr,
              customColor: AppColors.green,
              textColor: AppColors.white,
              fontSize: 15,
              onPressed: isLoading
                  ? null
                  : () {
                      _createRejectOffer('accept', context);
                    },
            ),
            listener: (context, state) {
              if (state is CandidateOfferActionLoading) {
                setState(() {
                  isLoading = true;
                });
              }
              if (state is CandidateOfferActionSuccess) {
                setState(() {
                  isLoading = false;
                });
                if (state.data.data != null) {
                  if (state.data.data!['data']['action'] == 'accept') {
                    showInfoModal(
                        title:
                            'You have successfully accepted the hiring offer.',
                        message:
                            "Both the Helper's and your profile will be forwarded for Employment Contract processing.\nThank you for Choosing Phluid!",
                        type: 'success');
                  } else {
                    showInfoModal(
                        title: 'You have rejected the hiring offer.',
                        message:
                            "This action cannot be undone.\nThank you for Choosing Phluid!",
                        type: 'error');
                  }
                }
              }
              if (state is CandidateOfferActionFail) {
                setState(() {
                  isLoading = false;
                });
                if (state.message != '') {
                  showErrorSnackBar(state.message);
                }
              }
            },
          ),
        ),
      );

  Widget get _getViewEmployerDetailsButton => SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: Sizes.button47,
      child: CustomOutlineButton(
          text: 'View Employer Details'.tr,
          customColor: AppColors.white,
          textColor: AppColors.primaryColor,
          fontSize: 15,
          onPressed: () => Get.toNamed(employeerProfilePageRoute, parameters: {
                'id': widget.employerId.toString(),
              })));

  Widget get _getExplainText {
    Duration duration = DateTime.tryParse(widget.expiry.toString()) != null
        ? DateTime.tryParse(widget.expiry.toString())!
            .difference(DateTime.now())
        : Duration.zero;
    if (duration.inSeconds <= 0) duration = const Duration(seconds: 1);
    return TweenAnimationBuilder<Duration>(
        duration: duration,
        tween: Tween(
            begin: DateTime.tryParse(widget.expiry.toString()) != null
                ? DateTime.tryParse(widget.expiry.toString())!
                    .difference(DateTime.now())
                : Duration.zero,
            end: Duration.zero),
        builder: (BuildContext context, Duration value, Widget? child) {
          final days = value.inDays;
          final hours = value.inHours % 24;
          final minutes = value.inMinutes % 60;
          final seconds = value.inSeconds % 60;
          return days == 0 && hours == 0 && minutes == 0 && seconds == 0
              ? _getExpireOfferButton
              : SizedBox(
                  child: Text(
                  'This offer expires after $days days $hours hours $minutes minutes $seconds seconds.',
                  style: const TextStyle(color: AppColors.red, fontSize: 12),
                ));
        });
  }

  void _createRejectOffer(String action, BuildContext ctx) {
    if (ctx.mounted) {
      final candidateBloc = BlocProvider.of<CandidateBloc>(ctx);
      CandidateOfferActionRequestParams params =
          CandidateOfferActionRequestParams(
        token: candidateData != null ? candidateData!['token'] : null,
        action: action,
        employerId: widget.employerId,
        notificationId: widget.notificationId,
      );
      candidateBloc.add(CandidateOfferActionRequested(params: params));
    }
  }

  Widget get _getExpireOfferButton => SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: Sizes.button47,
      child: CustomOutlineButton(
        text: 'This Offer Has Expired.'.tr,
        customColor: AppColors.white,
        textColor: AppColors.primaryColor,
        fontSize: 15,
        onPressed: null,
      ));

  void _showRejectOfferModal() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          void closeDialog() {
            Navigator.of(ctx).pop();
          }

          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: SizedBox(
              width: 300,
              child: BlocConsumer<CandidateBloc, CandidateState>(
                builder: (context, state) => RejectOfferModal(
                  onPressed: isLoading
                      ? null
                      : () {
                          _createRejectOffer('reject', context);
                        },
                ),
                listener: (context, state) {
                  if (state is CandidateOfferActionLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is CandidateOfferActionSuccess) {
                    setState(() {
                      isLoading = false;
                    });
                    if (state.data.data != null) {
                      if (state.data.data!['data']['action'] == 'accept') {
                        closeDialog();
                        showInfoModal(
                            title:
                                'You have successfully accepted the hiring offer.',
                            message:
                                "Both the Helper's and your profile will be forwarded for Employment Contract processing.\nThank you for Choosing Phluid!",
                            type: 'success');
                      } else {
                        closeDialog();
                        showInfoModal(
                            title: 'You have rejected the hiring offer.',
                            message:
                                "This action cannot be undone.\nThank you for Choosing Phluid!",
                            type: 'error');
                      }
                    }
                  }
                  if (state is CandidateOfferActionFail) {
                    setState(() {
                      isLoading = false;
                    });
                    if (state.message != '') {
                      closeDialog();
                      showErrorSnackBar(state.message);
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _requestEmployerPublicProfile() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerPublicProfileRequestParams params =
        EmployerPublicProfileRequestParams(employerId: widget.employerId);
    employerBloc.add(EmployerPublicProfileRequested(params: params));
  }
}
