import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/core/utils/constants.dart';
import 'package:dh_employer/src/presentations/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class ChatItem extends StatefulWidget {
  const ChatItem(
      {super.key,
      required this.conversation,
      required this.token,
      required this.onValueChanged});

  final ZIMKitConversation conversation;
  final String token;
  final ValueChanged<ZIMKitConversation> onValueChanged;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getConversationItem(widget.conversation);
  }

  //Conversation Item
  _getConversationItem(ZIMKitConversation conversation) {
    //print('aaa ${conversation.}');
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: (_) => widget.onValueChanged(conversation),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
            label: 'Unlink'.tr,
            icon: Iconsax.link,
            spacing: 1,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
          ),
        ],
      ),
      closeOnScroll: true,
      child: InkWell(
        onTap: () => _goToChatDetail(conversation),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.conversation.avatarUrl != ''
                    ? widget.conversation.avatarUrl
                    : '$kS3BasePhotoUrl$kDefaultAvatar',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.white,
                ),
                placeholder: (context, url) => const SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          conversation.name,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      conversation.unreadMessageCount != 0
                          ? Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: const BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Center(
                                child: Text(
                                  conversation.unreadMessageCount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    truncateMessageByWidth(
                        _getMessageByType(), MediaQuery.of(context).size.width),
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String truncateMessageByWidth(String message, double maxWidth) {
    double avgCharWidth = 12;
    int maxChars = (maxWidth / avgCharWidth).floor();
    List<String> words = message.split(' ');
    String truncatedMessage = '';
    int wordCount = 0;

    for (String word in words) {
      if ((truncatedMessage.length + word.length + 1) <= maxChars) {
        truncatedMessage += '$word ';
        wordCount++;
      } else {
        break;
      }
    }

    // Add ellipsis if message is truncated
    if (wordCount < words.length) {
      truncatedMessage += '...';
    }

    return truncatedMessage.trim();
  }

  String _getMessageByType() {
    if (widget.conversation.lastMessage != null) {
      switch (widget.conversation.lastMessage!.type) {
        case ZIMMessageType.unknown:
          return widget.conversation.lastMessage!.textContent.toString();

        case ZIMMessageType.text:
          return widget.conversation.lastMessage!.textContent!.text;
        case ZIMMessageType.command:
          return 'send a command.';
        case ZIMMessageType.barrage:
          return 'send a barrage.';
        case ZIMMessageType.image:
          return 'send an image.';
        case ZIMMessageType.file:
          return 'send a file.';
        case ZIMMessageType.audio:
          return 'send a audio.';
        case ZIMMessageType.video:
          return 'send a video.';
        case ZIMMessageType.system:
          return 'send a system.';
        case ZIMMessageType.revoke:
          return 'send a revoke.';
      }
    } else {
      return 'No message';
    }
  }

  _goToChatDetail(ZIMKitConversation conversation) {
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: chatDetailPageRoute),
          builder: (context) {
            return ChatDetailsSection(
              conversation: conversation,
            );
          },
        ));
  }
}
