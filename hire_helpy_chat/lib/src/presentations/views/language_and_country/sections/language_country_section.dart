part of '../../views.dart';

class LanguageCountrySection extends StatefulWidget {
  const LanguageCountrySection({super.key});

  @override
  State<LanguageCountrySection> createState() => _LanguageCountrySectionState();
}

class _LanguageCountrySectionState extends State<LanguageCountrySection> {
  String language = '';
  String country = '';
  String referCode = '';


  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      referCode = Get.parameters['refer_code'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getLanguageCountryScaffold;
  }

  get _getLanguageCountryScaffold => BackgroundScaffold(
          scaffold: Scaffold(
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: _getInitialLanguageContainer,
      ));

  get _getInitialLanguageContainer => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  StringConst.languageCountryTitle.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w100),
                ),
                const SizedBox(
                  height: 30,
                ),
                Table(
                  columnWidths: const {0: FixedColumnWidth(150.0)},
                  children: [
                    TableRow(children: [
                      _getTitle(StringConst.languageText.tr),
                      LanguageDropdownItem(
                        prefix: ConfigsKeyHelper.myAccountFormLanguageKey,
                        title: 'Language'.tr,
                        onValueChanged: (String value) {
                          setState(() {
                            language = value;
                          });
                          LanguageUtils.changeLanguage(language, context);
                        },
                        initialValue: language,
                        topCountries: const [],
                        icon: Iconsax.arrow_circle_down,
                      )
                    ]),
                    _getSpacerTableRow,
                    TableRow(children: [
                      _getTitle(StringConst.countryToWorkText.tr),
                      CountryDropdownItem(
                        prefix: ConfigsKeyHelper.firstTimeLoadCountryKey,
                        title: 'Country'.tr,
                        onValueChanged: (String value) {
                          setState(() {
                            country = value;
                          });
                        },
                        initialValue: country,
                        topCountries: const [],
                        icon: Iconsax.arrow_circle_down,
                      )
                    ])
                  ],
                ),
              ],
            ),
            _getGoToHomeButton,
          ],
        ),
      );

  _getTitle(String name) {
    return Text(
      name,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
    );
  }

  TableRow get _getSpacerTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  //Search Now Button
  Widget get _getGoToHomeButton {
    return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: Sizes.button47,
        margin: const EdgeInsets.only(bottom: 20.0),
        child: CustomPrimaryButton(
          text: referCode != '' ? StringConst.registerNow.tr : StringConst.gotoHomeText.tr,
          customColor:
              language != '' && country != '' ? null : AppColors.primaryGrey,
          onPressed: language != '' && country != ''
              ? () => _saveLangaugeAndCountry()
              : null,
        ));
  }

  _saveLangaugeAndCountry() {
    DBUtils.saveString(language, DBUtils.language);
    DBUtils.saveString(country, DBUtils.country);
    if (referCode != '') {
      Get.offAllNamed(registerPageRoute,
          parameters: {'refer_code': referCode});
      return;
    }
    Get.offAllNamed(rootRoute);
  }
}
