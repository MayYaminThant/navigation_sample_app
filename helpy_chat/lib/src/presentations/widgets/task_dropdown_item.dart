part of 'widgets.dart';

class TaskDropdownItem extends StatefulWidget {
  const TaskDropdownItem(
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
  final ValueChanged<Tasks> onValueChanged;
  final String title;
  final Color? textColor;

  @override
  State<TaskDropdownItem> createState() => _TaskDropdownItemState();
}

class _TaskDropdownItemState extends State<TaskDropdownItem> {
  List<Tasks> tasksList = [];
  String value = '';

  @override
  void didUpdateWidget(covariant TaskDropdownItem oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _getTaslsData();

    value = widget.initialValue;
  }

  //Custom Dropdown
  Widget _customPopupItemBuilder(
      BuildContext context, Tasks? item, bool? popup) {
    if (item == null || item.taskDesc == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        item.taskDesc ?? '',
        style: TextStyle(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    Tasks? item,
  ) {
    if (item == null || item.taskDesc == '') {
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
        item.taskDesc ?? '',
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
        child: DropdownSearch<Tasks>(
          key: UniqueKey(),
          mode: Mode.menu,
          filterFn: (city, item) => city
                  .toString()
                  .toLowerCase()
                  .contains(item.toString().toLowerCase())
              ? true
              : false,
          enabled: true,

          items: tasksList,
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
            Tasks task = object as Tasks;
            setState(() {
              value = task.taskDesc ?? '';
            });
            widget.onValueChanged(task);
          },
          showClearButton: false,
          dropdownButtonProps: IconButtonProps(icon: _customDropDownButton),
          selectedItem: value != '' && tasksList.isNotEmpty
              ? tasksList[tasksList.indexWhere((f) => f.taskDesc == value)]
              : null,
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

  Future<void> _getTaslsData() async {
    List<Tasks> dataList = List<Tasks>.from(
        (await DBUtils.getCandidateConfigs('tasks_type'))
            .map((e) => TasksModel.fromJson(e)));

    tasksList.addAll(dataList);
  }
}
