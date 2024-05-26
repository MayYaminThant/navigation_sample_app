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

  Box? box;
  Map? candidateData;
  bool isPopUpMessage = false;
  User? user;
  int countryCallCode = 65;
  String basePhotoUrl = '';
  bool isClicked = false;
  String avatarPath = '';
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
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
  }

  Future<void> _getCandidateData() async {
    box = await Hive.openBox(DBUtils.dbName);
    candidateData = box!.get(DBUtils.candidateTableName);
    language = box!.get(DBUtils.language) ?? '';
    country = box!.get(DBUtils.country) ?? '';

    if (candidateData != null) {
      setState(() {
        user = UserModel.fromJson(candidateData!);
      });
      _initializeData();
    }
  }

  bool get checker {
    bool check = false;
    candidateData = box!.get(DBUtils.candidateTableName);
    final userData = UserModel.fromJson(candidateData!);
    userData.avatar == kDefaultAvatar ? check = true : check = false;
    return check;
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  // void _handleAvatarUpdate() {
  //   final articleBloc = BlocProvider.of<ArticleBloc>(context);
  //   if (articleBloc.tempFilesSet.length != 1) return;
  //   final newAvatarPath = articleBloc.tempFilesSet.elementAt(0);
  //   articleBloc.resetState();
  //   articleBloc.isOnlyPhoto = true;
  //   final newAvatarFile = File(newAvatarPath);
  //   _updateAvatar(newAvatarFile);
  // }

  void _initializeData() {
    if (user != null) {
      firstNameController.text = user!.firstName ?? '';
      lastNameController.text = user!.lastName ?? '';
      emailController.text = user!.email ?? '';
      phoneNumberController.text =
          user!.phoneNumber != null ? user!.phoneNumber.toString() : '';
      countryCallCode = user!.countryCallingCode ?? 65;
      avatarPath = user!.avatar ?? '';
    }
    // _handleAvatarUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getMyAccountScaffold;
    }, listener: (_, state) {
      if (state is CandidateUpdateAccountSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.candidateTableName] =
              json.decode(json.encode(user!.candidate));
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
        }
      }

      if (state is CandidateCreateAvatarLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is CandidateCreateAvatarSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.candidateTableName] =
              json.decode(json.encode(user!.candidate));
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          final userData = UserModel.fromJson(state.data.data!['data']);
          setState(() {
            avatarPath = userData.avatar ?? '';
          });
        }
      }

      if (state is CandidateDeleteAvatarFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateDeleteAvatarSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.candidateTableName] =
              json.decode(json.encode(user!.candidate));
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          final userData = UserModel.fromJson(state.data.data!['data']);
          setState(() {
            avatarPath = userData.avatar ?? '';
          });
        }
      }

      if (state is CandidateUpdateAccountFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateDeleteAccountSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          DBUtils.clearData(DBUtils.loginName);
          DBUtils.clearLoginIn();
          Get.offAllNamed(signInPageRoute);
        }
      }

      if (state is CandidateUpdateAppLanguageSuccess) {
        setState(() {
          language = state.language;
        });
      }

      if (state is CandidateUpdateAppLocaleSuccess) {
        setState(() {
          country = state.appLocale;
        });
      }

      if (state is CandidateDeleteAccountFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCheckVerifiedSuccess) {
        Loading.cancelLoading();
        _verifyMethod(verifiedType);
      }

      if (state is CandidateCheckVerifiedFail) {
        Loading.cancelLoading();
        setState(() {
          verifiedType = '';
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCreateAvatarFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateDeleteBigDataSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _changeStatus();
        }
      }

      if (state is CandidateDeleteBigDataFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCreateBigDataSuccess) {
        if (state.data.data != null) {
          Navigator.of(context).pop();
          showSuccessSnackBar(state.data.data!['message']);
          _changeStatus();
        }
      }

      if (state is CandidateCreateBigDataFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getMyAccountScaffold {
    return user != null
        ? BackgroundScaffold(
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
      physics: const BouncingScrollPhysics(),
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
              avatarPath: avatarPath,
              onStatusValueChanged: (value) {
                if (value != user!.candidate!.availabilityStatus) {
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

  //Action Modal
  void _showMediaActionModal() => showCupertinoModalPopup(
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
  List<Widget> get _getImageViewActions => checker
      ? <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text(
              StringConst.updatePhotoText,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final File? file =
                  await UploadMedia.uploadMediaData(context, isOnlyPhoto: true);
              if (file != null) {
                _updateAvatar(file);
              }
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
              Navigator.of(context).pop();
              Get.toNamed(fullscreenImageViewPageRoute, parameters: {
                'path': '$basePhotoUrl/$avatarPath',
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

  Future<void> _verifyMethod(String method) async {
    var data = await Get.toNamed(verifyAccountInfoPageRoute, parameters: {
      'method': method,
      'email': method == 'email' ? emailController.text.toString() : '',
      'phone_number':
          method == 'sms' ? phoneNumberController.text.toString() : '',
      'country_calling_code': method == 'sms' ? countryCallCode.toString() : '',
      'route': myAccountPageRoute
    });

    if (data != null) {
      await _getCandidateData();
    }
  }

  void _deleteAccount() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteAccountRequestParams params =
        CandidateDeleteAccountRequestParams(
            userId: user!.id, token: user!.token);
    candidateBloc.add(CandidateDeleteAccountRequested(params: params));
  }

  void _updateAvatar(File photo) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    final params = CandidateCreateAvatarRequestParams(
        token: user!.token, avatarFile: photo);
    candidateBloc.add(CandidateCreateAvatarRequested(params: params));
  }

  void _deleteAvatar() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteAvatarRequestParams params =
        CandidateDeleteAvatarRequestParams(token: user!.token);
    candidateBloc.add(CandidateDeleteAvatarRequested(params: params));
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
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteBigDataRequestParams params =
        CandidateDeleteBigDataRequestParams(token: user!.token);
    candidateBloc.add(CandidateDeleteBigDataRequested(params: params));
  }

  void _showChangeBigData(String status) {
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
            return SaveBigDataModal(
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
    candidateData![DBUtils.candidateTableName]['availability_status'] = status;
    DBUtils.saveNewData({'data': candidateData}, DBUtils.candidateTableName);
  }

  Widget get _getCountryILikeToWork => GestureDetector(
        onTap: () => Get.toNamed(countryOfWorkPageRoute),
        child: Container(
            height: 60,
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
                        StringConst.countryOfWorkText.tr,
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

  Widget get _getLanguage => GestureDetector(
        onTap: () => Get.toNamed(languageChangePageRoute),
        child: Container(
            height: 60,
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

  @override
  void dispose() {
    Loading.cancelLoading();
    super.dispose();
  }
}
