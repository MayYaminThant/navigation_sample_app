part of '../../views.dart';

class MyAccountSection extends StatefulWidget {
  const MyAccountSection({super.key});

  @override
  State<MyAccountSection> createState() => _MyAccountSectionState();
}

class _MyAccountSectionState extends State<MyAccountSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Map? employerData;
  bool profileimage = false;
  bool isPopUpMessage = false;
  User? user;
  int countryCallCode = 65;
  String basePhotoUrl = '';
  File? file;
  bool isClicked = false;
  String avatar = '';
  bool isNeedVerified = false;
  String verifiedType = '';
  String country = '';
  String language = '';
  bool isEditing = false;
  bool isDeleteAvatar = false;
  String status = '';
  String avaliblityStatus = '';

  @override
  void initState() {
    _getEmployerData();
    _getPhotoUrl();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
    language = box.get(DBUtils.language) ?? '';
    country = box.get(DBUtils.country) ?? '';

    if (employerData != null) {
      setState(() {
        user = UserModel.fromJson(employerData!);
      });
      _initializeData();
    }
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      String path = Get.parameters['file'] ?? '';
      file = File(path);
    }

    if (user != null) {
      firstNameController.text = user!.firstName ?? '';
      lastNameController.text = user!.lastName ?? '';
      emailController.text = user!.email ?? '';
      phoneNumberController.text =
          user!.phoneNumber != null ? user!.phoneNumber.toString() : '';
      countryCallCode = user!.countryCallingCode ?? 65;
      avatar = user!.avatar ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getMyAccountScaffold;
    }, listener: (_, state) {
      if (state is EmployerUpdateAccountSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.employerTableName] =
              json.decode(json.encode(user!.employer));
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
        }
      }

      if (state is EmployerDeleteAvatarSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.employerTableName] =
              json.decode(json.encode(user!.employer));
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          setState(() {
            isDeleteAvatar = true;
            _getEmployerData();
            _getPhotoUrl();
          });
        }
      }

      if (state is EmployerUpdateAccountFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerDeleteAccountSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          DBUtils.clearData(DBUtils.loginName);
          DBUtils.clearLoginIn();
          Get.offAllNamed(signInPageRoute);
        }
      }

      if (state is EmployerDeleteAccountFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerCheckVerifiedSuccess) {
        Loading.cancelLoading();
        //_verifyMethod(verifiedType);
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

      if (state is EmployerCreateAvatarSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.employerTableName] =
              json.decode(json.encode(user!.employer));
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          setState(() {
            profileimage = true;
          });
          Get.offNamed(myAccountPageRoute);
        }
      }

      if (state is EmployerCreateAvatarFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerDeleteOfferSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _changeStatus();
        }
      }

      if (state is EmployerDeleteOfferFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerCreateOfferSuccess) {
        if (state.data.data != null) {
          Navigator.of(context).pop();
          showSuccessSnackBar(state.data.data!['message']);
          _changeStatus();
        }
      }

      if (state is EmployerCreateOfferFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerUpdateAppLanguageSuccess) {
        setState(() {
          language = state.language;
        });
      }

      if (state is EmployerUpdateAppLocaleSuccess) {
        setState(() {
          country = state.appLocale;
        });
      }
    });
  }

  Widget get _getMyAccountScaffold {
    return user != null
        ? BackgroundScaffold(
            onWillPop: () => Get.offAllNamed(rootRoute),
            scaffold: Scaffold(
              key: _scaffoldKey,
              appBar: _getAppBar,
              drawer: const SideMenu(
                menuName: '',
              ),
              backgroundColor: Colors.transparent,
              body: _getMyAccountContainer,
            ))
        : Container();
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/icons/menu.png")),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.myAccountText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getMyAccountContainer {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CardAccountInfo(
              onUploadPhoto: () => _showMediaActionModal(),
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              emailController: emailController,
              phoneNumberController: phoneNumberController,
              isDeleteAvatar: isDeleteAvatar,
              onStatusValueChanged: (value) {
                if (value != user!.employer!.availabilityStatus) {
                  // _updateAvaliability(value);
                  _changeCandiddateBigData(value);
                  setState(() {
                    status = value;
                  });
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            _getCountryILikeToWork,
            const SizedBox(
              height: 10,
            ),
            _getLanguage,
            const SizedBox(
              height: 15,
            ),
            _getDeleteAccount,
          ],
        ),
      ),
    );
  }

  _getTitle(String title) => Text(
        title,
        style: const TextStyle(
            color: AppColors.primaryGrey,
            fontSize: 12,
            fontWeight: FontWeight.w700),
      );

  getDecorationImage(
    ImageProvider imageProvider,
    bool isVideo,
  ) {
    if (avatar == '') {
      imageProvider = NetworkImage('$basePhotoUrl/$kDefaultAvatar');
    }
    return Container(
      height: 102,
      width: 102,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          )),
    );
  }

  //Action Modal
  _showMediaActionModal() => showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            title: Text(StringConst.chooseActionText,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            actions: _getImageViewActions),
      );

  Widget get _getDeleteAccount => GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => ErrorPopUp(
                title: StringConst.deleteAccountTitle,
                subTitle: StringConst.deleteAccountDesc,
                onAgreePressed: () => _deleteAccount(),
              )),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(Iconsax.profile_delete, color: AppColors.red),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    StringConst.deleteAccountText.tr,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Iconsax.arrow_right_25,
                    size: 22,
                    color: AppColors.primaryGrey,
                  ),
                ],
              ),
            )
          ],
        ),
      ));

  //Image Views Actions
  List<Widget> get _getImageViewActions => user!.avatar == kDefaultAvatar
      ? <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text(
              StringConst.updatePhotoText,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const UpdatePhotoModal(
                        route: myAccountPageRoute,
                        isOnlyPhoto: true,
                      ));
            },
          ),
        ]
      : <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text(
              StringConst.viewImageText,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            onPressed: () {
              Navigator.pop(context);

              ///TODO
              Get.toNamed(imageViewPageRoute, parameters: {
                'path': '$basePhotoUrl/${user!.avatar}',
                'preview': 'true',
                'type': 'network'
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              StringConst.deleteText,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            onPressed: () {
              Navigator.pop(context);
              _deleteAvatar();
            },
          ),
        ];

  //Update Account
  void _updateAccount() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerUpdateAccountRequestParams params =
        EmployerUpdateAccountRequestParams(
      userId: user!.id,
      token: user!.token,
      avatar: file,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      countryCallingCode:
          phoneNumberController.text.isNotEmpty ? countryCallCode : null,
      phoneNumber: phoneNumberController.text.isNotEmpty
          ? int.parse(phoneNumberController.text.toString())
          : null,
      isEmailVerified: user!.emailVerifiedDateTime != null ? 1 : 0,
      isPhoneVerified: user!.phoneNumberVerifiedDateTime != null ? 1 : 0,
    );
    employerBloc.add(EmployerUpdateAccountRequested(params: params));
  }

  _verifyMethod(String method) async {
    var data = await Get.toNamed(verifyAccountInfoPageRoute, parameters: {
      'method': method,
      'email': method == 'email' ? emailController.text.toString() : '',
      'phone_number':
          method == 'sms' ? phoneNumberController.text.toString() : '',
      'country_calling_code': method == 'sms' ? countryCallCode.toString() : '',
      'route': myAccountPageRoute
    });

    if (data != null) {
      _getEmployerData();
    }
  }

  _deleteAccount() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteAccountRequestParams params =
        EmployerDeleteAccountRequestParams(
            userId: user!.id, token: user!.token);
    employerBloc.add(EmployerDeleteAccountRequested(params: params));
  }

  _getPopupHeight(List<TextEditingController> requiredControllers) {
    double height = 200.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i].text.isEmpty) height += 20;
    }

    return height;
  }

  _deleteAvatar() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteAvatarRequestParams params =
        EmployerDeleteAvatarRequestParams(token: user!.token);
    employerBloc.add(EmployerDeleteAvatarRequested(params: params));
  }

  void _changeCandiddateBigData(String status) {
    switch (status) {
      case 'Not Available':
        _deleteBigData();
        break;
      default:
        _showChangeBigData(status);
        break;
    }
  }

  void _deleteBigData() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteOfferRequestParams params =
        EmployerDeleteOfferRequestParams(token: user!.token);
    employerBloc.add(EmployerDeleteOfferRequested(params: params));
  }

  _showChangeBigData(String status) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          builder: (context, scrollController) {
            return SaveOfferModal(
              controller: scrollController,
              status: status,
            );
          },
        );
      },
    );
  }

  void _changeStatus() {
    setState(() {
      avaliblityStatus = status;
      isDeleteAvatar = true;
    });
    employerData![DBUtils.employerTableName]['availability_status'] = status;
    DBUtils.saveNewData({'data': employerData}, DBUtils.employerTableName);
  }

  get _getCountryILikeToWork {
    return GestureDetector(
      onTap: () => Get.offNamed(countryOfWorkPageRoute),
      child: Container(
          constraints: const BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
              color: AppColors.primaryGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                    width: 150,
                    child: Text(
                      "Your Helper's \nCountry of Work".tr,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Row(
                children: [
                  Text(
                    country,
                    style: const TextStyle(
                        color: AppColors.primaryGrey, fontSize: 13),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Iconsax.arrow_right_25,
                    size: 22,
                    color: AppColors.primaryGrey,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  get _getLanguage {
    return GestureDetector(
      onTap: () => Get.offNamed(languageChangePageRoute),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.primaryGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                    width: 150,
                    child: Text(
                      'Application Language'.tr,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Row(
                children: [
                  Text(
                    language,
                    style: const TextStyle(
                        color: AppColors.primaryGrey, fontSize: 13),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Iconsax.arrow_right_25,
                    size: 22,
                    color: AppColors.primaryGrey,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
