part of 'widgets.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker(
      {Key? key,
      required this.controller,
      required this.isInitialDate,
      this.isShowPreviousDate,
      required this.enabled,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  final TextEditingController controller;
  final bool isInitialDate;
  final bool? isShowPreviousDate;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  void initState() {
    super.initState();
    if (widget.isInitialDate) {
      //widget.controller.text = DateTime.now().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en_ISO');
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: AppColors.primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: DateTimePicker(
            type: DateTimePickerType.time,
            enabled: widget.enabled,
            controller: widget.controller,
            initialTime: TimeOfDay.now(),
            use24HourFormat: true,
            style: TextStyle(
                fontSize: 14, color: widget.textColor ?? AppColors.black),
            decoration: const InputDecoration(
                hintText: 'HH:MM ',
                hintStyle:
                    TextStyle(fontSize: 14, color: AppColors.primaryGrey),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Iconsax.calendar5,
                  color: AppColors.primaryGrey,
                  size: 20,
                )),
            onChanged: (val) => setState(() => widget.controller.text = val),
            validator: (val) {
              setState(() => widget.controller.text = val ?? '');
              return null;
            },
            onSaved: (val) =>
                setState(() => widget.controller.text = val ?? ''),
          ),
        ),
      ),
    );
  }
}
