import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zego_zimkit/services/services.dart';

class ZIMKitTextMessage extends StatelessWidget {
  const ZIMKitTextMessage({
    Key? key,
    required this.message,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final ZIMKitMessage message;
  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onPressed;
  final void Function(BuildContext context, LongPressStartDetails details,
      ZIMKitMessage message, Function defaultAction)? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => onPressed?.call(context, message, () {}),
        onLongPressStart: (details) =>
            onLongPress?.call(context, details, message, () {
          Clipboard.setData(ClipboardData(text: message.textContent!.text));
        }),
        child: Container(
          decoration: BoxDecoration(
            color: message.isMine ? Theme.of(context)
                .primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            message.textContent!.text,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: message.isMine
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
      ),
    );
  }
}
