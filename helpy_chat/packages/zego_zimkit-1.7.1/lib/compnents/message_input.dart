import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zego_zimkit/compnents/messages/widgets/widgets.dart';
import 'package:zego_zimkit/services/services.dart';

class ZIMKitMessageInput extends StatefulWidget {
  const ZIMKitMessageInput({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.onMessageSent,
    this.preMessageSending,
    this.editingController,
    this.showPickFileButton = true,
    this.showPickMediaButton = true,
    this.actions = const [],
    this.inputDecoration,
    this.theme,
    this.onMediaFilesPicked,
    this.sendButtonWidget,
    this.pickMediaButtonWidget,
    this.pickFileButtonWidget,
    this.inputFocusNode,
    this.inputBackgroundDecoration,
  }) : super(key: key);

  /// The conversationID of the conversation to send message.
  final String conversationID;

  /// The conversationType of the conversation to send message.
  final ZIMConversationType conversationType;

  /// By default, [ZIMKitMessageInput] will show a button to pick file.
  /// If you don't want to show this button, set [showPickFileButton] to false.
  final bool showPickFileButton;

  /// By default, [ZIMKitMessageInput] will show a button to pick media.
  /// If you don't want to show this button, set [showPickMediaButton] to false.
  final bool showPickMediaButton;

  /// To add your own action, use the [actions] parameter like this:
  ///
  /// use [actions] like this to add your custom actions:
  ///
  /// actions: [
  ///   ZIMKitMessageInputAction.left(IconButton(
  ///     icon: Icon(
  ///       Icons.mic,
  ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
  ///     ),
  ///     onPressed: () {},
  ///   )),
  ///   ZIMKitMessageInputAction.leftInside(IconButton(
  ///     icon: Icon(
  ///       Icons.sentiment_satisfied_alt_outlined,
  ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
  ///     ),
  ///     onPressed: () {},
  ///   )),
  ///   ZIMKitMessageInputAction.rightInside(IconButton(
  ///     icon: Icon(
  ///       Icons.cabin,
  ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
  ///     ),
  ///     onPressed: () {},
  ///   )),
  ///   ZIMKitMessageInputAction.right(IconButton(
  ///     icon: Icon(
  ///       Icons.sd,
  ///       color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
  ///     ),
  ///     onPressed: () {},
  ///   )),
  /// ],
  final List<ZIMKitMessageInputAction>? actions;

  /// Called when a message is sent.
  final void Function(ZIMKitMessage)? onMessageSent;

  /// Called before a message is sent.
  final FutureOr<ZIMKitMessage> Function(ZIMKitMessage)? preMessageSending;

  final void Function(BuildContext context, List<PlatformFile> files,
      Function defaultAction)? onMediaFilesPicked;

  /// The TextField's decoration.
  final InputDecoration? inputDecoration;

  /// The [TextEditingController] to use. if not provided, a default one will be created.
  final TextEditingController? editingController;

  // theme
  final ThemeData? theme;

  final Widget? sendButtonWidget;

  final Widget? pickMediaButtonWidget;

  final Widget? pickFileButtonWidget;

  final FocusNode? inputFocusNode;

  final BoxDecoration? inputBackgroundDecoration;

  @override
  State<ZIMKitMessageInput> createState() => _ZIMKitMessageInputState();
}

