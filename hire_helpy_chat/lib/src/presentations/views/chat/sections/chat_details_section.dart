part of '../../views.dart';

class ChatDetailsSection extends StatefulWidget {
  const ChatDetailsSection({
    super.key,
    required this.conversation,
  });
  final ZIMKitConversation conversation;

  @override
  State<ChatDetailsSection> createState() => _ChatDetailsSectionState();
}

class _ChatDetailsSectionState extends State<ChatDetailsSection> {
  Map? employerData;

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

  bool isMaxCall = false;
  int maxCallCount = 0;

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
  }

  void _requestConnectionsList() {
    final connectionBloc =
    BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionListRequestParams params = ConnectionListRequestParams(
      token: employerData!['token'],
    );
    connectionBloc
        .add(kConnectionBloc.ConnectionListRequested(params: params));
  }

  @override
  void initState() {
    _getCandidateData();
    _getCheckCallCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        onWillPop: () {
          _requestConnectionsList();
          Get.offNamed(chatListPageRoute);
          },
        scaffold: _getChatDetailsScaffold);
  }

  Scaffold get _getChatDetailsScaffold {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ZIMKitMessageListPage(
          appBarBuilder: (context, defaultAppBar) => _getAppBar,
          conversationID: widget.conversation.id,
          conversationType: widget.conversation.type,
          showPickFileButton: false,
          sendButtonWidget: const Icon(
            Iconsax.send_24,
            color: AppColors.primaryColor,
          ),
          onMessageItemPressd:
              (context, ZIMKitMessage message, onMessagePassed) {
            if (message.type == ZIMMessageType.image) {
              Get.toNamed(imageViewPageRoute, parameters: {
                'path': message.imageContent!.fileDownloadUrl,
                'preview': 'true',
                'type': 'network'
              });
            } else {
              if (message.type == ZIMMessageType.video) {
                Get.toNamed(videoViewPageRoute, parameters: {
                  'path': message.videoContent!.fileDownloadUrl,
                  'preview': 'true',
                  'type': 'network'
                });
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
                color: Colors.white, // <-- TextFormField input color
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
        ));
  }

  //Appbar
  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            _requestConnectionsList();
            Get.offNamed(chatListPageRoute);
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
                  conversation: widget.conversation,
                ),
                const Divider(
                  color: AppColors.primaryGrey,
                )
              ],
            )),
        actions: [
          getVideoCallButton,
        ],
      );

  //Info Messages
  get _getInfoMessageContainer => Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.conversation.connectedTime != '') _getConnected,
          const PhluidMessageTerms(),
        ],
      ));

  //Connected Title
  get _getConnected => Padding(
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

  Widget get getVideoCallButton {
    return !isMaxCall
        ? ZegoSendCallInvitationButton(
            iconSize: const Size(36, 36),
            buttonSize: const Size(50, 50),
            isVideoCall: true,
            callID: widget.conversation.id,
            icon: ButtonIcon(icon: const Icon(Iconsax.video)),
            resourceID: "zegouikit_call",
            notificationTitle: 'Incoming Call',
            notificationMessage: 'Call you to interview!',
            invitees: [
              ZegoUIKitUser(
                  id: widget.conversation.id, name: widget.conversation.name)
            ],
            onPressed:
                (String code, String message, List<String> errorInvitees) {
              onCallInvitationSent(context, code, message, errorInvitees);
            },
          )
        : GestureDetector(
            onTap: () => showErrorSnackBar(
                'You have reached the maximum of $maxCallCount calls with this candidate.'),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Iconsax.video),
            ));
  }

  _getSavedVideoCall() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    String savedKey = 'video_call_${getMonthYearFormatDate(DateTime.now())}';
    List<String>? callTimeCacheData = box.get(savedKey) ?? [];

    return callTimeCacheData;
  }

  getMonthYearFormatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  _getCheckCallCount() async {
    List<String> callSavedData = await _getSavedVideoCall();
    maxCallCount = await DBUtils.getKeyDataList('MAX_CALL_COUNT');
    if (callSavedData.isNotEmpty) {
      int count =
          callSavedData.where((e) => e == widget.conversation.id).length;

      if (count == maxCallCount) {
        setState(() {
          isMaxCall = true;
        });
      }
    }
  }
}
