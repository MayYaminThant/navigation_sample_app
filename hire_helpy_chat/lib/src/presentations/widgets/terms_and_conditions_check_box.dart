part of 'widgets.dart';

class TermsAndConditionsCheckBox extends StatefulWidget {
  const TermsAndConditionsCheckBox({
    super.key,
    this.initialValue,
    required this.onValueChanged,
    required this.trailing,
    this.checkBoxColor,
    this.isDisabled = false,
  });

  final ValueChanged<bool> onValueChanged;
  final bool? initialValue;
  final Widget trailing;
  final Color? checkBoxColor;
  final bool isDisabled;

  @override
  State<TermsAndConditionsCheckBox> createState() =>
      _TermsAndConditionsCheckBoxState();
}

class _TermsAndConditionsCheckBoxState
    extends State<TermsAndConditionsCheckBox> {
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    isCheck = widget.initialValue ?? false;
  }

  @override
  void didUpdateWidget(covariant TermsAndConditionsCheckBox oldWidget) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: 21,
                height: 21,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: widget.checkBoxColor ??
                        AppColors.primaryGrey.withOpacity(0.1)),
                child: isCheck
                    ? Image.asset('assets/icons/check.png')
                    : Container(),
              )),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                Flexible(child: widget.trailing)
              ],
            ),
          ),
          const SizedBox(width: 6)
        ],
      ),
    );
  }
}
