part of 'widgets.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key,
      required this.text,
      this.icon,
      this.onPressed,
      this.fontSize,
      this.customColor,
      this.textColor,
      this.widthButton,
      this.heightButton,
      this.showLoading = false});

  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? customColor;
  final Color? textColor;
  final double? widthButton;
  final double? heightButton;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      height: heightButton,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  customColor ?? AppColors.cardColor.withOpacity(0.1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          BorderSide(color: textColor ?? Colors.transparent)))),
          onPressed: onPressed,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, right: 14.0),
                    child: icon)
                : Container(),
            Text(text.tr,
                style: TextStyle(
                    fontSize: isBurmese(text.tr) ? 14 : fontSize ?? 18,
                    fontWeight: FontWeight.w700,
                    color: textColor ?? AppColors.white))
          ])),
    );
  }

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
