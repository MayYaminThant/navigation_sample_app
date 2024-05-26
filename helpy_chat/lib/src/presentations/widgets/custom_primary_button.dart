part of 'widgets.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.fontSize,
      this.heightButton,
      this.widthButton,
      this.customColor,
      this.textColor,
      this.borderRadius,
      this.child});
  final String text;
  final VoidCallback? onPressed;
  final double? fontSize;
  final double? widthButton;
  final double? heightButton;
  final Color? customColor;
  final Color? textColor;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton,
      height: heightButton,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(customColor ??
                  (onPressed == null
                      ? AppColors.cardColor
                      : AppColors.primaryColor)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              ))),
          onPressed: onPressed,
          child: child != null
              ? Center(
                  child: child,
                )
              : Center(
                  child: Text(text.tr,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: fontSize ?? 16,
                          fontWeight: FontWeight.w700,
                          color: textColor ??
                              (onPressed == null
                                  ? AppColors.whiteShade1
                                  : AppColors.white))),
                )),
    );
  }
}
