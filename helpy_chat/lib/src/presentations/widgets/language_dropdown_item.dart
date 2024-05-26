part of 'widgets.dart';

class LanguageDropdownItem extends StatefulWidget {
  const LanguageDropdownItem(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      this.isLeadingIcon,
      this.backgroundColor,
      this.iconList,
      this.textColor,
      this.topCountries = const [],
      this.prefix,
      this.icon,
      this.isBorderGradient})
      : super(key: key);

  final Color? backgroundColor;
  final String? iconList;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;
  final Color? textColor;
  final List<String>? topCountries;
  final String? prefix;
  final IconData? icon;
  final bool? isLeadingIcon;
  final bool? isBorderGradient;

  @override
  State<LanguageDropdownItem> createState() => _LanguageDropdownItemState();
}

class _LanguageDropdownItemState extends State<LanguageDropdownItem> {
  List<ConfigLanguage> languageList = [];
  String value = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant LanguageDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _getLanguageData();
    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, ConfigLanguage? item, bool? popup) {
    if (item == null) {
      return Text(widget.title.tr);
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
                    item.language ?? '',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.black.withOpacity(0.7)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                item.languageName ?? '',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w200),
              ),
            )
          ],
        ));
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    ConfigLanguage? item,
  ) {
    if (item == null) {
      return Container();
      //return _getAnyLanguage(widget.textColor ?? AppColors.white, 10.0, 0.0);
    }
    return Row(
      children: [
        widget.isLeadingIcon != null
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Iconsax.translate,
                  color: AppColors.white,
                ),
              )
            : const SizedBox(
                width: 20,
              ),
        Expanded(
          child: Text(
            item.language ?? '',
            style: TextStyle(
                fontSize: 12,
                color: widget.textColor ?? AppColors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }

  //Custom Drop down button
  Widget? get _customDropDownButton => widget.isLeadingIcon != null
      ? null
      : Padding(
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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: widget.isBorderGradient != null
            ? widget.isBorderGradient == true
                ? const GradientBoxBorder(
                    gradient: LinearGradient(colors: [
                      Color(0xFFFFB6A0),
                      Color(0xFFA5E3FD),
                      Color(0xFF778AFF),
                      Color(0xFFFFCBF2),
                    ]),
                    width: 1,
                  )
                : null
            : null,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.white,
        ),
        child: DropdownSearch<ConfigLanguage>(
          mode: Mode.bottomSheet,
          enabled: true,
          filterFn: (item, filter) => item
                  .toString()
                  .toLowerCase()
                  .contains(_controller.text.toLowerCase())
              ? true
              : false,
          items: languageList,
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
          onPopupDismissed: () => _controller.clear(),
          onChanged: (ConfigLanguage? object) {
            ConfigLanguage language = object as ConfigLanguage;
            setState(() {
              value = language.language ?? '';
            });
            widget.onValueChanged(value);
            _controller.clear();
          },
          showClearButton: false,
          dropdownButtonProps: _customDropDownButton == null
              ? null
              : IconButtonProps(icon: _customDropDownButton!),
          selectedItem: value != '' && languageList.isNotEmpty
              ? languageList[
                  languageList.indexWhere((f) => f.language == value)]
              : null,
          showSearchBox: true,
          popupShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
          popupTitle: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                widget.title.tr,
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

  //Language Data List with top Countries
  Future<void> _getLanguageData() async {
    var data = await DBUtils.getKeyDataList(widget.prefix);
    List<ConfigLanguage> dataList = List<ConfigLanguage>.from(
        (data).map((e) => ConfigLanguageModel.fromJson(e)));
    setState(() {
      languageList.addAll(dataList);
    });
  }
}
