part of 'widgets.dart';

class PhoneNumberDropdownItem extends StatefulWidget {
  const PhoneNumberDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.isCallCode,
      this.backgroundColor,
      this.iconList,
      required this.prefix})
      : super(key: key);

  final Color? backgroundColor;
  final String? iconList;
  final bool isCallCode;
  final String initialValue;
  final ValueChanged<Country> onValueChanged;
  final String title;
  final String prefix;

  @override
  State<PhoneNumberDropdownItem> createState() =>
      _PhoneNumberDropdownItemState();
}

class _PhoneNumberDropdownItemState extends State<PhoneNumberDropdownItem> {
  List<Country> countryList = [];
  String value = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant PhoneNumberDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
      widget.onValueChanged(countryList[countryList.indexWhere((f) =>
          widget.isCallCode
              ? f.dialCode == widget.initialValue
              : f.name == widget.initialValue)]);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _getCountryData();
    super.initState();

    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, Country? item, bool? popup) {
    if (item == null) {
      return const Text('Country');
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
              Expanded(
                child: Text(
                  '(+${item.dialCode ?? ''})',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor.withOpacity(0.7)),
                ),
              ),
            ],
          ));
    }
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    Country? item,
  ) {
    if (item == null) {
      return const Text(
        'Country',
        style: TextStyle(color: AppColors.white),
      );
    }
    return Row(
      children: [
        Row(
          children: [
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                      image: AssetImage(item.flagUri), fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                item.alpha2Code ?? '',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGrey.withOpacity(0.3)),
              ),
            )
          ],
        ),
        Expanded(
          child: Text(
            '+${item.dialCode ?? ''}',
            style: TextStyle(
                fontSize: 12, color: AppColors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }

  //Custom Drop down button
  Widget get _customDropDownButton => const Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10, right: 0),
          child: SizedBox(
            width: 10,
            height: 10,
            child: Icon(
              Iconsax.arrow_down5,
              size: 22,
              color: AppColors.primaryGrey,
            ),
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
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xFFFFB6A0),
              Color(0xFFA5E3FD),
              Color(0xFF778AFF),
              Color(0xFFFFCBF2),
            ]),
            width: 1,
          )),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.white,
        ),
        child: DropdownSearch<Country>(
          key: UniqueKey(),
          mode: Mode.bottomSheet,
          enabled: true,
          filterFn: (item, filter) => item!.name
                  .toString()
                  .toLowerCase()
                  .contains(_controller.text.toLowerCase())
              ? true
              : false,
          items: countryList,
          // ignore: prefer_const_constructors
          dropdownSearchDecoration: InputDecoration(
            // ignore: prefer_const_constructors
            contentPadding: EdgeInsets.all(10.0),
            hintText: widget.title.toString().replaceFirst('Select ', ''),
            hintStyle: const TextStyle(color: AppColors.primaryGrey),
            // ignore: prefer_const_constructors
            labelStyle: TextStyle(color: Colors.grey),

            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onPopupDismissed: () => _controller.clear(),
          onChanged: (Object? object) {
            // String line = object.toString();
            Country country = object as Country;
            setState(() {
              value = country.name ?? '';
            });
            widget.onValueChanged(country);
            _controller.clear();
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: value != '' &&
                  countryList.isNotEmpty &&
                  countryList.indexWhere((f) => widget.isCallCode
                          ? f.dialCode == value
                          : f.name == value) !=
                      -1
              ? countryList[countryList.indexWhere((f) =>
                  widget.isCallCode ? f.dialCode == value : f.name == value)]
              : null,
          showSearchBox: true,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          // dropdownButtonBuilder: _customDropDownButton,
          popupItemBuilder: _customPopupItemBuilder,

          dropdownBuilder: _customDropdownBuilder,

          searchFieldProps: TextFieldProps(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
              hintText: 'Search',
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
          popupTitle: const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Country Calling Code',
                style: TextStyle(
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

  Future<void> _getCountryData() async {
    List<Country> countryDataList = List<Country>.from(
        (await DBUtils.getKeyDataList(widget.prefix))
            .map((e) => Country.fromJson(e)));

    setState(() {
      countryList.addAll(countryDataList);
    });
  }
}
