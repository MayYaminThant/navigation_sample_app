import 'package:flutter/material.dart';

class DurationProgressIndicator extends StatefulWidget {
  final Duration duration;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const DurationProgressIndicator(
      {super.key,
      required this.duration,
      this.backgroundColor,
      this.color,
      this.valueColor,
      this.strokeWidth = 4.0,
      this.semanticsLabel,
      this.semanticsValue});

  @override
  State<DurationProgressIndicator> createState() =>
      _DurationProgressIndicatorState();
}

class _DurationProgressIndicatorState extends State<DurationProgressIndicator> {
  late double targetValue;

  @override
  void initState() {
    super.initState();
    targetValue = 1;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: widget.duration,
        builder: (context, value, child) {
          return value == targetValue
              ? CircularProgressIndicator(
                  backgroundColor: widget.backgroundColor,
                  color: widget.color,
                  valueColor: widget.valueColor,
                  strokeWidth: widget.strokeWidth,
                  semanticsLabel: widget.semanticsLabel,
                  semanticsValue: widget.semanticsValue,
                )
              : CircularProgressIndicator(
                  value: value,
                  backgroundColor: widget.backgroundColor,
                  color: widget.color,
                  valueColor: widget.valueColor,
                  strokeWidth: widget.strokeWidth,
                  semanticsLabel: widget.semanticsLabel,
                  semanticsValue: widget.semanticsValue,
                );
        });
  }
}
