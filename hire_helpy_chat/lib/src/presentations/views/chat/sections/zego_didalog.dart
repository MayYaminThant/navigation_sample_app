import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zego_zimkit/pages/pages.dart';
import 'package:zego_zimkit/services/services.dart';

void onCallInvitationSent(BuildContext context, String code, String message,
    List<String> errorInvitees) {
  late String log;
  if (errorInvitees.isNotEmpty) {
    log = "User doesn't exist or is offline: ${errorInvitees[0]}";
    // if (code.isNotEmpty) {
    //   log += ', code: $code, message:$message';
    // }
  // } else if (code.isNotEmpty) {
  //   log = 'code: $code, message:$message';
  } else {
    log = 'Call Declined';
    // log = 'ERROR IN ZEGO DIALOG';
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(log)),
  );
}

void showDefaultNewGroupChatDialog(BuildContext context) {
  final groupIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('New Group'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: groupNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Group Name',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: groupIDController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ID(optional)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 3,
                  controller: groupUsersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Invite User IDs',
                    hintText: 'separate by comma, e.g. 123,987,229',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
      },
    ).then((bool? ok) {
      if (ok != true) return;
      if (groupNameController.text.isNotEmpty &&
          groupUsersController.text.isNotEmpty) {
        ZIMKit()
            .createGroup(
          groupNameController.text,
          groupUsersController.text.split(','),
          id: groupIDController.text,
        )
            .then((String? conversationID) {
          if (conversationID != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ZIMKitMessageListPage(
                conversationID: conversationID,
                conversationType: ZIMConversationType.group,
              );
            }));
          }
        });
      }
    });
  });
}

void showDefaultJoinGroupDialog(BuildContext context) {
  final groupIDController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Join Group'),
            content: TextField(
              controller: groupIDController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Group ID',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
      },
    ).then((bool? ok) {
      if (ok != true) return;
      if (groupIDController.text.isNotEmpty) {
        ZIMKit().joinGroup(groupIDController.text).then((int errorCode) {
          if (errorCode == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ZIMKitMessageListPage(
                conversationID: groupIDController.text,
                conversationType: ZIMConversationType.group,
              );
            }));
          }
        });
      }
    });
  });
}
