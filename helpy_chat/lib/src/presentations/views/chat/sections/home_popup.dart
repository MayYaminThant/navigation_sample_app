import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'zego_didalog.dart';

class HomePagePopupMenuButton extends StatefulWidget {
  const HomePagePopupMenuButton({Key? key}) : super(key: key);

  @override
  State<HomePagePopupMenuButton> createState() => _HomePagePopupMenuButtonState();
}

class _HomePagePopupMenuButtonState extends State<HomePagePopupMenuButton> {
  final userIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  final groupIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      position: PopupMenuPosition.under,
      icon: const Icon(CupertinoIcons.add_circled),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'New Chat',
            child:
                const ListTile(leading: Icon(CupertinoIcons.chat_bubble_2_fill), title: Text('New Chat', maxLines: 1)),
            onTap: () => showDefaultNewPeerChatDialog(context),
          ),
        ];
      },
    );
  }
}