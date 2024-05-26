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
      this.heightButton});

  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? customColor;
  final Color? textColor;
  final double? widthButton;
  final double? heightButton;

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
            if (icon != null)
              Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 14.0),
                  child: icon),
            Text(text,
                style: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: FontWeight.w700,
                    color: textColor ?? AppColors.white))
          ])),
    );
  }
}
