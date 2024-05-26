part of 'widgets.dart';

class CountryMyAccountDropdownItem extends StatefulWidget {
  const CountryMyAccountDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.backgroundColor,
      this.iconList,
      this.textColor,
      required this.topCountries,
      this.prefix})
      : super(key: key);

  final Color? backgroundColor;
  final String? iconList;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final List<String> topCountries;
  final String? prefix;

  @override
  State<CountryMyAccountDropdownItem> createState() =>
      _CountryMyAccountDropdownItemState();
}

class _CountryMyAccountDropdownItemState
    extends State<CountryMyAccountDropdownItem> {
  List<Country> countryList = [];
  String value = '';

  @override
  void didUpdateWidget(covariant CountryMyAccountDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _getCountryData();
    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, Country? item, bool? popup) {
    if (item == null || item.name == 'Any Country') {
      return _getAnyCountry(AppColors.black, 10.0, 10.0);
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          children: [
            EmployerFlag(
              country: item.name ?? 'Singapore',
            ),
            Expanded(
              child: Text(
                item.name ?? '',
                style: TextStyle(
                    fontSize: 12, color: AppColors.black.withOpacity(0.7)),
              ),
            ),
          ],
        ));
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    Country? item,
  ) {
    if (item == null) {
      return _getAnyCountry(widget.textColor ?? AppColors.white, 10.0, 0.0);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Country you like to work in',
            style: TextStyle(
                fontSize: 12,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
          ),
          Text(
            item.name ?? '',
            style: TextStyle(
                fontSize: 12,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  //Custom Drop down button
  Widget get _customDropDownButton => const Padding(
        padding: EdgeInsets.only(left: 0, bottom: 10, right: 5),
        child: SizedBox(
          width: 10,
          height: 10,
          child: Icon(
            Iconsax.arrow_right_25,
            size: 22,
            color: AppColors.primaryGrey,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primaryGrey,
        ),
        child: DropdownSearch<Country>(
          key: UniqueKey(),
          mode: Mode.menu,
          filterFn: (city, item) => city
                  .toString()
                  .toLowerCase()
                  .contains(item.toString().toLowerCase())
              ? true
              : false,
          enabled: true,

          items: countryList,
          // ignore: prefer_const_constructors
          dropdownSearchDecoration: InputDecoration(
            // ignore: prefer_const_constructors
            hintText: widget.title.toString().replaceFirst('Select ', ''),
            hintStyle: const TextStyle(color: AppColors.primaryGrey),
            // ignore: prefer_const_constructors
            labelStyle: TextStyle(color: Colors.grey),

            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (Object? object) {
            Country country = object as Country;
            setState(() {
              value = country.name ?? '';
            });
            widget.onValueChanged(value);
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: value != '' && countryList.isNotEmpty
              ? countryList[countryList.indexWhere((f) => f.name == value)]
              : null,
          showSearchBox: false,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // dropdownButtonBuilder: _customDropDownButton,
          popupItemBuilder: _customPopupItemBuilder,
          dropdownBuilder: _customDropdownBuilder,
        ),
      ),
    );
  }

  _getAnyCountry(Color textColor, double padding, double margin) => Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Country you like to work in',
              style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
            ),
          ],
        ),
      );

  //Country Data List with top Countries
  void _getCountryData() async {
    List<Country> countryDataList = List<Country>.from((widget.prefix != null
            ? DBUtils.getKeyDataList
            : await DBUtils.getCountryList)
        .map((e) => Country.fromJson(e)));
    if (widget.prefix == null) {
      for (int i = 0; i < widget.topCountries.length; i++) {
        if (countryDataList.indexWhere((f) =>
                f.alpha2Code!.toLowerCase() ==
                widget.topCountries[i].toLowerCase()) !=
            -1) {
          setState(() {
            countryList.add(countryDataList[countryDataList.indexWhere((f) =>
                f.alpha2Code!.toLowerCase() ==
                widget.topCountries[i].toLowerCase())]);
            countryDataList.remove(countryDataList[countryDataList.indexWhere(
                (f) =>
                    f.alpha2Code!.toLowerCase() ==
                    widget.topCountries[i].toLowerCase())]);
          });
        }
      }
    }
    countryDataList.add(Country(
        name: 'Any Country', alpha2Code: '', dialCode: '', flagUri: ''));
    setState(() {
      countryList.addAll(countryDataList);
    });
  }
}
