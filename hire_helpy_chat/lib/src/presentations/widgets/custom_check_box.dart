part of 'widgets.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    this.initialValue,
    required this.onValueChanged,
    this.trailing,
    this.leading,
    this.mainAxisAlignment,
    this.checkBoxColor,
    this.isDisabled = false,
  });

  final ValueChanged<bool> onValueChanged;
  final bool? initialValue;
  final Widget? trailing;
  final Widget? leading;
  final MainAxisAlignment? mainAxisAlignment;
  final Color? checkBoxColor;
  final bool isDisabled;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    isCheck = widget.initialValue ?? false;
  }

  @override
  void didUpdateWidget(covariant CustomCheckBox oldWidget) {
    if (widget.initialValue != null &&
        oldWidget.initialValue != widget.initialValue) {
      isCheck = widget.initialValue ?? false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isDisabled
          ? null
          : () {
              setState(() {
                isCheck = !isCheck;
                widget.onValueChanged(isCheck);
              });
            },
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          if (widget.leading != null)
            Row(
              children: [
                widget.leading ?? const SizedBox.shrink(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          Container(
            width: 21,
            height: 21,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: widget.checkBoxColor ??
                    AppColors.primaryGrey.withOpacity(0.1)),
            child:
                isCheck ? Image.asset('assets/icons/check.png') : Container(),
          ),
          if (widget.trailing != null)
            Row(
              children: [
                const SizedBox(width: 10),
                widget.trailing ?? Container()
              ],
            ),
        ],
      ),
    );
  }
}
