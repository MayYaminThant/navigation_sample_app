part of 'widgets.dart';

class MemberTypesDropdownItem extends StatefulWidget {
  const MemberTypesDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.backgroundColor,
      this.iconList,
      this.textColor,
      required this.topCountries,
      this.prefix,
      this.icon})
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
  final IconData? icon;

  @override
  State<MemberTypesDropdownItem> createState() =>
      _MemberTypesDropdownItemState();
}

class _MemberTypesDropdownItemState extends State<MemberTypesDropdownItem> {
  List<String> memberTypesList = [];
  String value = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant MemberTypesDropdownItem oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _getMemberTypesData();
    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, String? item, bool? popup) {
    if (item == null) {
      return Text(widget.title);
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    item,
                    style: TextStyle(
                        fontSize: 14, color: AppColors.black.withOpacity(0.7)),
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.0),
            //   child: Text(
            //     'Default',
            //     style: TextStyle(
            //         fontSize: 12,
            //         color: AppColors.primaryGrey,
            //         fontWeight: FontWeight.w200),
            //   ),
            // )
          ],
        ));
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    String? item,
  ) {
    if (item == null) {
      return Container();
      //return _getAnyMemberTypes(widget.textColor ?? AppColors.white, 10.0, 0.0);
    }
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            item,
            style: TextStyle(
                fontSize: 12,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
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
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.white,
        ),
        child: DropdownSearch<String>(
          key: UniqueKey(),
          mode: Mode.bottomSheet,
          enabled: true,
          filterFn: (item, filter) => item
                  .toString()
                  .toLowerCase()
                  .contains(_controller.text.toLowerCase())
              ? true
              : false,

          items: memberTypesList,
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
          onChanged: (val) {
            setState(() {
              value = "$val";
            });
            widget.onValueChanged(value);
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: value != '' ? value : null,
          showSearchBox: false,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // dropdownButtonBuilder: _customDropDownButton,
          popupItemBuilder: _customPopupItemBuilder,
          dropdownBuilder: _customDropdownBuilder,
          // searchFieldProps: TextFieldProps(
          //   controller: _controller,
          //   decoration: InputDecoration(
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
          //     hintText: 'Search',
          //     labelStyle: const TextStyle(color: Colors.grey),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.grey.shade300,
          //       ),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //   ),
          // ),
          // popupTitle: SizedBox(
          //   height: 50,
          //   child: Center(
          //     child: Text(
          //       widget.title,
          //       style: const TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }

  //MemberTypes Data List with top Countries
  Future<void> _getMemberTypesData() async {
    List<String> dataList = List<String>.from(
        (await DBUtils.getKeyDataList(widget.prefix) as List<dynamic>));

    setState(() {
      memberTypesList.addAll(dataList);
    });
  }
}
