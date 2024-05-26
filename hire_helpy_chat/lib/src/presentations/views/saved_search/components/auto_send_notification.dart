import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';

class AutoSendNotification extends StatefulWidget {
  const AutoSendNotification({Key? key, required this.saveSearchList})
      : super(key: key);
  final List<SavedSearch> saveSearchList;

  @override
  State<AutoSendNotification> createState() => _AutoSendNotificationState();
}

class _AutoSendNotificationState extends State<AutoSendNotification> {
  bool _isCheckedEmail = false;
  SavedSearch? selectedSavedSearch;
  final TextEditingController emailController = TextEditingController();

  Map? employerData;
  User? user;
  String verifiedType = 'email';
  bool isEmailVerified = true;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);

    if (employerData != null) {
      setState(() {
        user = UserModel.fromJson(employerData!);
      });
      emailController.text = user!.email ?? '';
    }
  }

  ///TODO
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getAutoSendNotification;
    }, listener: (_, state) {
      if (state is EmployerCheckVerifiedSuccess) {
        Loading.cancelLoading();
        _verifyMethod(verifiedType);
      }

      if (state is EmployerCheckVerifiedFail) {
        Loading.cancelLoading();
        setState(() {
          verifiedType = '';
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getAutoSendNotification => Container(
      margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SavedSearchDropdownItem(
              initialValue: '',
              datas: widget.saveSearchList,
              title: StringConst.selectYourSearchText,
              onValueChanged: (SavedSearch data) {
                setState(() {
                  selectedSavedSearch = data;
                });
              },
              iconPadding: 0,
            ),
            const SizedBox(height: 20),
            Text(
              "We will send result of the search nightly to the eamil below."
                  .tr,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
            ),
            const SizedBox(height: 20),
            _checkBoxWithText('Email', _isCheckedEmail, (value) {
              setState(() {
                _isCheckedEmail = value!;
              });
              _checkIsEmailVerified();
            }),
            if (_isCheckedEmail)
              _getTextField(emailController, StringConst.emailText, 1, true,
                  inputType: TextInputType.emailAddress),
            // const SizedBox(height: 20),
            // _checkBoxWithText('Push Notifications', _isCheckedPushNotifications,
            //     (value) {
            //   setState(() {
            //     _isCheckedPushNotifications = value!;
            //   });
            // }),
            const SizedBox(height: 20),
            CustomPrimaryButton(
              text: 'Add Notifications'.tr,
              fontSize: 16,
              heightButton: 47,
              customColor: isEmailVerified && _isCheckedEmail ? AppColors.primaryColor : AppColors.primaryGrey,
              widthButton: MediaQuery.of(context).size.width - 40,
              onPressed: isEmailVerified && _isCheckedEmail ? () => _checkValidation(): null,
            )
          ],
        ),
      );

  Widget _checkBoxWithText(
      String text, bool isChecked, Function(bool?)? onChanged) {
    return Row(
      children: [
        Container(
          height: 21,
          width: 21,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            border:
                isChecked ? null : Border.all(color: Colors.white, width: 2.0),
          ),
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.transparent,
            ),
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: AppColors.white),
        ),
      ],
    );
  }

  _checkValidation() {
    _notifySavedSearch();
  }

  _notifySavedSearch() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerNotifySaveSearchRequestParams params =
        EmployerNotifySaveSearchRequestParams(
            token: employerData!['token'],
            userId: employerData!['user_id'],
            savedSearchId: selectedSavedSearch!.id);
    candidateBloc.add(EmployerNotifySaveSearchRequested(params: params));
  }

  _getTextField(TextEditingController controller, String title, int? maxLine,
      bool isRequired,
      {TextInputType? inputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: CustomTextField(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.cardColor.withOpacity(0.1)),
            maxLine: maxLine ?? 1,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
            controller: controller,
            textInputType: inputType,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            hasPrefixIcon: false,
            hasTitle: true,
            isRequired: true,
            titleStyle: const TextStyle(
              color: AppColors.white,
              fontSize: Sizes.textSize14,
            ),
            onChanged: (value) {
              _checkIsEmailVerified();
            },
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
        ),
        _getVerifyMethod()
      ],
    );
  }

  _getVerifyMethod() {
    if (!isEmailVerified) {
      return _getVerifyItem('email');
    } else {
      return _getVerified;
    }
  }

  _getVerifyItem(String type) {
    return GestureDetector(
        onTap: () => _checkVerifiedValidation(),
        child: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            StringConst.verifyNowText,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  _verifyMethod(String method) async {
    var data = await Get.toNamed(verifyAccountInfoPageRoute, parameters: {
      'method': method,
      'email': method == 'email' ? emailController.text.toString() : '',
      'route': myAccountPageRoute
    });

    if (data != null) {
      _getEmployerData();
    }
  }

  void _requestCheckVerified() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerCheckVerifiedRequestParams params =
        EmployerCheckVerifiedRequestParams(
      type: verifiedType == 'sms' ? 'phone' : 'email',
      email: verifiedType == 'email' ? emailController.text.toString() : null,
    );
    candidateBloc.add(EmployerCheckVerifiedRequested(params: params));
  }

  void _checkIsEmailVerified() {
    if (emailController.text.isNotEmpty &&
        (emailController.text != user!.email.toString() ||
            user!.emailVerifiedDateTime == null)) {
      setState(() {
        isEmailVerified = false;
      });
    } else {
      setState(() {
        isEmailVerified = true;
      });
    }
  }

  _checkVerifiedValidation() {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else {
      _requestCheckVerified();
      Loading.showLoading(message: StringConst.loadingText);
    }
  }

  //Verified
  Widget get _getVerified => const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Verified',
          style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      );
}
