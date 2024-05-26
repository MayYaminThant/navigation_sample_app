part of 'widgets.dart';

class RestDayDropdownItem extends StatefulWidget {
  const RestDayDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.suffixIcon,
      required this.prefix,
      this.backgroundColor,
      this.iconList,
      this.textColor
      })
      : super(key: key);
  final String title;
  final ValueChanged<RestDay> onValueChanged;
  final String initialValue;
  final IconData suffixIcon;
  final Color? backgroundColor;
  final String? iconList;
  final String prefix;
  final Color? textColor;

  @override
  State<RestDayDropdownItem> createState() => _RestDayDropdownItemState();
}

class _RestDayDropdownItemState extends State<RestDayDropdownItem> {
  String value = '';

  List<RestDay> restDayList = [];

  @override
  void didUpdateWidget(covariant RestDayDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _getRestDayData();
    super.initState();
    value = widget.initialValue;
  }

  void _getRestDayData() async {
    List<RestDay> dataList = List<RestDay>.from(
        (await DBUtils.getEmployerConfigs(widget.prefix))
            .map((e) => RestDayModel.fromJson(e)));

    setState(() {
      restDayList.addAll(dataList);
    });
  }

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
        child: DropdownSearch<RestDay>(
          mode: Mode.MENU,
          filterFn: (city, item) => city!
                  .toString()
                  .toLowerCase()
                  .contains(item!.toString().toLowerCase())
              ? true
              : false,
          enabled: true,

          items: restDayList.map((RestDay e) {
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
          onChanged: (Object? object) {
            RestDay restDay = object as RestDay;
            setState(() {
              value = restDay.label ?? '';
            });
            widget.onValueChanged(restDay);
          },
          showClearButton: false,

          selectedItem: value != '' &&
                  restDayList.isNotEmpty &&
                  restDayList.indexWhere((f) => f.value.toString() == value) !=
                      -1
              ? restDayList[
                  restDayList.indexWhere((f) => f.value.toString() == value)]
              : null,
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
  Widget _customDropDownExample(BuildContext context, RestDay? item) {
    if (item == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Text(
          widget.title,
          style: const TextStyle(color: AppColors.primaryGrey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Text(
        item.label ?? '',
        style: TextStyle(color: widget.textColor?? AppColors.primaryGrey),
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
      BuildContext context, RestDay? item, bool? popup) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          item!.label ?? '',
          style:
              TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
        ));
  }
}
