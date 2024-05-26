import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';

class CandidateProfileActions extends StatefulWidget {
  const CandidateProfileActions(
      {super.key,
      required this.candidate,
      this.onChatPressed,
      this.onStarPressed,
      this.onSharePressed,
      required this.isStarList});

  final Candidate candidate;
  final VoidCallback? onChatPressed;
  final VoidCallback? onStarPressed;
  final VoidCallback? onSharePressed;
  final bool isStarList;

  @override
  State<CandidateProfileActions> createState() =>
      _CandidateProfileActionsState();
}

class _CandidateProfileActionsState extends State<CandidateProfileActions> {
  Map? candidateData;
  bool isShowConnect = false;
  String basePhotoUrl = '';
  bool isStared = false;
  int? starId = 0;

  @override
  void initState() {
    _getCandidateData();
    _getPhotoUrl();
    super.initState();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
      if (widget.onStarPressed != null) isStared = true;
    });

    if (candidateData != null &&
        candidateData![DBUtils.employerTableName] != null &&
        !widget.isStarList) {
      _requestStarsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getProfileActions();
    }, listener: (_, state) {
      if (state is EmployerStarListAddSuccess) {
        if (state.data.data != null) {
          showInfoModal(message: state.data.data!['message'], type: 'success');
          _requestStarsList();
        }
      }
      if (state is EmployerStarListAddFail) {
        if (state.message != '') {
          showInfoModal(message: state.message, type: 'error');
        }
      }

      if (state is EmployerStarListSuccess) {
        if (state.data.data != null) {
          List<StarList> dataList = List<StarList>.from((state
                  .data.data!['data'] as List<dynamic>)
              .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));

          if (dataList.indexWhere((f) => f.onUserId == widget.candidate.id) !=
              -1) {
            setState(() {
              isStared = true;
              starId = dataList[dataList
                      .indexWhere((f) => f.onUserId == widget.candidate.id)]
                  .id;
            });
          }
        }
      }
      if (state is EmployerStarListFail) {
        if (state.message != '') {
          showInfoModal(message: state.message, type: 'error');
        }
      }

      if (state is EmployerStarListRemoveSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          setState(() {
            isStared = false;
          });
          _requestStarsList();
        }
      }
      if (state is EmployerStarListRemoveFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget _getProfileActions() => Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: widget.onStarPressed ?? () => _checkValidation(),
            child: SizedBox(
                height: 36,
                child: Row(children: [
                  Icon(
                    isStared ? Iconsax.star1 : Iconsax.star4,
                    size: isStared ? 36 : 24,
                    color: isStared ? AppColors.primaryColor : AppColors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "saveToStar".tr,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ]))),
        GestureDetector(
            onTap: widget.onChatPressed,
            child: Row(children: [
              const Icon(
                Iconsax.message,
                size: 24,
                color: AppColors.white,
              ),
              const SizedBox(width: 10),
              Text(
                "Chat".tr,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ])),
        GestureDetector(
            onTap: widget.onSharePressed,
            child: Row(children: [
              const Icon(
                Iconsax.send_2,
                size: 26,
                color: AppColors.white,
              ),
              const SizedBox(width: 10),
              Text(
                "Share".tr,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ]))
      ]));

  _checkValidation() {
    if (candidateData == null) {
      Get.offNamed(signInPageRoute,
          parameters: {'route': starListSectionRoute});
    } else if (isStared) {
      _requestRemoveStarList();
    } else {
      candidateData != null && candidateData![DBUtils.employerTableName] != null
          ? _addToStarList()
          : showEmptyProfileModal(context);
    }
  }

  _addToStarList() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerStarListAddRequestParams params = EmployerStarListAddRequestParams(
      candidateId: widget.candidate.id,
      token: candidateData!['token'],
    );

    candidateBloc.add(EmployerStarListAddRequested(params: params));
  }

  _requestStarsList() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerStarListRequestParams params =
        EmployerStarListRequestParams(token: candidateData!['token']);
    employerBloc.add(EmployerStarListRequested(params: params));
  }

  _requestRemoveStarList() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerStarListRemoveRequestParams params =
        EmployerStarListRemoveRequestParams(
            token: candidateData!['token'], starId: starId);
    employerBloc.add(EmployerStarListRemoveRequested(params: params));
  }
}
