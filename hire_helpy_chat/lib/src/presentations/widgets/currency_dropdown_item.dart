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
      required this.prefix})
      : super(key: key);

  final String? iconList;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final String? prefix;

  @override
  State<CurrencyDropDownItem> createState() => _CurrencyDropDownItemState();
}

class _CurrencyDropDownItemState extends State<CurrencyDropDownItem> {
  List<Country> countryList = [];
  String selectedCountryCode = '';

  @override
  void didUpdateWidget(covariant CurrencyDropDownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      selectedCountryCode = widget.initialValue;
      if (countryList.toString().contains(selectedCountryCode)) {
        String data =
            countryList[countryList.indexWhere((f) => f.name == selectedCountryCode)]
                    .currency ??
                '';

        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onValueChanged(data);
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _getCountryData();
    super.initState();
  }

  void _getCountryData() async {
    List<Country> countryDataList = List<Country>.from(
        (await DBUtils.getKeyDataList(widget.prefix))
            .map((e) => Country.fromJson(e)));
    setState(() {
      countryList.addAll(countryDataList);
    });

      selectedCountryCode = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, Country? item, bool? popup) {
    if (item == null || item.name == 'Currency') {
      return _getAnyCountry(AppColors.black, 10.0, 10.0);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        child: Center(
            child: Text(
          item.currency ?? '',
          style:
              TextStyle(fontSize: 12, color: AppColors.black.withOpacity(0.7)),
        )));
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    Country? item,
  ) {
    if (item == null || item.name == 'Currency') {
      return _getAnyCountry(widget.textColor ?? AppColors.white, 10.0, 0.0);
    }
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.currency ?? '',
            style: TextStyle(
                fontSize: 12,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }

  //Custom Drop down button
  Widget _customDropDownButton(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 0, bottom: 10, right: 0),
      child: SizedBox(
        width: 10,
        height: 10,
        child: Icon(
          Iconsax.arrow_down5,
          size: 22,
          color: AppColors.primaryGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primaryGrey,
        ),
        child: DropdownSearch<Country>(
          mode: Mode.MENU,
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
            contentPadding: EdgeInsets.zero,
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
              selectedCountryCode = country.name ?? '';
            });
            widget.onValueChanged(country.currency ?? '');
          },
          showClearButton: false,

          // ignore: unrelated_type_equality_checks
          selectedItem: selectedCountryCode != '' &&
                  countryList.indexWhere((f) => f.name == selectedCountryCode) != -1
              ? countryList[countryList.indexWhere((f) => f.name == selectedCountryCode)]
              : null,
          showSearchBox: false,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),

          dropdownButtonBuilder: _customDropDownButton,
          popupItemBuilder: _customPopupItemBuilder,
          dropdownBuilder: _customDropdownBuilder,
        ),
      ),
    );
  }

  _getAnyCountry(Color textColor, double padding, double margin) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Currency',
              style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
            ),
          ),
        ],
      );
}
