part of 'widgets.dart';

class SavedSearchDropdownItem extends StatefulWidget {
  const SavedSearchDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      required this.iconPadding,
      this.backgroundColor,
      this.textColor,
      required this.datas
      })
      : super(key: key);

  final Color? backgroundColor;
  final double iconPadding;
  final String initialValue;
  final ValueChanged<SavedSearch> onValueChanged;
  final String title;
  final Color? textColor;
  final List<SavedSearch> datas;

  @override
  State<SavedSearchDropdownItem> createState() =>
      _SavedSearchDropdownItemState();
}

class _SavedSearchDropdownItemState extends State<SavedSearchDropdownItem> {
  String value = '';

  @override
  void didUpdateWidget(covariant SavedSearchDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, SavedSearch? item, bool? popup) {
    if (item == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        item.name != '' ? item.name! :  'No Named - ${item.country!}',
        style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    SavedSearch? item,
  ) {
    if (item == null) {
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
        item.name != '' ? item.name! :  'No Named - ${item.country!}',
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
        child: DropdownSearch<SavedSearch>(
          mode: Mode.MENU,
           maxHeight: widget.datas.length * 45,
          filterFn: (city, item) => city!
                  .toString()
                  .toLowerCase()
                  .contains(item!.toString().toLowerCase())
              ? true
              : false,
          enabled: true,

          items: widget.datas,
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
            SavedSearch savedSearch = object as SavedSearch;
            setState(() {
              value = savedSearch.name ?? '';
            });
            widget.onValueChanged(savedSearch);
          },
          showClearButton: false,

          selectedItem: value != '' && widget.datas.isNotEmpty
              ?  widget.datas[
                   widget.datas.indexWhere((f) => f.name == value)]
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

}
