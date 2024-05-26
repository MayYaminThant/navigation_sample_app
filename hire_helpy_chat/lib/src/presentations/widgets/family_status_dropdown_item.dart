part of 'widgets.dart';

class FamilyDropdownItem extends StatefulWidget {
  const FamilyDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  final Color? backgroundColor;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<FamilyStatus> onValueChanged;
  final String title;
  final Color? textColor;

  @override
  State<FamilyDropdownItem> createState() => _FamilyDropdownItemState();
}

class _FamilyDropdownItemState extends State<FamilyDropdownItem> {
  List<FamilyStatus> familyStatusList = [];
  String value = '';

  @override
  void didUpdateWidget(covariant FamilyDropdownItem oldWidget) {
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
      BuildContext context, FamilyStatus? item, bool? popup) {
    if (item == null || item.familyStatus == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        item.familyStatus ?? '',
        style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    FamilyStatus? item,
  ) {
    if (item == null || item.familyStatus == '') {
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
        item.familyStatus ?? '',
        style: TextStyle(
            color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
      ),
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
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primaryGrey,
        ),
        child: DropdownSearch<FamilyStatus>(
          mode: Mode.MENU,
          filterFn: (city, item) => city!
                  .toString()
                  .toLowerCase()
                  .contains(item!.toString().toLowerCase())
              ? true
              : false,
          enabled: true,

          items: familyStatusList,
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
            FamilyStatus familyStatus = object as FamilyStatus;
            setState(() {
              value = familyStatus.familyStatus ?? '';
            });
            widget.onValueChanged(familyStatus);
          },
          showClearButton: false,

          selectedItem: value != '' &&  familyStatusList.indexWhere((f) => f.id.toString() == value) != -1
              ? familyStatusList[
                  familyStatusList.indexWhere((f) => f.id.toString() == value)]
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

  void _getCountryData() async {
    List<FamilyStatus> statusList = List<FamilyStatus>.from(
        (await DBUtils.getEmployerConfigs('family_status_types'))
            .map((e) => FamilyStatusModel.fromJson(e)));
    familyStatusList.addAll(statusList);
  }
}
