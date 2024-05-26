import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem(
      {super.key, required this.onNextButtonPressed, this.isNoBack, required this.onSaveAndQuitButtonPressed, this.nextButtonText});
  final VoidCallback? onNextButtonPressed;
  final bool? isNoBack;
  final VoidCallback? onSaveAndQuitButtonPressed;
  final String? nextButtonText;

  @override
  Widget build(BuildContext context) {
    return _bottomNavigationBar(context);
  }

  _bottomNavigationBar(BuildContext context) => SizedBox(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              isNoBack != null
                  ? getNextButton(context)
                  : Table(
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: Sizes.button47,
                                child: CustomOutlineButton(
                                  text: StringConst.backText,
                                  fontSize: 16,
                                  onPressed: () => Get.back(),
                                )),
                          ),
                          getNextButton(context)
                        ])
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: Sizes.button47,
                    child: CustomOutlineButton(
                      text: StringConst.saveAndQuitEditingText,
                      fontSize: 16,
                      onPressed: onSaveAndQuitButtonPressed,
                    )),
              ),
            ],
          ),
        ),
      );

  getNextButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Sizes.button47,
            child: CustomPrimaryButton(
              text: nextButtonText ?? "Save and Next".tr,
              fontSize: 16,
              onPressed: onNextButtonPressed,
            )),
      );
}
