part of 'widgets.dart';

class CustomYearPicker extends StatefulWidget {
  const CustomYearPicker(
      {Key? key,
      required this.title,
      required this.onValueChanged,
      required this.initialValue,
      this.backgroundColor,
      this.textColor,
      required this.showOnlyAge})
      : super(key: key);

  final Color? backgroundColor;
  final int initialValue;
  final ValueChanged<int> onValueChanged;
  final String title;
  final Color? textColor;
  final bool showOnlyAge;

  @override
  State<CustomYearPicker> createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  DateTime value = DateTime.now();
  @override
  void didUpdateWidget(covariant CustomYearPicker oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue != 0
          ? DateTime(widget.initialValue)
          : DateTime.now();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != 0) {
      value = DateTime(widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          context: context,
          enableDrag: false,
          isDismissible: true,
          isScrollControlled: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.4,
              builder: (context, scrollController) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: YearPicker(
                    selectedDate: value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onChanged: (val) {
                      setState(() {
                        value = val;
                      });
                      // int year = int.parse(
                      //     (DateTime.now().difference(val).inDays / 365)
                      //         .toStringAsFixed(0));
                      widget.onValueChanged(value.year);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
          height: 47,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              value.year != DateTime.now().year
                  ? _getValue(value)
                  : widget.title,
              style: TextStyle(color: widget.textColor),
            ),
          )),
    );
  }

  _getValue(DateTime value) {
    if (widget.showOnlyAge) {
      return int.parse((DateTime.now()
                  .difference(value)
                  .inDays /
              365)
          .toStringAsFixed(0)).toString();
    } else {
      return value.year.toString();
    }
  }
}
