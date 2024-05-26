part of 'widgets.dart';

class CurrencyDropDownItem extends StatefulWidget {
  const CurrencyDropDownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.iconList,
      this.textColor,
      this.showFlag = true,
      required this.prefix})
      : super(key: key);

  final String? iconList;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final String? prefix;
  final bool showFlag;

  @override
  State<CurrencyDropDownItem> createState() => _CurrencyDropDownItemState();
}

class _CurrencyDropDownItemState extends State<CurrencyDropDownItem> {
  List<Country> countryList = [];
  String selectedCountryCode = '';
  Country selectedCountry = Country(
    name: "Singapore",
    alpha2Code: "SG",
    dialCode: null,
    flagUri: "assets/flags/sg.png",
    currency: "SGD",
  );

  @override
  void initState() {
    _getCountryData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CurrencyDropDownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      selectedCountryCode = widget.initialValue;
      if (countryList.toString().contains(selectedCountryCode)) {
        String data =
            countryList[countryList.indexWhere((f) => f.name == selectedCountryCode || f.currency == selectedCountryCode)]
                    .currency ??
                '';

        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onValueChanged(data);
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _getCountryData() async {
    List<Country> cList = [];
    var data = await DBUtils.getKeyDataList(widget.prefix);
    for (var element in data) {
      cList.add(Country.fromJson(element));
    }
    countryList = List.from(cList);
      selectedCountryCode = widget.initialValue;
    setState(() {
      selectedCountry = countryList.firstWhere((element) {
        return element.name == selectedCountryCode || element.currency == selectedCountryCode;
      });
    });
    widget.onValueChanged(selectedCountry.currency ?? '');
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(Country data) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Row(
        children: [
          widget.showFlag
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      image: DecorationImage(
                          image: AssetImage(data.flagUri), fit: BoxFit.cover)),
                )
              : Container(),
          Expanded(
            child: Text(
              data.currency ?? '',
              style: TextStyle(
                  fontSize: 12, color: AppColors.black.withOpacity(0.7)),
            ),
          ),
        ],
      ));

  Widget get _customDropdownBuilder => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.showFlag
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      image: DecorationImage(
                          image: AssetImage(selectedCountry.flagUri),
                          fit: BoxFit.cover)),
                )
              : Container(),
          Text(
            selectedCountry.currency ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
          ),
        ],
      );

  //Custom Drop down button
  Widget get _customDropDownButton => const Padding(
        padding: EdgeInsets.only(left: 0, bottom: 10, right: 0),
        child: SizedBox(
          width: 5,
          height: 5,
          child: Icon(
            Iconsax.arrow_down5,
            size: 22,
            color: AppColors.primaryGrey,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
          dropdownSearchDecoration: InputDecoration(
            hintText: widget.title.toString().replaceFirst('Select ', ''),
            hintStyle: const TextStyle(color: AppColors.primaryGrey),
            labelStyle: const TextStyle(color: Colors.grey),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (Object? object) {
            selectedCountry = object as Country;
            setState(() {
              selectedCountryCode = selectedCountry.name ?? '';
            });
            widget.onValueChanged(selectedCountry.currency ?? '');
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: selectedCountry,
          showSearchBox: false,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          popupItemBuilder: (context, item, isSelected) =>
              _customPopupItemBuilder(item),
          dropdownBuilder: (context, selectedItem) => _customDropdownBuilder,
        ),
      ),
    );
  }
}
