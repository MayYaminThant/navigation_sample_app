part of 'widgets.dart';

class CountryDropdownItem extends StatefulWidget {
  const CountryDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      this.showOnlyIcon,
      this.backgroundColor,
      this.iconList,
      this.textColor,
      this.secondryColor,
      this.topCountries = const [],
      this.prefix,
      this.icon})
      : super(key: key);

  final Color? backgroundColor;
  final String? iconList;
  final bool? showOnlyIcon;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final Color? secondryColor;
  final List<String> topCountries;
  final String? prefix;
  final IconData? icon;

  @override
  State<CountryDropdownItem> createState() => _CountryDropdownItemState();
}

class _CountryDropdownItemState extends State<CountryDropdownItem> {
  List<Country> countryList = [];
  String value = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant CountryDropdownItem oldWidget) {
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
  Widget _customPopupItemBuilder(Country? item, bool? popup) {
    if (item == null) {
      return const Text('Country');
    }
    return item.name == 'Others' || item.name == 'ANY'
        ? _getAnyCountry(item.name ?? '',
            widget.textColor ?? AppColors.black.withOpacity(0.7), 18.0, 10.0)
        : Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          image: DecorationImage(
                              image: AssetImage(item.flagUri),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.black.withOpacity(0.7)),
                      ),
                    )
                  ],
                ),
              ],
            ));
  }

  Widget _customDropdownBuilder(
    Country? item,
  ) {
    if (item == null || item.name == 'Any Country') {
      return Container();
      //return _getAnyCountry(widget.textColor ?? AppColors.white, 10.0, 0.0);
    }
    return item.name == 'Others' || item.name == 'ANY'
        ? _getAnyCountry(item.name ?? '',
            widget.textColor ?? AppColors.white.withOpacity(0.7), 10.0, 0.0)
        : Row(
            children: [
              EmployerFlag(
                country: item.name ?? 'Singapore',
                configKey: widget.prefix,
              ),
              widget.showOnlyIcon != null && widget.showOnlyIcon!
                  ? Container()
                  : Expanded(
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                            fontSize: 11,
                            color: widget.textColor ??
                                AppColors.white.withOpacity(0.7)),
                      ),
                    ),
            ],
          );
  }

  //Custom Drop down button
  Widget get _customDropDownButton => Padding(
        padding: EdgeInsets.only(
            left: 0, bottom: 10, right: widget.icon != null ? 20 : 0),
        child: SizedBox(
          width: 10,
          height: 10,
          child: Icon(
            widget.icon ?? Iconsax.arrow_down5,
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
        color: widget.backgroundColor ?? AppColors.cardColor.withOpacity(0.1),
        //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        // border: const GradientBoxBorder(
        //   gradient: LinearGradient(colors: [
        //     Color(0xFFFFB6A0),
        //     Color(0xFFA5E3FD),
        //     Color(0xFF778AFF),
        //     Color(0xFFFFCBF2),
        //   ]),
        //   width: 1,
        // ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.white,
        ),
        child: DropdownSearch<Country>(
          mode: Mode.bottomSheet,
          enabled: true,
          filterFn: (item, filter) => item!.name
                  .toString()
                  .toLowerCase()
                  .contains(_controller.text.toLowerCase())
              ? true
              : false,
          onPopupDismissed: () => _controller.clear(),
          items: countryList,
          // ignore: prefer_const_constructors
          dropdownSearchDecoration: InputDecoration(
            // ignore: prefer_const_constructors
            hintText: widget.title.toString().replaceFirst('Select ', '').tr,
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
            _controller.clear();
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: value != '' &&
                  countryList.isNotEmpty &&
                  countryList.indexWhere((f) => f.name == value) != -1
              ? countryList[countryList.indexWhere((f) => f.name == value)]
              : null,
          showSearchBox: true,

          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // dropdownButtonBuilder: _customDropDownButton,
          popupItemBuilder: (context, item, isSelected) =>
              _customPopupItemBuilder(item, isSelected),
          dropdownBuilder: (context, selectedItem) =>
              _customDropdownBuilder(selectedItem),
          searchFieldProps: TextFieldProps(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search'.tr,
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          popupTitle: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                StringConst.countryText.tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAnyCountry(
          String text, Color textColor, double padding, double margin) =>
      Row(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: padding, vertical: margin),
            child: Container(
              margin: EdgeInsets.only(left: margin),
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.primaryGrey,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Center(
                  child: Text(
                text.substring(0, 1),
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 12,
                color: widget.secondryColor ?? textColor.withOpacity(0.7)),
          ),
        ],
      );

  //Country Data List with top Countries
  Future<void> _getCountryData() async {
    List<dynamic>? data = widget.prefix != null
        ? await DBUtils.getKeyDataList(widget.prefix)
        : await DBUtils.getCountryList;
    if (data != null) {
      List<Country> countryDataList =
          List<Country>.from(data.map((e) => Country.fromJson(e)));
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
      setState(() {
        countryList.addAll(countryDataList);
      });
    }
  }
}
