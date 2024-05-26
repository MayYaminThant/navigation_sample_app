part of '../../views.dart';

class DhProfileSection extends StatefulWidget {
  const DhProfileSection({super.key});

  @override
  State<DhProfileSection> createState() => _DhProfileSectionState();
}

class _DhProfileSectionState extends State<DhProfileSection> {
  List<AcademicQualification> academicQualificationList = [];
  String basePhotoUrl = '';
  Candidate? candidate;
  Map? candidateData;
  bool isLoading = true;
  List<String> itemInformationSkills = [];
  List<String> languageSkillList = [];
  String workPermitStatus = 'Unverified';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User? user;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getCandidateData();
  }

  @override
  void dispose() {
    Loading.cancelLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(scaffold: _getDhProfileScaffold);
  }

  Widget buildHeaderWorkingExperience() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          StringConst.workExperienceTitle.tr,
          style: const TextStyle(
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
              title == null ? "" : title.tr,
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
          candidate!.selfDesc ?? '',
          style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          candidate!.expectEmployer ?? '',
          style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Future<void> openShareProfile(String link) async {
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  //Work Permit
  Widget get buildWorkPermitValidity => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(StringConst.workPermitValidityText.tr,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Table(
            columnWidths: const {0: FixedColumnWidth(150)},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Text(
                  '${StringConst.statusText.tr}  -',
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
                ),
                _getWorkPermitStatus
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '${StringConst.expiryText.tr}  -',
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    candidate != null && candidate!.workPermit != null
                        ? DateFormat('dd MMM, yyyy').format(
                            DateTime.parse(candidate!.workPermit!.expiryDate!))
                        : StringConst.invalidText.tr,
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
      user = UserModel.fromJson(candidateData!);
      _requestCandidateProfile();
    });
  }

  void _requestCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRequestParams params = CandidateRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateProfileRequested(params: params));
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    basePhotoUrl = data;
  }

  Scaffold get _getDhProfileScaffold => Scaffold(
        key: _scaffoldKey,
        appBar: _getAppBar,
        drawer: const SideMenu(
          menuName: StringConst.myProfileText,
        ),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
          return isLoading
              ? LoadingScaffold.getLoading()
              : candidate != null &&
                      candidateData![DBUtils.candidateTableName] != null
                  ? _getDhProfileContainer
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: EmptyProfileContainer()));
        }, listener: (_, state) {
          if (state is CandidateProfileLoading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is CandidateProfileSuccess) {
            setState(() {
              isLoading = false;
            });
            if (state.data.data != null) {
              Candidate data =
                  CandidateModel.fromJson(state.data.data!['data']);
              setState(() {
                candidate = data;
                workPermitStatus = candidate!.workPermitStatus ?? '';
              });
              _addLanguages();
              _addSkills();
            }
          }

          if (state is CandidateProfileFail) {
            superPrint(state.message);
            setState(() {
              isLoading = false;
            });
            if (state.message != '') {
              superPrint(state.message);
            }
          }

          if (state is CandidateDeleteProfileLoading) {
            setState(() {
              isLoading = true;
            });
          }

          if (state is CandidateDeleteProfileSuccess) {
            setState(() {
              isLoading = false;
            });
            if (state.data.data != null) {
              showSuccessSnackBar(state.data.data!['message']);
              candidateData![DBUtils.candidateTableName] = null;
              DBUtils.saveNewData(
                  {'data': candidateData}, DBUtils.candidateTableName);
            }
          }

          if (state is CandidateDeleteProfileFail) {
            setState(() {
              isLoading = false;
            });
            if (state.message != '') {}
          }

          if (state is CandidateUpdateShareableLinkSuccess) {
            if (state.data.data != null) {
              state.data.data!['data']['token'] = candidateData!['token'];
              state.data.data!['data'][DBUtils.candidateTableName] =
                  json.decode(json.encode(candidate));
              DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);

              openShareProfile(
                  state.data.data!['data']['qr_code_shareable_link']);
            }
          }

          if (state is CandidateUpdateShareableLinkFail) {
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }
        }),
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
      title: Text(
        StringConst.myProfileText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [
        candidateData != null &&
                candidateData![DBUtils.candidateTableName] != null
            ? _popMenuButtonMyProfie()
            : Container()
      ],
    );
  }

  //Profile Container
  Widget get _getDhProfileContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            candidate!.media != null && candidate!.media!.isNotEmpty
                ? ImageSlider(media: candidate!.media ?? [])
                : Container(),
            buildmainDescription(),
            const SizedBox(
              height: 20,
            ),
            buildItemInformation(
                'Personal Information',
                [
                  '${candidate!.user!.firstName} ${candidate!.user!.lastName}',
                  candidate!.user!.email ?? '',
                  candidate!.user!.phoneNumber != null
                      ? '+${candidate!.user!.countryCallingCode} ${candidate!.user!.phoneNumber}'
                      : '',
                ],
                trailing: _getTrailingButton(aboutMePageRoute)),
            const SizedBox(
              height: 20,
            ),

            buildItemInformation(
                StringConst.languageInformation, languageSkillList,
                trailing: _getTrailingButton(aboutMePageRoute)),

            const SizedBox(
              height: 20,
            ),

            ///TODO
            buildItemInformation(
                StringConst.familyInformationTitle,
                [
                  _getFamilyInformation(),
                  candidate!.numOfSiblings != null
                      ? '${StringConst.numberOfSiblingsText.tr}: ${candidate!.numOfSiblings}'
                      : '',
                  _getFamilyMembers(),
                ],
                trailing: _getTrailingButton(familyInformationPageRoute)),

            const SizedBox(
              height: 20,
            ),

            buildItemInformation(
                'qualifications',
                [
                  candidate!.highestQualification != null
                      ? "${candidate!.highestQualification ?? ''} ${candidate!.educationJourneyDesc != null && candidate!.educationJourneyDesc != '' ? '(${candidate!.educationJourneyDesc})' : ''}"
                      : '',
                ],
                trailing: _getTrailingButton(skillAndQualificationPageRoute)),
            const SizedBox(
              height: 20,
            ),

            buildWorkPermitValidity,

            ///TODO
            buildItemInformation('skills', itemInformationSkills),
            const SizedBox(
              height: 20,
            ),
            buildHeaderWorkingExperience(),
            const SizedBox(
              height: 20,
            ),
            _getWorkExperienceListView,

            const SizedBox(
              height: 20,
            ),
            buildItemInformation(
                StringConst.workingPreferenceTitle, _getWorkingPreferences(),
                trailing: _getTrailingButton(workingPreferencesPageRoute)),
          ],
        ),
      ),
    );
  }

  String _getFamilyInformation() {
    return candidate!.familyStatus ?? '';
  }

  //Working Experience
  Widget get _getWorkExperienceListView => candidate != null &&
          candidate!.employments != null &&
          candidate!.employments!.isNotEmpty
      ? ListView.builder(
          itemCount: candidate!.employments!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return EmploymentItem(
                employment: candidate!.employments![index],
                userId: candidateData!['user_id'],
                token: candidateData!['token'],
                isShowMenu: false);
          })
      : const Text(
          '\u2022 No Work Experience',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryGrey,
            fontWeight: FontWeight.w400,
          ),
        );

  List<String?> _getWorkingPreferences() {
    return [
      candidate!.restDayChoice != null
          ? "${candidate!.restDayChoice ?? 0} Rest days per month ${candidate!.restDayWorkPref! ? '(Work on rest days)' : '(*Not willing to work on rest days)'}"
          : '',
      'Preferred Task: ${_getPreferedTasks()}',
      'Additional Working Preferences:${candidate!.workReligionPref ?? ''}',
      'Food & Drug Allergy:${candidate!.foodAllergy ?? ''}',
    ];
  }

  void _addLanguages() {
    if (candidate!.proficientEnglish!) {
      _checkAddLanguage('Proficient English');
    }
    if (candidate!.chineseMandarin!) {
      _checkAddLanguage('Chinese Mandarin');
    }
    if (candidate!.bahasaMelayu!) {
      _checkAddLanguage('Bahasa Melayu');
    }
    if (candidate!.tamil!) {
      _checkAddLanguage('Tamil');
    }
    if (candidate!.hokkien!) {
      _checkAddLanguage('Hokkien');
    }
    if (candidate!.teochew!) {
      _checkAddLanguage('Tecochew');
    }
    if (candidate!.cantonese!) {
      _checkAddLanguage('Cantonese');
    }
    if (candidate!.bahasaIndonesian!) {
      _checkAddLanguage('Bahasa Indonesian');
    }
    if (candidate!.japanese!) {
      _checkAddLanguage('Japanese');
    }
    if (candidate!.korean!) {
      _checkAddLanguage('Korean');
    }
    if (candidate!.french!) {
      _checkAddLanguage('French');
    }
    if (candidate!.german!) {
      _checkAddLanguage('German');
    }

    if (candidate!.othersSpecify != null) {
      _checkAddLanguage(candidate!.othersSpecify!);
    }
  }

  String _getFamilyMembers() {
    if (candidate!.familyMembers!.isNotEmpty) {
      String familyMembers = '';
      for (int i = 0; i < candidate!.familyMembers!.length; i++) {
        familyMembers +=
            '${candidate!.familyMembers![i]['member_type']} (${int.parse((DateTime.now().difference(DateTime(candidate!.familyMembers![i]['pivot']['member_dob_year'])).inDays / 365).toStringAsFixed(0))} years)${i != candidate!.familyMembers!.length - 1 ? ' , ' : ''}';
      }
      return familyMembers;
    } else {
      return '';
    }
  }

  void _addSkills() {
    if (candidate!.skillGeneralHousework != null &&
        candidate!.skillGeneralHousework!) {
      _checkAddSkill('General Housework');
    }
    if (candidate!.skillInfantCare != null && candidate!.skillInfantCare!) {
      _checkAddSkill('Infant Care');
    }
    if (candidate!.skillElderlyCare != null && candidate!.skillElderlyCare!) {
      _checkAddSkill('Elderly Care');
    }
    if (candidate!.skillPetCare != null && candidate!.skillPetCare!) {
      _checkAddSkill('Pet Care');
    }
    if (candidate!.skillCooking != null && candidate!.skillCooking!) {
      _checkAddSkill('Cooking');
    }
    if (candidate!.skillSpecialNeedsCare != null &&
        candidate!.skillSpecialNeedsCare!) {
      _checkAddSkill('Special Needs Care');
    }
    if (candidate!.skillbedriddenCare != null &&
        candidate!.skillbedriddenCare!) {
      _checkAddSkill('Bedidden Care');
    }
    if (candidate!.skillHandicapCare != null && candidate!.skillHandicapCare!) {
      _checkAddSkill('Handicap Care');
    }
    if (candidate!.skillOthersSpecify != null) {
      _checkAddSkill(candidate!.skillOthersSpecify!);
    }
  }

  String _getPreferedTasks() {
    if (candidate!.tasksTypes!.isNotEmpty) {
      String tasksList = '';
      for (int i = 0; i < candidate!.tasksTypes!.length; i++) {
        if (i != candidate!.tasksTypes!.length - 1) {
          tasksList += '${candidate!.tasksTypes![i].taskType}, ';
        } else {
          tasksList += '${candidate!.tasksTypes![i].taskType}';
        }
      }
      return tasksList;
    } else {
      return '';
    }
  }

  Widget _getTrailingButton(String nextRoute) {
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

  void _checkAddSkill(String skilleName) {
    if (!itemInformationSkills.contains(skilleName)) {
      itemInformationSkills.add(skilleName);
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
              child: Center(
                child: Text(
                  'Share Profile'.tr,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) async {
        switch (value) {
          case 'share':
            await _shareProfileShortLink();
            break;
          case 'delete':
            showDialog(
                context: context,
                builder: (context) => ErrorPopUp(
                      title: StringConst.deleteProfileTitle,
                      onAgreePressed: () => _deleteProfile(),
                    ));
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

  Future<void> _shareProfileShortLink() async {
    Uri data = await _getInviteLink();
    String link = "$data";
    _requestUpdateShareableLink(link);
  }

  Future<Uri> _getInviteLink() async {
    return await ShortLink.createProfileShortLink(
        candidateData!['user_id'].toString(), kShortLinkProfile);
  }

  void _deleteProfile() {
    Navigator.of(context).pop();
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteProfileRequestParams params =
        CandidateDeleteProfileRequestParams(
            candidateId: candidate!.id, token: candidateData!['token']);
    candidateBloc.add(CandidateDeleteProfileRequested(params: params));
  }

  void _requestUpdateShareableLink(String link) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateShareableLinkRequestParams params =
        CandidateUpdateShareableLinkRequestParams(
            token: candidateData!['token'],
            userId: candidateData!['user_id'],
            link: link);
    candidateBloc.add(CandidateUpdateShareableLinkRequested(params: params));
  }

  Color getWorkPermitColor() {
    switch (workPermitStatus) {
      case 'Pending':
        return AppColors.primaryColor;
      case 'Verified':
        return AppColors.green;
      default:
        return AppColors.red;
    }
  }

  //WorkPermit Status
  Widget get _getWorkPermitStatus => FutureBuilder<dynamic>(
        future: StringUtils.getWorkPermitVerifyDelayValue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: getWorkPermitColor(),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                snapshot.data == 24 && workPermitStatus == 'Pending'
                    ? 'Pending 48 Hrs Verification'.tr
                    : workPermitStatus.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.white, fontSize: 14),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Text("Await for data");
        },
      );
}
