part of 'widgets.dart';

class AvailabilityStatusDropdown extends StatefulWidget {
  const AvailabilityStatusDropdown({
    Key? key,
    required this.title,
    required this.onValueChanged,
    required this.initialValue,
    this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final String title;

  @override
  State<AvailabilityStatusDropdown> createState() =>
      _AvailabilityStatusDropdownState();
}

class _AvailabilityStatusDropdownState
    extends State<AvailabilityStatusDropdown> {
  List<AvailabilityStatus> availabilityStatusList = [];
  List<Color> defaultColorList = [AppColors.green, AppColors.yellow, AppColors.red];
  late AvailabilityStatus value;
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    _getAvailabilityStatusData();
  }

  Future<void> _getAvailabilityStatusData() async {
    List<AvailabilityStatus> statusList = List<AvailabilityStatus>.from(
        (await DBUtils.getCandidateConfigs(
                ConfigsKeyHelper.availabilityStatusKey))
            .map((e) => AvailabilityStatusModel.fromJson(e)));
    availabilityStatusList.addAll(statusList);

    try {
      if (candidateData![DBUtils.candidateTableName] != null &&
          candidateData![DBUtils.candidateTableName]['availability_status'] !=
              null &&
          candidateData![DBUtils.candidateTableName]['availability_status'] !=
              '') {
        value =
        availabilityStatusList[availabilityStatusList.indexWhere((item) =>
        item.availabilityStatusType ==
            candidateData![DBUtils.candidateTableName]['availability_status'])];
      } else if (widget.initialValue != '') {
        value = availabilityStatusList[availabilityStatusList.indexWhere(
                (item) => item.availabilityStatusType == widget.initialValue)];
      } else {
        value = availabilityStatusList[availabilityStatusList.length - 1];
      }
    } catch (e){
      value = availabilityStatusList.last;
    }
  }

  @override
  void didUpdateWidget(covariant AvailabilityStatusDropdown oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = availabilityStatusList[availabilityStatusList.indexWhere(
          (item) => item.availabilityStatusType == widget.initialValue)];
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return availabilityStatusList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PopupMenuButton<AvailabilityStatus>(
              onSelected: _handleClick,
              constraints: const BoxConstraints.tightFor(width: 180),
              offset: const Offset(0, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return availabilityStatusList.map((AvailabilityStatus choice) {
                  return PopupMenuItem<AvailabilityStatus>(
                      value: choice,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  choice.availabilityStatusType ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 7.0,
                                height: 7.0,
                                decoration: BoxDecoration(
                                    color: getColor(choice),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(3.5))),
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      ));
                }).toList();
              },
              child: _getActionBarItem,
            ),
          )
        : Container();
  }

  Widget get _getActionBarItem {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
                color: AppColors.fromHex(value.colorCode ?? '').withAlpha(200),
                borderRadius: const BorderRadius.all(Radius.circular(3.5))),
          ),
          Text(
            value.availabilityStatusType ?? '',
            style: const TextStyle(color: AppColors.white, fontSize: 10),
            maxLines: 2,
          ),
        ]);
  }

  getColor(AvailabilityStatus data) {
    try {
      if (data.colorCode != null) {
        return AppColors.fromHex(data.colorCode!).withAlpha(250);
      }
    } finally {}
    int index = availabilityStatusList.indexWhere((item) => item == data);
    return defaultColorList[index];
  }

  void _handleClick(AvailabilityStatus data) => setState(() {
        widget.onValueChanged(data.availabilityStatusType ?? '');
      });
}
