part of '../../views.dart';

class ChatDetailsSection extends StatefulWidget {
  const ChatDetailsSection(
      {super.key, required this.conversation, required this.isFromChat});

  final ZIMKitConversation conversation;
  final bool isFromChat;

  @override
  State<ChatDetailsSection> createState() => _ChatDetailsSectionState();
}

class _ChatDetailsSectionState extends State<ChatDetailsSection> {
  Map? candidateData;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  final BoxDecoration boxDecoration = BoxDecoration(
      border: const GradientBoxBorder(
        gradient: LinearGradient(colors: [
          Color(0xFFFFB6A0),
          Color(0xFFA5E3FD),
          Color(0xFF778AFF),
          Color(0xFFFFCBF2),
        ]),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20));

  final InputDecoration inputDecoration = const InputDecoration(
    focusedBorder: Borders.noBorder,
    disabledBorder: Borders.noBorder,
    enabledBorder: Borders.noBorder,
    labelStyle: TextStyle(
      color: AppColors.primaryGrey,
      fontSize: Sizes.textSize12,
    ),
    hintText: StringConst.messageText,
    hintStyle: TextStyle(
      color: AppColors.primaryGrey,
      fontSize: Sizes.textSize12,
    ),
  );
  bool isEmpty = true;

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
  }

  void _requestConnectionsList() {
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionListRequestParams params = ConnectionListRequestParams(
      token: candidateData!['token'],
    );
    connectionBloc
        .add(k_connection_bloc.ConnectionListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return _getChatDetailsScaffold;
  }

  static Future<File?> openMediaPreview(
      {required BuildContext context,
      required File file,
      required bool isPreview,
      required bool isVideo}) async {
    return showDialog<File?>(
      context: context,
      builder: (BuildContext context) {
        return UploadPreview(
          originalFile: file,
          preview: isPreview,
          isVideo: isVideo,
        );
      },
    );
  }

  Widget get _getChatDetailsScaffold {
    return WillPopScope(
      onWillPop: () async {
        _requestConnectionsList();
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus == null
              ? null
              : FocusManager.instance.primaryFocus!.unfocus(),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ZIMKitMessageListPage(
                appBarBuilder: (context, defaultAppBar) => _getAppBar,
                conversationID: widget.conversation.id,
                conversationType: widget.conversation.type,
                showPickFileButton: false,
                messageListScrollController: _scrollController,
                sendButtonWidget: const Icon(
                  Iconsax.send_24,
                  color: AppColors.primaryColor,
                ),
                onMessageItemPressd:
                    (context, ZIMKitMessage message, onMessagePassed) {
                  if (message.type == ZIMMessageType.image) {
                    openMediaPreview(
                        context: context,
                        file: File(message.imageContent!.fileDownloadUrl),
                        isPreview: true,
                        isVideo: false);
                  } else {
                    if (message.type == ZIMMessageType.video) {
                      openMediaPreview(
                          context: context,
                          file: File(message.imageContent!.fileDownloadUrl),
                          isPreview: true,
                          isVideo: true);
                    }
                  }
                },
                pickMediaButtonWidget: const Icon(
                  Iconsax.camera,
                  color: AppColors.secondaryColor,
                ),
                inputBackgroundDecoration: boxDecoration,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.black.withOpacity(0.1),
                  primaryColor: AppColors.primaryColor,
                  iconTheme: IconThemeData(
                    color: AppColors.white.withOpacity(0.7),
                  ),
                  textTheme: const TextTheme(
                    titleMedium: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                inputDecoration: inputDecoration,
                emptyBuilder: _getInfoMessageContainer,
                messageItemBuilder: (context, message, defaultWidget) {
                  return Column(
                    crossAxisAlignment:
                        message.info.direction == ZIMMessageDirection.send
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      defaultWidget,
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  //Appbar
  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            _requestConnectionsList();
            widget.isFromChat ? Get.back() : Get.offNamed(chatListPageRoute);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
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
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
            child: Column(
              children: [
                ChatUserInfo(
                  conversationId: widget.conversation.id,
                ),
                const Divider(
                  color: AppColors.primaryGrey,
                )
              ],
            )),
      );

  //Info Messages
  Widget get _getInfoMessageContainer => Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.conversation.connectedTime != '') _getConnected,
          const PhluidMessageTerms(),
        ],
      ));

  //Connected Title
  Widget get _getConnected => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '-You two are connected on ${DateFormat('dd MMM, yyyy').format(DateTime.parse(widget.conversation.connectedTime))}-',
              style: const TextStyle(color: AppColors.white, fontSize: 14),
            ),
          ],
        ),
      );
}
