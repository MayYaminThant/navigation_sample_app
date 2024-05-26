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

class EmployerProfileActions extends StatefulWidget {
  const EmployerProfileActions(
      {super.key,
      required this.employer,
      this.onChatPressed,
      this.onStarPressed,
      this.onSharePressed,
      required this.isStarList});

  final Employer employer;
  final VoidCallback? onChatPressed;
  final VoidCallback? onStarPressed;
  final VoidCallback? onSharePressed;
  final bool isStarList;

  @override
  State<EmployerProfileActions> createState() =>
      _EmployerProfileActionsState();
}

class _EmployerProfileActionsState extends State<EmployerProfileActions> {
  Map? employerData;
  bool isShowConnect = false;
  bool isStared = false;
  int? starId = 0;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.candidateTableName);
      if (widget.onStarPressed != null) isStared = true;
    });

    if (employerData != null &&
        employerData![DBUtils.candidateTableName] != null &&
        !widget.isStarList) {
      _requestStarsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getProfileActions();
    }, listener: (_, state) {
      if (state is CandidateStarListAddSuccess) {
        if (state.data.data != null) {
          showInfoModal(message: state.data.data!['message'], type: 'success');
          _requestStarsList();
        }
      }
      if (state is CandidateStarListAddFail) {
        if (state.message != '') {
          showInfoModal(message: state.message, type: 'error');
        }
      }

      if (state is CandidateStarListSuccess) {
        if (state.data.data != null) {
          List<StarList> dataList = List<StarList>.from((state
                  .data.data!['data'] as List<dynamic>)
              .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));

          if (dataList.indexWhere((f) => f.onUserId == widget.employer.id) !=
              -1) {
            setState(() {
              isStared = true;
              starId = dataList[dataList
                      .indexWhere((f) => f.onUserId == widget.employer.id)]
                  .id;
            });
          }
        }
      }
      if (state is CandidateStarListFail) {
        if (state.message != '') {
          showInfoModal(message: state.message, type: 'error');
        }
      }

      if (state is CandidateStarListRemoveSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          setState(() {
            isStared = false;
          });
          _requestStarsList();
        }
      }
      if (state is CandidateStarListRemoveFail) {
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
                    StringConst.saveToStar.tr,
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
    if (employerData == null) {
      Get.offNamed(signInPageRoute,
          parameters: {'route': starListSectionRoute});
    } else if (isStared) {
      _requestRemoveStarList();
    } else {
      employerData != null && employerData![DBUtils.candidateTableName] != null
          ? _addToStarList()
          : showEmptyProfileModal(context);
    }
  }

  _addToStarList() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateStarListAddRequestParams params = CandidateStarListAddRequestParams(
      employerId: widget.employer.id,
      token: employerData!['token'],
    );

    candidateBloc.add(CandidateStarListAddRequested(params: params));
  }

  _requestStarsList() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateStarListRequestParams params =
        CandidateStarListRequestParams(token: employerData!['token']);
    candidateBloc.add(CandidateStarListRequested(params: params));
  }

  _requestRemoveStarList() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateStarListRemoveRequestParams params =
        CandidateStarListRemoveRequestParams(
            token: employerData!['token'], starId: starId);
    candidateBloc.add(CandidateStarListRemoveRequested(params: params));
  }
}
