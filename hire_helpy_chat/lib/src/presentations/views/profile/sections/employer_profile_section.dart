part of '../../views.dart';

class EmployerProfileSection extends StatefulWidget {
  const EmployerProfileSection({super.key});

  @override
  State<EmployerProfileSection> createState() => _EmployerProfileSectionState();
}

class _EmployerProfileSectionState extends State<EmployerProfileSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? employerData;
  Employer? employer;
  List<FamilyStatus> familyStatusList = [];
  List<AcademicQualification> academicQualificationList = [];
  String basePhotoUrl = '';
  List<String> languageSkillList = [];
  List<String> itemInformationSkills = [];
  bool isLoading = false;
  User? user;

  @override
  void initState() {
    _getEmployerData();
    _getPhotoUrl();
    //_getFamilyInformationData();
    //_getAcademicQualificationData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      user = UserModel.fromJson(employerData!);
      if (user != null && employerData![DBUtils.employerTableName] != null) {
        _requestEmployerProfile();
      }
    });
  }

  void _requestEmployerProfile() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerRequestParams params = EmployerRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    employerBloc.add(EmployerProfileRequested(params: params));
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    basePhotoUrl = data;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: () => Get.offAllNamed(rootRoute),
          scaffold:
              isLoading ? LoadingScaffold.getLoading() : _getDhProfileScaffold);
    }, listener: (_, state) {
      if (state is EmployerProfileLoading) {
        setState(() {
          isLoading = true;
        });
      }

      if (state is EmployerProfileSuccess) {
        setState(() {
          isLoading = false;
        });
        if (state.data.data != null) {
          Employer data = EmployerModel.fromJson(state.data.data!['data']);
          setState(() {
            employer = data;
          });
          _addLanguages();
        }
      }

      if (state is EmployerProfileFail) {
        setState(() {
          isLoading = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerDeleteProfileLoading) {
        setState(() {
          isLoading = true;
        });
      }

      if (state is EmployerDeleteProfileSuccess) {
        setState(() {
          isLoading = false;
        });
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          employerData![DBUtils.employerTableName] = null;
          DBUtils.saveNewData(
              {'data': employerData}, DBUtils.employerTableName);
        }
      }

      if (state is EmployerDeleteProfileFail) {
        setState(() {
          isLoading = false;
        });
        if (state.message != '') {}
      }

      if (state is EmployerUpdateShareableLinkSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = employerData!['token'];
          state.data.data!['data'][DBUtils.employerTableName] =
              json.decode(json.encode(employer));
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);

          openShareProfile(state.data.data!['data']['qr_code_shareable_link']);
        }
      }

      if (state is EmployerUpdateShareableLinkFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getDhProfileScaffold => Scaffold(
        key: _scaffoldKey,
        appBar: _getAppBar,
        drawer: const SideMenu(
          menuName: StringConst.myProfileText,
        ),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body:
            employer != null && employerData![DBUtils.employerTableName] != null
                ? _getDhProfileContainer
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: EmptyProfileContainer())),
      );

  //Get AppBar
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
      title: const Text(
        StringConst.myProfileText,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [
        if (employerData != null &&
            employerData![DBUtils.employerTableName] != null)
          _popMenuButtonMyProfie()
      ],
    );
  }

  //Profile Container
  Widget get _getDhProfileContainer {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            employer!.media != null && employer!.media!.isNotEmpty
                ? ImageSlider(media: employer!.media ?? [])
                : Container(),
            buildmainDescription(),
            const SizedBox(
              height: 20,
            ),
            buildItemInformation(
                'Personal Information'.tr,
                [
                  '${employer!.user!.firstName} ${employer!.user!.lastName}',
                  employer!.user!.email,
                  employer!.user!.phoneNumber != null
                      ? '+${employer!.user!.countryCallingCode} ${employer!.user!.phoneNumber}'
                      : '',
                ],
                trailing: _getTrailingButton(aboutMePageRoute)),

            const SizedBox(
              height: 20,
            ),

            ///TODO
            buildItemInformation(
                'Family Information'.tr,
                [
                  _getFamilyInformation(),
                  _getFamilyMembers(),
                ],
                trailing: _getTrailingButton(familyInformationPageRoute)),
            const SizedBox(
              height: 20,
            ),

            buildItemInformation(
                StringConst.languageInformationText.tr, languageSkillList,
                trailing: _getTrailingButton(languagePageRoute)),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderWorkingExperience() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Working Experience',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
        ),
        _getTrailingButton(workExperiencePageRoute)
      ],
    );
  }

  Widget buildItemInformation(String? title, List<String?> itemInformation,
      {Widget? trailing}) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600),
            ),
            trailing ?? Container()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
            itemCount: itemInformation.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return itemInformation[index] != ''
                  ? Text(
                      '\u2022 ${itemInformation[index]!}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox.shrink();
            })
      ]),
    );
  }

  Widget buildmainDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          employer!.selfDesc ?? '',
          style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          employer!.expectCandidate ?? '',
          style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  _getFamilyInformation() {
    return employer!.familyStatus;
  }

  void _addLanguages() {
    if (employer!.languageProficientEnglish!) {
      _checkAddLanguage('Proficient English');
    }
    if (employer!.languageChineseMandarin!) {
      _checkAddLanguage('Chinese Mandarin');
    }
    if (employer!.languageBahasaMelayu!) {
      _checkAddLanguage('Bahasa Melayu');
    }
    if (employer!.languageTamil!) {
      _checkAddLanguage('Tamil');
    }
    if (employer!.languageHokkien!) {
      _checkAddLanguage('Hokkien');
    }
    if (employer!.languageTeochew!) {
      _checkAddLanguage('Tecochew');
    }
    if (employer!.languageCantonese!) {
      _checkAddLanguage('Cantonese');
    }
    if (employer!.languageBahasaIndonesian!) {
      _checkAddLanguage('Bahasa Indonesian');
    }
    if (employer!.languageJapanese!) {
      _checkAddLanguage('Japanese');
    }
    if (employer!.languageKorean!) {
      _checkAddLanguage('Korean');
    }
    if (employer!.languageFrench!) {
      _checkAddLanguage('French');
    }
    if (employer!.languageGerman!) {
      _checkAddLanguage('German');
    }

    if (employer!.languageOthersSpecify != null) {
      _checkAddLanguage(employer!.languageOthersSpecify!);
    }
  }

  _getFamilyMembers() {
    if (employer!.familyMembers!.isNotEmpty) {
      String familyMembers = '';
      for (int i = 0; i < employer!.familyMembers!.length; i++) {
        familyMembers +=
            '${employer!.familyMembers![i]['pivot']['member_type']} (${int.parse((DateTime.now().difference(DateTime(employer!.familyMembers![i]['pivot']['member_dob_year'])).inDays / 365).toStringAsFixed(0))} years)${i != employer!.familyMembers!.length - 1 ? ' , ' : ''}';
      }
      return familyMembers;
    } else {
      return '';
    }
  }

  _getTrailingButton(String nextRoute) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(nextRoute, parameters: {'route': dhProfilePageRoute}),
      child: const Icon(
        Iconsax.magicpen,
        color: AppColors.primaryColor,
      ),
    );
  }

  void _checkAddLanguage(String languageName) {
    if (!languageSkillList.contains(languageName)) {
      languageSkillList.add(languageName);
    }
  }

  Widget _popMenuButtonMyProfie() {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      offset: const Offset(0, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      elevation: 0,
      constraints: const BoxConstraints.tightFor(width: 160),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 4,
            value: 'share',
            child: Container(
              height: 47,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: const Center(
                child: Text(
                  'Share Profile',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) {
        switch (value) {
          case 'share':
            // employerData!['qr_code_shareable_link'] != null
            //     ? openShareProfile(employerData!['qr_code_shareable_link'])
            //     :
            _shareProfileShortLink();
            break;
          default:
            break;
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(Icons.more_vert, color: Colors.white),
      ),
    );
  }

  void _shareProfileShortLink() async {
    String link = (await _getInviteLink()).toString();
    _requestUpdateShareableLink(link);
  }

  _getInviteLink() async {
    return await ShortLink.createProfileShortLink(
        employerData!['user_id'].toString(), kShortLinkProfile);
  }

  _deleteProfile() {
    Navigator.of(context).pop();
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteProfileRequestParams params =
        EmployerDeleteProfileRequestParams(
            employerId: employer!.id, token: employerData!['token']);
    employerBloc.add(EmployerDeleteProfileRequested(params: params));
  }

  void _requestUpdateShareableLink(String link) {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerUpdateShareableLinkRequestParams params =
        EmployerUpdateShareableLinkRequestParams(
            token: employerData!['token'],
            userId: employerData!['user_id'],
            link: link);
    employerBloc.add(EmployerUpdateShareableLinkRequested(params: params));
  }

  openShareProfile(String link) async {
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }
}
