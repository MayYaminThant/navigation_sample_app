part of '../../views.dart';

class LanguageChangeSection extends StatefulWidget {
  const LanguageChangeSection({super.key});

  @override
  State<LanguageChangeSection> createState() => _LanguageChangeSectionState();
}

class _LanguageChangeSectionState extends State<LanguageChangeSection> {
  final TextEditingController searchController = TextEditingController();
  List<ConfigLanguage> languageList = [];
  String? language;
  Map? employerData;

  @override
  void initState() {
    _getEmployerData();
    _getLanguageData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      language = box.get(DBUtils.language) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getCountryWorkScaffold;
  }

  Widget get _getCountryWorkScaffold {
    return BackgroundScaffold(
        onWillPop: _backButtonPressed,
        scaffold: Scaffold(
          appBar: _getAppBar,
          backgroundColor: Colors.transparent,
          body: _getCountryWorkContainer,
        ));
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: _backButtonPressed,
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.languageText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  _backButtonPressed() {
    Get.offNamed(
      myAccountPageRoute,
    );
  }

  Widget get _getCountryWorkContainer {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _getCountryAndName('Application Language'.tr, 16,
                fontColor: AppColors.white,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Iconsax.translate,
                    color: AppColors.white,
                  ),
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.padding20,
              vertical: Sizes.padding20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getCountryWorkTextForm,
                const SizedBox(
                  height: 10,
                ),
                _getCountryWorkList,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _getCountryWorkTextForm {
    return CustomTextField(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardColor.withOpacity(0.1)),
      maxLine: 1,
      backgroundColor: AppColors.cardColor.withOpacity(0.1),
      controller: searchController,
      textInputType: TextInputType.text,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.cardColor,
      ),
      hasPrefixIcon: true,
      hasTitle: true,
      isRequired: true,
      titleStyle: const TextStyle(
        color: AppColors.white,
        fontSize: Sizes.textSize14,
      ),
      onChanged: (value) => _filterSearch(value),
      hasTitleIcon: false,
      enabledBorder: Borders.noBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      hintTextStyle:
          const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
      textStyle: const TextStyle(color: AppColors.primaryGrey),
      hintText: "Search",
    );
  }

  Widget get _getCountryWorkList {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: languageList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _saveLanguage(languageList[index].language ?? ''),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: _getCountryAndName(
                            languageList[index].language ?? '', 14,
                            subTitle: languageList[index].languageName),
                      ),
                      if (index != languageList.length-1) Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 0.5,
                        width: MediaQuery.of(context).size.width - 80,
                        color: AppColors.primaryGrey,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  _filterSearch(String query) {
    if (query == '') {
      _getLanguageData();
    } else {
      setState(() {
        languageList = languageList.where((contact) {
          return contact.language!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  _getCountryAndName(String name, double fontSize,
      {Color? fontColor, Widget? leading, String? subTitle}) {
    return Row(
      children: [
        leading ?? const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: fontSize,
                    color: fontColor ?? AppColors.white.withOpacity(0.7),
                    fontWeight: fontColor != null
                        ? FontWeight.w700
                        : FontWeight.normal),
              ),
              subTitle != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryGrey.withOpacity(0.7),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }

  //Country Data List with top Countries
  void _getLanguageData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    language = box.get(DBUtils.language) ?? '';
    List<ConfigLanguage> dataList = await LanguageUtils.getMyAccountFormConfigLanguages();
    setState(() {
      languageList.addAll(dataList);
    });
  }

  _saveLanguage(String language) {
    _requestConfigsChange();
    DBUtils.saveString(language, DBUtils.language);
    LanguageUtils.changeLanguage(language, context);
    Get.offAllNamed(myAccountPageRoute);
  }

  void _requestConfigsChange() {
    if (employerData != null) {
      final employerBloc = BlocProvider.of<EmployerBloc>(context);
      EmployerUpdateConfigsRequestParams params =
          EmployerUpdateConfigsRequestParams(
              token: employerData!['token'],
              path: 'app_language',
              preferredLanguage: language);
      employerBloc.add(EmployerUpdateConfigsRequested(params: params));
    }
  }
}
