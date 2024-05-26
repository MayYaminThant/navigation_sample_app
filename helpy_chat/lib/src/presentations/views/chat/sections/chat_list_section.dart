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
  List<String>? _complainedIds;
  String basePhotoUrl = '';
  ZIMKitConversation? deletedConversation;
  bool isLoading = true;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getCandidateData();
  }

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    _requestConnectionsList();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, child: BackgroundScaffold(scaffold: _getChatListScaffold));
  }

  Scaffold get _getChatListScaffold {
    return Scaffold(
      appBar: _getAppBar,
      key: _scaffoldKey,
      drawer: SideMenu(
        menuName: StringConst.chatTitle.tr,
      ),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: candidateData != null &&
              candidateData![DBUtils.candidateTableName] != null
          ? _getChatListDetailContainer
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: EmptyProfileContainer())),
    );
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
          k_connection_bloc.ConnectionBloc,
          k_connection_bloc.ConnectionState>(builder: (_, state) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : connectionDataList.isNotEmpty
                ? _getChatList
                : _getEmptyMessage;
      }, listener: (_, state) {
        if (state is k_connection_bloc.ConnectionListRequestSuccess) {
          changeLoading(false);
          if (state.connectionData.data != null) {
            Iterable iterable = state.connectionData.data!['data'];
            for (var element in iterable) {
              connectionDataList.add(ConnectionDataModel.fromJson(element));
            }
          }
        }

        if (state is k_connection_bloc.ConnectionListRequestFail) {
          changeLoading(false);
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }

        if (state is k_connection_bloc.ConnectionListRequestLoading) {
          changeLoading(true);
        }

        if (state is k_connection_bloc.ConnectionUnlinkRequestSuccess) {
          changeLoading(false);
          if (state.connectionData.data != null) {
            showSuccessSnackBar(state.connectionData.data!['message']);
            ZIMKit().deleteConversation(
                deletedConversation!.id, ZIMConversationType.peer,
                isAlsoDeleteMessages: true);
            _requestConnectionsList();
          }
        }

        if (state is k_connection_bloc.ConnectionUnlinkRequestFail) {
          changeLoading(false);
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      });

  Future<ListNotifier<ValueNotifier<ZIMKitConversation>>>
      _loadChatData() async {
    if (_complainedIds == null) {
      Box box = await Hive.openBox(DBUtils.dbName);
      List<String> complainedIds = box.get('chat_complaints') ?? [];
      setState(() {
        _complainedIds = complainedIds;
      });
    }
    return ZIMKit().getConversationListNotifier();
  }

  Widget get _getChatList => FutureBuilder(
        future: _loadChatData(),
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
                                      .employerUserId
                                      .toString() ==
                                  conversation.id) {
                                conversation.name = StringUtils.getFullName(
                                    connectionDataList[i]
                                            .employer!
                                            .user!
                                            .firstName ??
                                        '',
                                    connectionDataList[i]
                                            .employer!
                                            .user!
                                            .lastName ??
                                        '');
                                conversation.avatarUrl =
                                    '$basePhotoUrl/${connectionDataList[i].employer!.user!.avatar}';
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
                                conversationList.add(ZIMKitConversationNotifier(
                                    ZIMKitConversation()
                                      ..id = connectionDataList[i]
                                          .candidateUserId
                                          .toString()
                                      ..name = StringUtils.getFullName(
                                          connectionDataList[i]
                                                  .employer!
                                                  .user!
                                                  .firstName ??
                                              '',
                                          connectionDataList[i]
                                                  .employer!
                                                  .user!
                                                  .lastName ??
                                              '')
                                      ..avatarUrl =
                                          '$basePhotoUrl/${connectionDataList[i].employer!.user!.avatar}'
                                      ..connectedTime =
                                          connectionDataList[i].createdTime ??
                                              ''
                                      ..connectionId =
                                          connectionDataList[i].connectionID));
                              }
                            }

                            return conversation.isDelete ||
                                    (_complainedIds != null && _complainedIds!.contains(conversation.id))
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
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionListRequestParams params = ConnectionListRequestParams(
      token: candidateData!['token'],
    );
    connectionBloc
        .add(k_connection_bloc.ConnectionListRequested(params: params));
  }

  void checkUnlinkValidation(ZIMKitConversation conversation) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: SizedBox(
                width: 300,
                child: UnLinkValidationModal(
                  onPressed: () => _createUnlink(conversation),
                ),
              ),
            ));
  }

  //Connection Unlink
  void _createUnlink(ZIMKitConversation conversation) {
    Navigator.pop(context);
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionUnlinkRequestParams params = ConnectionUnlinkRequestParams(
      token: candidateData!['token'],
      connectId: conversation.connectionId,
    );
    connectionBloc
        .add(k_connection_bloc.ConnectionUnlinkRequested(params: params));
    deletedConversation = conversation;
  }

  EmptyChatRequestItem get _getEmptyMessage => const EmptyChatRequestItem(
        title: 'No Messages',
        desc: StringConst.noIncomingChatDesc,
      );
}
