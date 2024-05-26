part of 'widgets.dart';

class ReligionDropdownItem extends StatefulWidget {
  const ReligionDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.backgroundColor,
      this.textColor,
      required this.prefix})
      : super(key: key);

  final Color? backgroundColor;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final String prefix;

  @override
  State<ReligionDropdownItem> createState() => _ReligionDropdownItemState();
}

class _ReligionDropdownItemState extends State<ReligionDropdownItem> {
  List<String> religionList = [];
  String value = '';

  @override
  void didUpdateWidget(covariant ReligionDropdownItem oldWidget) {
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
      BuildContext context, String? item, bool? popup) {
    if (item == null || item == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        item,
        style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    String? item,
  ) {
    if (item == null || item == '') {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          widget.title,
          style: TextStyle(
              color: (widget.textColor ?? AppColors.white).withOpacity(0.7)),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        item,
        style: TextStyle(
            color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
      ),
    );
  }

  //Custom Drop down button
  Widget get _customDropDownButton => const Padding(
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
        child: DropdownSearch<String>(
          key: UniqueKey(),
          mode: Mode.menu,
          filterFn: (city, item) => city
                  .toString()
                  .toLowerCase()
                  .contains(item.toString().toLowerCase())
              ? true
              : false,
          enabled: true,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          items: religionList,
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
            String religion = object as String;
            setState(() {
              value = religion;
            });
            widget.onValueChanged(religion);
          },
          showClearButton: false,

          selectedItem: value != '' && religionList.isNotEmpty ? value : null,
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

  Future<void> _getCountryData() async {
    List<String> dataList = List<String>.from(
        (await DBUtils.getKeyDataList(widget.prefix) as List<dynamic>));

    setState(() {
      religionList.addAll(dataList);
    });
  }
}
