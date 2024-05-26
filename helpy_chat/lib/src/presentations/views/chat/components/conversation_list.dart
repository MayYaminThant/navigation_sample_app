import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../values/values.dart';
import '../../../widgets/background_scaffold.dart';
import 'chat_user_info.dart';
import 'phluid_message_terms.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage(
      {Key? key, required this.conversationID, required this.conversationType})
      : super(key: key);

  final String conversationID;
  final ZIMConversationType conversationType;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
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
    hintText: StringConst.messageText,
    hintStyle: TextStyle(
      color: AppColors.primaryGrey,
      fontSize: Sizes.textSize12,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(scaffold: _getChatDetailsScaffold);
  }

  Scaffold get _getChatDetailsScaffold {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ZIMKitMessageListPage(
        appBarBuilder: (context, defaultAppBar) => _getAppBar,
        conversationID: widget.conversationID,
        conversationType: widget.conversationType,
        showPickFileButton: false,
        emptyBuilder: _getInfoMessageContainer,
        sendButtonWidget: const Icon(
          Iconsax.send_24,
          color: AppColors.primaryColor,
        ),
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
        messageItemBuilder: (context, message, defaultWidget) {
          return defaultWidget;
        },
      ),
    );
  }

  //Appbar
  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: const Text(
          StringConst.chatTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 70),
            child: ChatUserInfo(
              conversationId: widget.conversationID,
            )),
      );

  //Info Messages
  Widget get _getInfoMessageContainer => Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          PhluidMessageTerms(),
        ],
      ));
}