class _ZIMKitMessageInputState extends State<ZIMKitMessageInput> {
  // TODO RestorableTextEditingController
  final TextEditingController _defaultEditingController =
      TextEditingController();
  TextEditingController get _editingController =>
      widget.editingController ?? _defaultEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
            ...buildActions(ZIMKitMessageInputActionLocation.left),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: widget.inputBackgroundDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                child: Row(
                  children: [
                    ...buildActions(
                        ZIMKitMessageInputActionLocation.leftInside),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        focusNode: widget.inputFocusNode,
                        onSubmitted: (value) => sendTextMessage(),
                        controller: _editingController,
                        decoration: widget.inputDecoration ??
                            const InputDecoration(hintText: 'Type message'),
                      ),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _editingController,
                      builder: (context, textEditingValue, child) {
                        return Builder(
                          builder: (context) {
                            if (textEditingValue.text.isNotEmpty ||
                                rightInsideActionsIsEmpty) {
                              return Container(
                                height: 32,
                                width: 32,
                                decoration: widget.sendButtonWidget == null
                                    ? BoxDecoration(
                                        color: textEditingValue.text.isNotEmpty
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      )
                                    : null,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: widget.sendButtonWidget ??
                                      const Icon(Icons.send,
                                          size: 16, color: Colors.white),
                                  onPressed: textEditingValue.text.isNotEmpty
                                      ? sendTextMessage
                                      : null,
                                ),
                              );
                            } else {
                              return Row(
                                children: [
                                  if (widget.showPickMediaButton)
                                    ZIMKitPickMediaButton(
                                      icon: widget.pickMediaButtonWidget,
                                      onFilePicked: (List<PlatformFile> files) {
                                        void defaultAction() {
                                          ZIMKit().sendMediaMessage(
                                            widget.conversationID,
                                            widget.conversationType,
                                            files,
                                            onMessageSent: widget.onMessageSent,
                                            preMessageSending:
                                                widget.preMessageSending,
                                          );
                                        }

                                        if (widget.onMediaFilesPicked != null) {
                                          widget.onMediaFilesPicked!(
                                              context, files, defaultAction);
                                        } else {
                                          defaultAction();
                                        }
                                      },
                                    ),
                                  if (widget.showPickFileButton)
                                    ZIMKitPickFileButton(
                                      icon: widget.pickFileButtonWidget,
                                      onFilePicked: (List<PlatformFile> files) {
                                        void defaultAction() {
                                          ZIMKit().sendFileMessage(
                                            widget.conversationID,
                                            widget.conversationType,
                                            files,
                                            onMessageSent: widget.onMessageSent,
                                            preMessageSending:
                                                widget.preMessageSending,
                                          );
                                        }

                                        if (widget.onMediaFilesPicked != null) {
                                          widget.onMediaFilesPicked!(
                                              context, files, defaultAction);
                                        } else {
                                          defaultAction();
                                        }
                                      },
                                    ),
                                  ...buildActions(
                                      ZIMKitMessageInputActionLocation
                                          .rightInside),
                                ],
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            ...buildActions(ZIMKitMessageInputActionLocation.right),
          ],
        ),
      ),
    );
  }

  Future<void> sendTextMessage() async {
    ZIMKit().sendTextMessage(
      widget.conversationID,
      widget.conversationType,
      _editingController.text,
      onMessageSent: widget.onMessageSent,
      preMessageSending: widget.preMessageSending,
    );
    _editingController.clear();
    // TODO mac auto focus or not
    // TODO mobile auto focus or not
  }

  List<Widget> buildActions(ZIMKitMessageInputActionLocation location) {
    return widget.actions
            ?.where((element) => element.location == location)
            .map((e) => e.child)
            .toList() ??
        [];
  }

  bool get rightInsideActionsIsEmpty =>
      (widget.actions
              ?.where((element) =>
                  element.location ==
                  ZIMKitMessageInputActionLocation.rightInside)
              .isEmpty ??
          true) &&
      !widget.showPickFileButton &&
      !widget.showPickMediaButton;
}

enum ZIMKitMessageInputActionLocation { left, right, leftInside, rightInside }

class ZIMKitMessageInputAction {
  const ZIMKitMessageInputAction(this.child,
      [this.location = ZIMKitMessageInputActionLocation.rightInside]);
  const ZIMKitMessageInputAction.left(Widget child)
      : this(child, ZIMKitMessageInputActionLocation.left);
  const ZIMKitMessageInputAction.right(Widget child)
      : this(child, ZIMKitMessageInputActionLocation.right);
  const ZIMKitMessageInputAction.leftInside(Widget child)
      : this(child, ZIMKitMessageInputActionLocation.leftInside);
  const ZIMKitMessageInputAction.rightInside(Widget child)
      : this(child, ZIMKitMessageInputActionLocation.rightInside);

  final Widget child;
  final ZIMKitMessageInputActionLocation location;
}
