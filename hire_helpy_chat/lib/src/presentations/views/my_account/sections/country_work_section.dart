part of '../../views.dart';

class CountryWorkSection extends StatefulWidget {
  const CountryWorkSection({super.key});

  @override
  State<CountryWorkSection> createState() => _CountryWorkSectionState();
}

class _CountryWorkSectionState extends State<CountryWorkSection> {
  final TextEditingController searchController = TextEditingController();
  List<Country> countryList = [];
  String? country;
  Map? employerData;


  @override
  void initState() {
    _getEmployerData();
    _getCountryData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      country = box.get(DBUtils.country) ?? '';
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
        StringConst.countryText.tr,
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
            child: _getCountryAndName(
                country ?? '', "Your Domestic Helper's Country of Work".tr, 16, fontColor: AppColors.white),
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
            itemCount: countryList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _saveCountry(countryList[index].name ?? ''),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: _getCountryAndName(countryList[index].name ?? '',
                            countryList[index].name ?? '', 12),
                      ),
                      Container(
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
      _getCountryData();
    } else {
      setState(() {
        countryList = countryList.where((contact) {
          return contact.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  _getCountryAndName(String flag, String name,double fontSize, {Color? fontColor}) {
    return Row(
      children: [
        flag != 'Others'
            ? EmployerFlag(
                country: flag,
                configKey: ConfigsKeyHelper.firstTimeLoadCountryKey,
              )
            : Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                    child: Text(
                  flag.substring(0, 1),
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
              ),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
                fontSize: fontSize, color: fontColor ?? AppColors.white.withOpacity(0.7), fontWeight: fontColor != null ? FontWeight.w700: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  //Country Data List with top Countries
  void _getCountryData() async {
    List<Country> countryDataList = List<Country>.from(
        (await DBUtils.getKeyDataList(ConfigsKeyHelper.firstTimeLoadCountryKey))
            .map((e) => Country.fromJson(e)));
    setState(() {
      countryList = countryDataList;
    });
  }

  _saveCountry(String country) {
    _requestConfigsChange();
    DBUtils.saveString(country, DBUtils.country);
    Get.offAllNamed(myAccountPageRoute);
  }

  void _requestConfigsChange() {
    if (employerData != null) {
      final employerBloc = BlocProvider.of<EmployerBloc>(context);
      EmployerUpdateConfigsRequestParams params =
          EmployerUpdateConfigsRequestParams(
              token: employerData!['token'],
              path: 'app_locale',
              appLocale: country);
      employerBloc.add(EmployerUpdateConfigsRequested(params: params));
    }
  }
}
