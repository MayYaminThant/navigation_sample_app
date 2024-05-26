part of 'widgets.dart';

class DropdownItem extends StatefulWidget {
  const DropdownItem(
      {Key? key,
      required this.datas,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.suffixIcon,
      this.backgroundColor,
      this.iconList,
      this.prefix,
      this.isShowCheckbox,
      this.isRequired})
      : super(key: key);
  final String title;
  final List<String> datas;
  final ValueChanged<String> onValueChanged;
  final String initialValue;
  final IconData suffixIcon;
  final Color? backgroundColor;
  final String? iconList;
  final String? prefix;
  final bool? isShowCheckbox;
  final bool? isRequired;

  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  String value = '';
  List<String> data = [];
  bool required = true;

  @override
  void didUpdateWidget(covariant DropdownItem oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    } else if (oldWidget.isRequired != widget.isRequired) {
     setState(() {
        required = widget.isRequired ?? true;
     });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    required = widget.isRequired ?? true;
    if (widget.prefix != null) {
      _getGenderTypesData();
    } else {
      data = widget.datas;
      value = widget.initialValue.toString() != '-1' &&
              widget.initialValue.toString() != 'Select Month' &&
              widget.initialValue.toString() != 'Select Your Problem' &&
              widget.initialValue.toString() != ''
          ? data[data.indexWhere((f) => f.contains(widget.initialValue))]
          : widget.initialValue.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
        //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: value == '' && required ? Border.all(color: AppColors.red) : null,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.white,
        ),
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          maxHeight: data.length * 46,
          enabled: true,

          items: data.map((String e) {
            return e;
          }).toList(),
          // ignore: prefer_const_constructors
          dropdownSearchDecoration: InputDecoration(
            // ignore: prefer_const_constructors
            contentPadding: EdgeInsets.only(left: 10.0),
            hintText: widget.title.toString().replaceFirst('Select ', ''),
            hintStyle: const TextStyle(color: AppColors.black),
            // ignore: prefer_const_constructors
            labelStyle: TextStyle(color: Colors.grey),

            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (object) {
            String line = "$object";
            setState(() {
              value = line;
            });

            widget.onValueChanged(value);
          },
          showClearButton: false,

          selectedItem: value != '' ? value : null,
          showSearchBox: false,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          dropdownButtonBuilder: _customDropDownButton,
          dropdownBuilder: _customDropDownExample,
          popupItemBuilder: _customPopupItemBuilder,
        ),
      ),
    );
  }

  //Custom Dropdown
  Widget _customDropDownExample(BuildContext context, String? item) {
    if (item == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Text(
          widget.title.tr,
          style: const TextStyle(color: AppColors.primaryGrey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Text(
        item.tr,
        style: const TextStyle(color: AppColors.primaryGrey),
      ),
    );
  }

  //Custom Drop down button
  Widget _customDropDownButton(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: SizedBox(
          width: 10,
          height: 10,
          child: Icon(
            widget.suffixIcon,
            size: 22,
            color: AppColors.primaryGrey,
          ),
        ),
      ),
    );
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, String? item, bool popup) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: widget.isShowCheckbox != null && widget.isShowCheckbox!
          ? CustomCheckBox(
              initialValue: value == item,
              leading: getItemText(item: item),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              onValueChanged: (value) {})
          : getItemText(item: item),
    );
  }

  //Gender Type
  void _getGenderTypesData() async {
    List<String> dataList = List<String>.from(
        (await DBUtils.getKeyDataList(widget.prefix) as List<dynamic>));

    setState(() {
      data.addAll(dataList);
    });
  }

  getItemText({String? item}) {
    return Text(
      item != null ? item.tr : '',
      style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
    );
  }
}
