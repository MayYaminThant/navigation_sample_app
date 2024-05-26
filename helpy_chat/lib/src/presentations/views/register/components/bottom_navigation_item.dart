import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem(
      {super.key,
      required this.onNextButtonPressed,
      this.isNoBack,
      required this.onSaveAndQuitButtonPressed,
      this.nextButtonText});
  final VoidCallback? onNextButtonPressed;
  final bool? isNoBack;
  final VoidCallback? onSaveAndQuitButtonPressed;
  final String? nextButtonText;

  @override
  Widget build(BuildContext context) {
    return _bottomNavigationBar(context);
  }

  Widget _bottomNavigationBar(BuildContext context) => SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isNoBack != null
                  ? _getNextButton
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: CustomOutlineButton(
                            heightButton: Sizes.button47,
                            widthButton: 130,
                            text: StringConst.backText,
                            fontSize: 16,
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Flexible(
                            flex: isNoBack != null ? 1 : 4,
                            child: _getNextButton)
                      ],
                    ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: Sizes.button47,
                  child: CustomOutlineButton(
                    text: StringConst.saveAndQuitEditingText,
                    fontSize: 16,
                    onPressed: onSaveAndQuitButtonPressed,
                  )),
            ],
          ),
        ),
      );

  Widget get _getNextButton => CustomPrimaryButton(
        heightButton: Sizes.button47,
        text: nextButtonText ?? StringConst.saveAndNextText.tr,
        fontSize: isNoBack != null
            ? null
            : isBurmese(nextButtonText ?? StringConst.saveAndNextText.tr)
                ? 12
                : null,
        onPressed: onNextButtonPressed,
      );
  bool isBurmese(String input) {
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      if ((charCode >= 0x1000 && charCode <= 0x109F) ||
          (charCode >= 0xAA60 && charCode <= 0xAA7F)) {
        return true;
      }
    }
    return false;
  }
}
