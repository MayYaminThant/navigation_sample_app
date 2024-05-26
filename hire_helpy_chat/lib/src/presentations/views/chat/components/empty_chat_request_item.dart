import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../values/values.dart';
import 'declaration_chat.dart';

class EmptyChatRequestItem extends StatefulWidget {
  const EmptyChatRequestItem(
      {super.key, required this.title, required this.desc});
  final String title;
  final String desc;

  @override
  State<EmptyChatRequestItem> createState() => _EmptyChatRequestItemState();
}

class _EmptyChatRequestItemState extends State<EmptyChatRequestItem> {
  @override
  Widget build(BuildContext context) {
    return _getEmptySearchResult;
  }

  Widget get _getEmptySearchResult => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/image_not_found.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Click ',
                        style: TextStyle(
                            color: AppColors.primaryGrey,
                            fontSize: 15,
                            height: 2)),
                    TextSpan(
                        text: 'Here ',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            height: 2,
                            fontStyle: FontStyle.italic),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              _showChatRequestInfoModal()),
                    TextSpan(
                        text: widget.desc,
                        style: const TextStyle(
                            color: AppColors.primaryGrey,
                            fontSize: 15,
                            height: 2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );

  _showChatRequestInfoModal() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return const DeclarationRequestModal();
        },
      );
  }
}
