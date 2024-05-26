part of '../../views.dart';

class ChatListSection extends StatefulWidget {
  const ChatListSection({super.key});

  @override
  State<ChatListSection> createState() => _ChatListSectionState();
}

class _ChatListSectionState extends State<ChatListSection> {
  Map? candidateData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ConnectionData> connectionDataList = [];
  String basePhotoUrl = '';
  ZIMKitConversation? deletedConversation;

  @override
  void initState() {
    _getPhotoUrl();
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
    });
    _requestConnectionsList();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: BackgroundScaffold(
            onWillPop: () => Get.offAllNamed(rootRoute),
            scaffold: _getChatListScaffold));
  }

  Scaffold get _getChatListScaffold {
    return Scaffold(
        appBar: _getAppBar,
        key: _scaffoldKey,
        drawer: const SideMenu(
          menuName: StringConst.chatTitle,
        ),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: candidateData != null &&
                candidateData![DBUtils.employerTableName] != null
            ? _getChatListDetailContainer
            : const Center(child: EmptyProfileContainer()));
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: InkWell(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Image.asset("assets/icons/menu.png")),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.chatTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getChatListDetailContainer => BlocConsumer<
          kConnectionBloc.ConnectionBloc,
          kConnectionBloc.ConnectionState>(builder: (_, state) {
        return connectionDataList.isNotEmpty ? _getChatList : _getEmptyMessage;
      }, listener: (_, state) {
        if (state is kConnectionBloc.ConnectionListRequestSuccess) {
          Loading.cancelLoading();
          if (state.connectionData.data != null) {
            List<ConnectionData> data = List<ConnectionData>.from(
                (state.connectionData.data!['data'] as List<dynamic>).map((e) =>
                    ConnectionDataModel.fromJson(e as Map<String, dynamic>)));
            setState(() {
              connectionDataList = data;
            });
          }
        }

        if (state is kConnectionBloc.ConnectionListRequestFail) {
          Loading.cancelLoading();
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }

        if (state is kConnectionBloc.ConnectionListRequestLoading) {
          Loading.showLoading(message: StringConst.loadingText);
        }

        if (state is kConnectionBloc.ConnectionUnlinkRequestSuccess) {
          if (state.connectionData.data != null) {
            showSuccessSnackBar(state.connectionData.data!['message']);
            ZIMKit().deleteConversation(
                deletedConversation!.id, ZIMConversationType.peer,
                isAlsoDeleteMessages: true);
            _requestConnectionsList();
          }
        }

        if (state is kConnectionBloc.ConnectionUnlinkRequestFail) {
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      });

  Widget get _getChatList => FutureBuilder(
        future: ZIMKit().getConversationListNotifier(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ValueListenableBuilder(
              valueListenable: snapshot.data!,
              builder: (BuildContext context,
                  List<ZIMKitConversationNotifier> conversationList,
                  Widget? child) {
                if (conversationList.isEmpty) {
                  return _getEmptyMessage;
                }

                return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return ListView.builder(
                      cacheExtent: constraints.maxHeight * 3,
                      itemCount: conversationList.length,
                      itemBuilder: (context, index) {
                        final conversationData = conversationList[index];

                        return ValueListenableBuilder(
                          valueListenable: conversationData,
                          builder: (BuildContext context,
                              ZIMKitConversation conversation, Widget? child) {
                            for (int i = 0;
                                i < connectionDataList.length;
                                i++) {
                              if (connectionDataList[i]
                                      .candidateUserId
                                      .toString() ==
                                  conversation.id) {
                                conversation.name = StringUtils.getFullName(
                                    connectionDataList[i]
                                            .candidate!
                                            .user!
                                            .firstName ??
                                        '',
                                    connectionDataList[i]
                                            .candidate!
                                            .user!
                                            .lastName ??
                                        '');
                                conversation.avatarUrl =
                                    '$basePhotoUrl/${connectionDataList[i].candidate!.user!.avatar}';
                                conversation.connectedTime =
                                    connectionDataList[i].createdTime ?? '';
                                conversation.connectionId =
                                    connectionDataList[i].connectionID;
                                conversation.isDelete = false;
                                connectionDataList.removeAt(i);
                              }
                            }

                            if (index == conversationList.length - 1) {
                              for (int i = 0;
                                  i < connectionDataList.length;
                                  i++) {
                                if (connectionDataList[i].candidate != null) {
                                  conversationList.add(
                                      ZIMKitConversationNotifier(
                                          ZIMKitConversation()
                                            ..id = connectionDataList[i]
                                                .candidateUserId
                                                .toString()
                                            ..name = StringUtils.getFullName(
                                                connectionDataList[i]
                                                            .candidate ==
                                                        null
                                                    ? ""
                                                    : connectionDataList[i]
                                                            .candidate!
                                                            .user!
                                                            .firstName ??
                                                        '',
                                                connectionDataList[i]
                                                            .candidate ==
                                                        null
                                                    ? ""
                                                    : connectionDataList[i]
                                                            .candidate!
                                                            .user!
                                                            .lastName ??
                                                        '')
                                            ..avatarUrl =
                                                '$basePhotoUrl/${connectionDataList[i].candidate!.user!.avatar}'
                                            ..connectedTime =
                                                connectionDataList[i]
                                                        .createdTime ??
                                                    ''
                                            ..connectionId =
                                                connectionDataList[i]
                                                    .connectionID));
                                }
                              }
                            }

                            return conversation.isDelete
                                ? const SizedBox.shrink()
                                : ChatItem(
                                    conversation: conversation,
                                    token: candidateData!['token'],
                                    onValueChanged: (ZIMKitConversation data) {
                                      checkUnlinkValidation(data);
                                    });
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            // defaultWidget
            final Widget defaultWidget = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {}),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                  const Text('Load failed, please click to retry'),
                ],
              ),
            );

            return defaultWidget;
          } else {
            // defaultWidget
            const Widget defaultWidget =
                Center(child: CircularProgressIndicator());

            // customWidget
            return defaultWidget;
          }
        },
      );

  void _requestConnectionsList() {
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionListRequestParams params = ConnectionListRequestParams(
      token: candidateData!['token'],
    );
    connectionBloc.add(kConnectionBloc.ConnectionListRequested(params: params));
  }

  checkUnlinkValidation(ZIMKitConversation conversation) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return SizedBox(
                    width: 300,
                    child: UnLinkValidationModal(
                      onPressed: () => _createUnlink(conversation),
                    ),
                  );
                },
              ),
            ));
  }

  //Connection Unlink
  _createUnlink(ZIMKitConversation conversation) {
    Navigator.pop(context);
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionUnlinkRequestParams params = ConnectionUnlinkRequestParams(
      token: candidateData!['token'],
      connectId: conversation.connectionId,
    );
    connectionBloc
        .add(kConnectionBloc.ConnectionUnlinkRequested(params: params));
    deletedConversation = conversation;
  }

  get _getEmptyMessage => const EmptyChatRequestItem(
        title: 'No Messages',
        desc: StringConst.noIncomingChatDesc,
      );
}
