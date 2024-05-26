import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class CommentForm extends StatefulWidget {
  final bool isReply;
  final String? toUser;
  final Function(String) onSubmit;
  final Function()? onCancel;
  final bool isKeyboardVisible;
  final FocusNode focus;
  final TextEditingController textController;
  final bool isReplyComment;
  final String responseName;

  const CommentForm({
    super.key,
    required this.isReply,
    this.toUser,
    required this.onSubmit,
    required this.isKeyboardVisible,
    required this.textController,
    required this.isReplyComment,
    required this.responseName,
    required this.focus,
    this.onCancel,
  });

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  late TextEditingController textCtrl = TextEditingController();
  String responseName = '';
  bool isReplyComment = false;
  bool textEntered = false;
  String originalText = '';

  @override
  void initState() {
    super.initState();
    textCtrl = widget.textController;
    responseName = widget.responseName;
    isReplyComment = widget.isReplyComment;
    originalText = widget.textController.text;
    _listenToTextChanges();
  }

  void _listenToTextChanges() {
    textCtrl.addListener(() {
      setState(() {
        textEntered =
            textCtrl.text.isNotEmpty && (originalText != textCtrl.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.toUser != null && widget.isReply
                  ? Container(
                      color: const Color(0xFF261b47),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You are replying to ${widget.toUser}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onCancel,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Flexible(
                flex: 5,
                child: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, top: 5, bottom: 4),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: widget.isKeyboardVisible
                                ? const Color(0xFF261b47)
                                : const Color(0xFF314452),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  focusNode: widget.focus,
                                  cursorColor: Colors.white,
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: AppColors.white, fontSize: 14),
                                  controller: widget.textController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 8),
                                    hintText: "Share your thoughts...".tr,
                                    hintStyle: const TextStyle(
                                        color: AppColors.secondaryGrey,
                                        fontSize: 12),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: !textEntered
                                    ? null
                                    : () {
                                        widget.onSubmit(
                                            widget.textController.text);
                                        widget.textController.clear();
                                        textCtrl.clear();
                                      },
                                child: CustomImageView(
                                  image: 'assets/icons/send_right_orange.png',
                                  color: !textEntered
                                      ? AppColors.secondaryGrey
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
