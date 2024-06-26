import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zego_zimkit/zego_zimkit.dart';

// featureList
class ZIMKitMessageListView extends StatefulWidget {
  const ZIMKitMessageListView({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.onPressed,
    this.itemBuilder,
    this.loadingBuilder,
    this.onLongPress,
    this.errorBuilder,
    this.emptyBuilder,
    this.scrollController,
    this.theme,
  }) : super(key: key);

  final String conversationID;
  final ZIMConversationType conversationType;

  final ScrollController? scrollController;

  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onPressed;
  final void Function(BuildContext context, LongPressStartDetails details,
      ZIMKitMessage message, Function defaultAction)? onLongPress;
  final Widget Function(
          BuildContext context, ZIMKitMessage message, Widget defaultWidget)?
      itemBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      errorBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      loadingBuilder;
  final Widget? emptyBuilder;

  // theme
  final ThemeData? theme;

  @override
  State<ZIMKitMessageListView> createState() => _ZIMKitMessageListViewState();
}

class _ZIMKitMessageListViewState extends State<ZIMKitMessageListView> {
  final ScrollController _defaultScrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  ScrollController get _scrollController =>
      widget.scrollController ?? _defaultScrollController;

  Completer? _loadMoreCompleter;
  @override
  void initState() {
    ZIMKit().clearUnreadCount(widget.conversationID, widget.conversationType);
    _scrollController.addListener(scrollControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    ZIMKit().clearUnreadCount(widget.conversationID, widget.conversationType);
    _scrollController.removeListener(scrollControllerListener);
    super.dispose();
  }

  Future<void> scrollControllerListener() async {
    if (_loadMoreCompleter == null || _loadMoreCompleter!.isCompleted) {
      if (_scrollController.position.pixels >=
          0.8 * _scrollController.position.maxScrollExtent) {
        _loadMoreCompleter = Completer();
        if (0 ==
            await ZIMKit().loadMoreMessage(
                widget.conversationID, widget.conversationType)) {
          _scrollController.removeListener(scrollControllerListener);
        }
        _loadMoreCompleter!.complete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? Theme.of(context),
      child: Expanded(
        child: FutureBuilder(
          future: ZIMKit().getMessageListNotifier(
              widget.conversationID, widget.conversationType),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ValueListenableBuilder(
                valueListenable: snapshot.data! as ZIMKitMessageListNotifier,
                builder: (BuildContext context,
                    List<ValueNotifier<ZIMKitMessage>> messageList,
                    Widget? child) {
                  ZIMKit().clearUnreadCount(
                      widget.conversationID, widget.conversationType);
                  return messageList.isEmpty
                      ? SingleChildScrollView(
                          child: widget.emptyBuilder!,
                        )
                      : LayoutBuilder(
                          builder: (context, BoxConstraints constraints) {
                          return SingleChildScrollView(
                          controller: _scrollController,
                          reverse: true,
                          child:  Column(
                            children: [
                              widget.emptyBuilder!,
                              ListView.builder(
                                cacheExtent: constraints.maxHeight * 3,
                                reverse: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  final reversedIndex =
                                      messageList.length - index - 1;
                                  final message = messageList[reversedIndex];
                                  return ValueListenableBuilder(
                                    valueListenable: message,
                                    builder: (BuildContext context,
                                        ZIMKitMessage msg, Widget? child) {
                                      // defaultWidget
                                      final Widget defaultWidget =
                                          ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth,
                                          maxHeight:
                                              msg.type == ZIMMessageType.text
                                                  ? double.maxFinite
                                                  : constraints.maxHeight * 0.5,
                                        ),
                                        child: ZIMKitMessageWidget(
                                          key: ValueKey(msg.hashCode),
                                          message: msg,
                                          onPressed: widget.onPressed,
                                          onLongPress: widget.onLongPress,
                                        ),
                                      );
                                      // TODO spacing
                                      // TODO 时间间隔
                                      // customWidget
                                      return widget.itemBuilder?.call(
                                              context, msg, defaultWidget) ??
                                          defaultWidget;
                                    },
                                  );
                                },
                              )
                            ],
                          ));
                        });
                },
              );
            } else if (!snapshot.hasData && widget.emptyBuilder != null) {
              return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                return Container();
              });
            } else if (snapshot.hasError) {
              final Widget defaultWidget = Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() {}),
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                    Text(snapshot.error.toString()),
                    const Text('Load failed, please click to retry'),
                  ],
                ),
              );

              // customWidget
              return GestureDetector(
                onTap: () => setState(() {}),
                child: widget.errorBuilder?.call(context, defaultWidget) ??
                    defaultWidget,
              );
            } else {
              // defaultWidget
              const Widget defaultWidget =
                  Center(child: CircularProgressIndicator());

              // customWidget
              return widget.loadingBuilder?.call(context, defaultWidget) ??
                  defaultWidget;
            }
          },
        ),
      ),
    );
  }
}
