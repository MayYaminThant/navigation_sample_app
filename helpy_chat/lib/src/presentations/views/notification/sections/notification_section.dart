part of '../../views.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  List<noti.Notification> notificationList = [];
  Map? candidateData;
  int count = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCandidateData();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
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
      return BackgroundScaffold(
          availableBack: true,
          scaffold: isLoading
              ? LoadingScaffold.getLoading()
              : _getNotificationScaffold);
    }, listener: (_, state) {
      if (state is NotificationLoading) {
        if (notificationList.isEmpty) _setLoading(true);
      }

      if (state is NotificationSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          List<noti.Notification> data = List<noti.Notification>.from((state
                  .data.data!['data']['notifications']['data'] as List<dynamic>)
              .map((e) =>
                  NotificationModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            notificationList = data;
            count = state.data.data!['data']['unread_count'];
          });
        }
      }
      if (state is NotificationFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is NotificationReadSuccess) {
        _requestNotificationList();
      }

      if (state is NotificationUnReadSuccess) {
        _requestNotificationList();
      }

      if (state is NotificationDeleteSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
        }
      }

      if (state is NotificationDeleteFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is NotificationAllDeleteSuccess) {
        if (state.data.data != null) {
          setState(() {
            notificationList = [];
          });
          showSuccessSnackBar(state.data.data!['message']);
        }
      }

      if (state is NotificationAllDeleteFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getNotificationScaffold => Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getNotificationListView);

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Get.offNamed(rootRoute),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: const Text(
        StringConst.notificationTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [_getDeleteAllNotification],
    );
  }

  Widget get _getNotificationListView {
    return notificationList.isEmpty
        ? _getEmptyNotification
        : ListView.builder(
            shrinkWrap: true,
            itemCount: notificationList.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    if (notificationList[index].notificationReadDatetime ==
                        null) {
                      _requestNotificationRead(notificationList[index].id);
                    }

                    Future(() => StringUtils.notificationScreenRoute(
                        notificationList[index].notificationData!.screenName ??
                            '',
                        context,
                        id: notificationList[index].notificationData!.id ?? 0,
                        expiry: notificationList[index].notificationData!.expiry ??
                            '',
                        currency:
                            notificationList[index].notificationData!.currency ??
                                '',
                        salary:
                            notificationList[index].notificationData!.salary ??
                                '',
                        employerId: notificationList[index]
                                    .notificationData!
                                    .employerId !=
                                null
                            ? int.parse(
                                notificationList[index].notificationData!.employerId!)
                            : null,
                        notificationId: notificationList[index].id,
                        action: notificationList[index].notificationData!.action));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                Get.back();
                                notificationList[index]
                                            .notificationReadDatetime !=
                                        null
                                    ? _requestNotificationUnRead(
                                        notificationList[index].id)
                                    : _requestNotificationRead(
                                        notificationList[index].id);
                              },
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.white,
                              label: notificationList[index]
                                          .notificationReadDatetime !=
                                      null
                                  ? 'Unread'
                                  : 'Read',
                              flex: 5,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                _deleteNotification(
                                    notificationList[index].id ?? 0);
                                notificationList
                                    .remove(notificationList[index]);
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
                        child: SizedBox(
                          height: notificationList[index].type ==
                                  "App\\Notifications\\HiringPorcessNotification"
                              ? 60
                              : 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        notificationList[index]
                                                .notificationData!
                                                .title ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notificationList[index]
                                                        .notificationReadDatetime !=
                                                    null
                                                ? AppColors.primaryGrey
                                                : AppColors.secondaryColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 10),
                                    child: Container(
                                      width: 7.0,
                                      height: 7.0,
                                      decoration: BoxDecoration(
                                          color: notificationList[index]
                                                      .notificationReadDatetime !=
                                                  null
                                              ? AppColors.primaryGrey
                                              : AppColors.brandBlue,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3.5))),
                                    ),
                                  ),
                                ],
                              ),
                              if (notificationList[index].type ==
                                  "App\\Notifications\\HiringPorcessNotification")
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      'Click this message to accept or reject it.'
                                          .tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryGrey)),
                                )
                            ],
                          ),
                        ),
                      ),
                      index != notificationList.length - 1
                          ? const Divider()
                          : Container(),
                    ],
                  ),
                ));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Widget get _getEmptyNotification => const EmptyMessage(
        title: StringConst.noNotificationText,
        image: 'assets/images/bell.png',
        description: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text:
                      'Ready to dive into our  Phluid Community? Connect with fellow users by ',
                  style: TextStyle(
                      fontSize: 14, color: AppColors.primaryGrey, height: 2)),
              TextSpan(
                text: 'Creating',
                style: TextStyle(
                    fontSize: 14,
                    height: 2,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              TextSpan(
                  text:
                      ' articles, leaving thoughtful comments, and sending friendly ',
                  style: TextStyle(
                      fontSize: 14, color: AppColors.primaryGrey, height: 2)),
              TextSpan(
                  text: 'Chat requests',
                  style: TextStyle(
                      fontSize: 14,
                      height: 2,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700)),
              TextSpan(
                  text:
                      ". Our warm and welcoming community can't wait to embrace you with open arms! ",
                  style: TextStyle(
                      fontSize: 14, height: 2, color: AppColors.primaryGrey)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );

  //Delete Notification
  _deleteNotification(int id) {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationReadRequestParams params = NotificationReadRequestParams(
        token: candidateData!['token'], notificationId: id);
    notificationBloc.add(NotificationDeleteRequested(params: params));
  }

  get _getDeleteAllNotification {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      offset: const Offset(20, 35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      elevation: 0,
      itemBuilder: (BuildContext context) {
        return [
          if (notificationList.isNotEmpty)
            PopupMenuItem<String>(
                value: 'delete',
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.rednotification),
                    child: const Text(
                      'Clear All Notifications',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ])),
          if (notificationList.isEmpty)
            PopupMenuItem<String>(
                value: 'No Notifications',
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor),
                    child: const Text(
                      'No Notifications yet',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ])),
        ];
      },
      onSelected: (String value) {
        switch (value) {
          case 'delete':
            showDialog(
                context: context,
                builder: (context) => ErrorPopUp(
                      title: StringConst.deleteAllNotificationTitle,
                      onAgreePressed: () => _deleteAllNotification(),
                    ));
            break;
          case 'No Notification':
            showDialog(
                context: context,
                builder: (context) {
                  void closeDialog() {
                    Navigator.of(context).pop();
                  }

                  Timer(const Duration(seconds: 2), closeDialog);
                  return const ErrorPopUpNotification(
                    title: 'There is no Notification...yet!',
                    subTitle: 'Empty Notification.....',
                  );
                });
            break;
          default:
            break;
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(Icons.more_vert, color: Colors.white),
      ),
    );
  }

  //Delete All Notification
  _deleteAllNotification() {
    Navigator.pop(context);
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    NotificationAllDeleteRequestParams params =
        NotificationAllDeleteRequestParams(token: candidateData!['token']);
    notificationBloc.add(NotificationAllDeleteRequested(params: params));
  }
}
