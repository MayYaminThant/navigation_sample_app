part of 'widgets.dart';

class NotificationDropdown extends StatefulWidget {
  const NotificationDropdown({
    Key? key,
    required this.title,
    required this.onValueChanged,
    this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final ValueChanged<String> onValueChanged;
  final String title;

  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  List<noti.Notification> notificationList = [];
  Map? candidateData;
  int count = 0;
  bool isClick = false;

  @override
  void initState() {
    super.initState();
    _getCandidateData();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
    });
    _requestNotificationList();
  }

  _requestNotificationList() {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationListRequestParams params = NotificationListRequestParams(
      token: candidateData!['token'],
      perPage: '1',
    );
    notificationBloc.add(NotificationsRequested(params: params));
  }

  _requestNotificationRead(int? notificationId) {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationReadRequestParams params = NotificationReadRequestParams(
      token: candidateData!['token'],
      notificationId: notificationId,
    );
    notificationBloc.add(NotificationReadRequested(params: params));
  }

  _requestNotificationUnRead(int? notificationId) {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationReadRequestParams params = NotificationReadRequestParams(
      token: candidateData!['token'],
      notificationId: notificationId,
    );
    notificationBloc.add(NotificationUnReadRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
        builder: (_, state) {
      if (state is NotificationSuccess) {
        if (state.data.data != null) {
          List<noti.Notification> data = List<noti.Notification>.from((state
                  .data.data!['data']['notifications']['data'] as List<dynamic>)
              .map((e) =>
                  NotificationModel.fromJson(e as Map<String, dynamic>)));
          notificationList = data;
          count = state.data.data!['data']['unread_count'];
        }
        return _dropDownNotification;
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getActionBarItem,
      );
    }, listener: (_, state) {
      if (state is NotificationReadSuccess) {
        _requestNotificationList();
        if (!isClick) Navigator.pop(context);
      }

      if (state is NotificationDeleteSuccess) {
        _requestNotificationList();
        Navigator.pop(context);
      }

      if (state is NotificationUnReadSuccess) {
        _requestNotificationList();
        Navigator.pop(context);
      }
    });
  }

  Widget get _dropDownNotification {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<String>(
        onSelected: _handleClick,
        color: AppColors.backgroundGrey,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
            minWidth: MediaQuery.of(context).size.width - 40,
            maxHeight: MediaQuery.of(context).size.height - 100),
        offset: const Offset(-13, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        itemBuilder: (BuildContext context) {
          if (notificationList.isEmpty) {
            return [
              const PopupMenuItem<String>(
                value: '',
                child: SizedBox(height: 10),
              ),
              const PopupMenuItem<String>(
                value: '',
                child: Center(child: Text("No Notifications Yet.")),
              ),
              const PopupMenuItem<String>(
                  value: '', child: SizedBox(height: 10)),
            ];
          } else {
            const int numOfNotiToShow = 7;
            final hasMoreNotifications =
                notificationList.length > numOfNotiToShow;
            final notificationSublist = hasMoreNotifications
                ? notificationList.sublist(0, numOfNotiToShow)
                : notificationList;
            return notificationSublist.map((noti.Notification choice) {
              return PopupMenuItem<String>(
                  onTap: () {
                    setState(() {
                      isClick = true;
                    });
                    _requestNotificationRead(choice.id);
                    Future(() => StringUtils.notificationScreenRoute(
                        choice.notificationData!.screenName ?? '', context,
                        id: choice.notificationData!.id ?? 0));
                  },
                  value: choice.notificationData!.title ?? '',
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 2,
                  ),
                  child: ClipRect(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Slidable(
                        // The end action pane is the one at the right or the bottom side.

                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                choice.notificationReadDatetime != null
                                    ? _requestNotificationUnRead(choice.id)
                                    : _requestNotificationRead(choice.id);
                              },
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.white,
                              label: choice.notificationReadDatetime != null
                                  ? 'Unread'
                                  : 'Read',
                              flex: 5,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                _deleteNotification(choice.id ?? 0);
                              },
                              backgroundColor:
                                  AppColors.primaryGrey.withOpacity(0.3),
                              foregroundColor: AppColors.red,
                              label: 'Delete',
                              flex: 5,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0)),
                            ),
                          ],
                        ),
                        closeOnScroll: true,

                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 32),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      choice.notificationData!.title ?? '',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              choice.notificationReadDatetime !=
                                                      null
                                                  ? AppColors.primaryGrey
                                                  : AppColors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    width: 7.0,
                                    height: 7.0,
                                    decoration: BoxDecoration(
                                        color:
                                            choice.notificationReadDatetime !=
                                                    null
                                                ? AppColors.primaryGrey
                                                : AppColors.brandBlue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3.5))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      notificationSublist
                                  .indexWhere((item) => item == choice) ==
                              notificationSublist.length - 1
                          ? _getClearReadMessagesButton
                          : const Divider(),
                    ],
                  )));
            }).toList();
          }
        },
        child: Container(
          child: _getActionBarItem,
        ),
        onOpened: () => _requestNotificationList(),
      ),
    );
  }

  Widget get _getActionBarItem {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(children: [
          SizedBox(
            width: 32.0,
            height: 32.0,
            child: Image.asset('assets/icons/noti.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          if (count != 0)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 10),
                    ),
                  ),
                ))
        ]),
      ),
    );
  }

  void _handleClick(String data) => setState(() {});

  Widget get _getClearReadMessagesButton => GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Get.offAllNamed(notificationPageRoute);
        },
        child: Container(
          width: 160,
          height: 35,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.0)),
          child: const Center(
            child: Text(
              StringConst.showAllText,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );

  _deleteNotification(int id) {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationReadRequestParams params = NotificationReadRequestParams(
        token: candidateData!['token'], notificationId: id);
    notificationBloc.add(NotificationDeleteRequested(params: params));
  }
}
