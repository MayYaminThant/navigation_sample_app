part of 'widgets.dart';

class Marquee extends StatefulWidget {
  Marquee({
    super.key,
    required this.text,
    this.isShowIcon = false,
    this.style,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.scrollAxis = Axis.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.blankSpace = 0.0,
    this.velocity = 50.0,
    this.startAfter = Duration.zero,
    this.pauseAfterRound = Duration.zero,
    this.showFadingOnlyWhenScrolling = true,
    this.fadingEdgeStartFraction = 0.0,
    this.fadingEdgeEndFraction = 0.0,
    this.numberOfRounds,
    this.startPadding = 0.0,
    this.accelerationDuration = Duration.zero,
    Curve accelerationCurve = Curves.decelerate,
    this.decelerationDuration = Duration.zero,
    Curve decelerationCurve = Curves.decelerate,
    this.onDone,
  })  : assert(!blankSpace.isNaN),
        assert(blankSpace >= 0, "The blankSpace needs to be positive or zero."),
        assert(blankSpace.isFinite),
        assert(!velocity.isNaN),
        assert(velocity != 0.0, "The velocity cannot be zero."),
        assert(velocity.isFinite),
        assert(
          pauseAfterRound >= Duration.zero,
          "The pauseAfterRound cannot be negative as time travel isn't "
          "invented yet.",
        ),
        assert(
          fadingEdgeStartFraction >= 0 && fadingEdgeStartFraction <= 1,
          "The fadingEdgeGradientFractionOnStart value should be between 0 and "
          "1, inclusive",
        ),
        assert(
          fadingEdgeEndFraction >= 0 && fadingEdgeEndFraction <= 1,
          "The fadingEdgeGradientFractionOnEnd value should be between 0 and "
          "1, inclusive",
        ),
        assert(numberOfRounds == null || numberOfRounds > 0),
        assert(
          accelerationDuration >= Duration.zero,
          "The accelerationDuration cannot be negative as time travel isn't "
          "invented yet.",
        ),
        assert(
          decelerationDuration >= Duration.zero,
          "The decelerationDuration must be positive or zero as time travel "
          "isn't invented yet.",
        ),
        accelerationCurve = IntegralCurve(accelerationCurve),
        decelerationCurve = IntegralCurve(decelerationCurve);
  final String text;
  final bool isShowIcon;
  final TextStyle? style;
  final double? textScaleFactor;
  final TextDirection textDirection;
  final Axis scrollAxis;
  final CrossAxisAlignment crossAxisAlignment;
  final double blankSpace;
  final double velocity;
  final Duration startAfter;
  final Duration pauseAfterRound;
  final int? numberOfRounds;
  final bool showFadingOnlyWhenScrolling;
  final double fadingEdgeStartFraction;
  final double fadingEdgeEndFraction;
  final double startPadding;
  final Duration accelerationDuration;
  final IntegralCurve accelerationCurve;
  final Duration decelerationDuration;
  final IntegralCurve decelerationCurve;
  final VoidCallback? onDone;

  @override
  State<StatefulWidget> createState() => _MarqueeState();
}

class IntegralCurve extends Curve {
  static double delta = 0.01;

  const IntegralCurve._(this.original, this.integral, this._values);
  final Curve original;
  final double integral;
  final Map<double, double> _values;
  factory IntegralCurve(Curve original) {
    double integral = 0.0;
    final values = <double, double>{};

    for (double t = 0.0; t <= 1.0; t += delta) {
      integral += original.transform(t) * delta;
      values[t] = integral;
    }
    values[1.0] = integral;
    for (final double t in values.keys) {
      values[t] = values[t]! / integral;
    }

    return IntegralCurve._(original, integral, values);
  }

  @override
  double transform(double t) {
    if (t < 0) return 0.0;
    for (final key in _values.keys) {
      if (key > t) return _values[key]!;
    }
    return 1.0;
  }
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  late double _startPosition;
  late double _accelerationTarget;
  late double _linearTarget;
  late double _decelerationTarget;
  late Duration _totalDuration;

  Duration get _accelerationDuration => widget.accelerationDuration;
  Duration? _linearDuration;
  Duration get _decelerationDuration => widget.decelerationDuration;
  bool _running = false;
  bool _isOnPause = false;
  int _roundCounter = 0;
  bool get isDone => widget.numberOfRounds == null
      ? false
      : widget.numberOfRounds == _roundCounter;
  bool get showFading =>
      !widget.showFadingOnlyWhenScrolling ? true : !_isOnPause;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_running) {
        _running = true;
        if (_controller.hasClients) {
          _controller.jumpTo(_startPosition);
          await Future<void>.delayed(widget.startAfter);
          Future.doWhile(_scroll);
        }
      }
    });
  }

  Future<bool> _scroll() async {
    await _makeRoundTrip();
    if (isDone && widget.onDone != null) {
      widget.onDone!();
    }
    return _running && !isDone && _controller.hasClients;
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as Marquee);
  }

  @override
  void dispose() {
    _running = false;
    super.dispose();
  }

  void _initialize(BuildContext context) {
    final totalLength = _getTextWidth(context) + widget.blankSpace;
    final accelerationLength = widget.accelerationCurve.integral *
        widget.velocity *
        _accelerationDuration.inMilliseconds /
        1000.0;
    final decelerationLength = widget.decelerationCurve.integral *
        widget.velocity *
        _decelerationDuration.inMilliseconds /
        1000.0;
    final linearLength =
        (totalLength - accelerationLength.abs() - decelerationLength.abs()) *
            (widget.velocity > 0 ? 1 : -1);
    _startPosition = 2 * totalLength - widget.startPadding;
    _accelerationTarget = _startPosition + accelerationLength;
    _linearTarget = _accelerationTarget + linearLength;
    _decelerationTarget = _linearTarget + decelerationLength;
    _totalDuration = _accelerationDuration +
        _decelerationDuration +
        Duration(milliseconds: (linearLength / widget.velocity * 1000).toInt());
    _linearDuration =
        _totalDuration - _accelerationDuration - _decelerationDuration;

    assert(
      _totalDuration > Duration.zero,
      "With the given values, the total duration for one round would be "
      "negative. As time travel isn't invented yet, this shouldn't happen.",
    );
    assert(
      _linearDuration! >= Duration.zero,
      "Acceleration and deceleration phase overlap. To fix this, try a "
      "combination of these approaches:\n"
      "* Make the text longer, so there's more room to animate within.\n"
      "* Shorten the accelerationDuration or decelerationDuration.\n"
      "* Decrease the velocity, so the duration to animate within is longer.\n",
    );
  }

  Future<void> _makeRoundTrip() async {
    if (!_controller.hasClients) return;
    _controller.jumpTo(_startPosition);
    if (!_running) return;

    await _accelerate();
    if (!_running) return;

    await _moveLinearly();
    if (!_running) return;

    await _decelerate();

    _roundCounter++;

    if (!_running || !mounted) return;

    if (widget.pauseAfterRound > Duration.zero) {
      setState(() => _isOnPause = true);

      await Future.delayed(widget.pauseAfterRound);

      if (!mounted || isDone) return;
      setState(() => _isOnPause = false);
    }
  }

  Future<void> _accelerate() async {
    await _animateTo(
      _accelerationTarget,
      _accelerationDuration,
      widget.accelerationCurve,
    );
  }

  Future<void> _moveLinearly() async {
    await _animateTo(_linearTarget, _linearDuration, Curves.linear);
  }

  Future<void> _decelerate() async {
    await _animateTo(
      _decelerationTarget,
      _decelerationDuration,
      widget.decelerationCurve.flipped,
    );
  }

  Future<void> _animateTo(
    double? target,
    Duration? duration,
    Curve curve,
  ) async {
    if (!_controller.hasClients) return;
    if (duration! > Duration.zero) {
      await _controller.animateTo(target!, duration: duration, curve: curve);
    } else {
      _controller.jumpTo(target!);
    }
  }

  double _getTextWidth(BuildContext context) {
    final span = TextSpan(text: widget.text, style: widget.style);

    const constraints = BoxConstraints(maxWidth: double.infinity);

    final richTextWidget = Text.rich(span).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);

    final boxes = renderObject.getBoxesForSelection(TextSelection(
      baseOffset: 0,
      extentOffset: TextSpan(text: widget.text).toPlainText().length,
    ));

    return boxes.last.right;
  }

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    bool isHorizontal = widget.scrollAxis == Axis.horizontal;

    Alignment? alignment;

    switch (widget.crossAxisAlignment) {
      case CrossAxisAlignment.start:
        alignment = isHorizontal ? Alignment.topCenter : Alignment.centerLeft;
        break;
      case CrossAxisAlignment.end:
        alignment =
            isHorizontal ? Alignment.bottomCenter : Alignment.centerRight;
        break;
      case CrossAxisAlignment.center:
        alignment = Alignment.center;
        break;
      case CrossAxisAlignment.stretch:
      case CrossAxisAlignment.baseline:
        alignment = null;
        break;
    }

    Widget marquee = ListView.builder(
      controller: _controller,
      scrollDirection: widget.scrollAxis,
      reverse: widget.textDirection == TextDirection.rtl,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        final text = i.isEven
            ? widget.isShowIcon
                ? Row(
                    children: [
                      const Icon(Iconsax.notification_bing5,
                          color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.text,
                          style: widget.style,
                          textScaleFactor: widget.textScaleFactor),
                    ],
                  )
                : Text(widget.text,
                    style: widget.style,
                    textScaleFactor: widget.textScaleFactor)
            : _buildBlankSpace();
        return alignment == null
            ? text
            : Align(alignment: alignment, child: text);
      },
    );

    return kIsWeb ? marquee : _wrapWithFadingEdgeScrollView(marquee);
  }

  Widget _buildBlankSpace() {
    return SizedBox(
      width: widget.scrollAxis == Axis.horizontal ? widget.blankSpace : null,
      height: widget.scrollAxis == Axis.vertical ? widget.blankSpace : null,
    );
  }

  Widget _wrapWithFadingEdgeScrollView(Widget child) {
    return FadingEdgeScrollView.fromScrollView(
      gradientFractionOnStart:
          !showFading ? 0.0 : widget.fadingEdgeStartFraction,
      gradientFractionOnEnd: !showFading ? 0.0 : widget.fadingEdgeEndFraction,
      child: child as ScrollView,
    );
  }
}

class FadingEdgeScrollView extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final bool reverse;
  final Axis scrollDirection;
  final double gradientFractionOnStart;
  final double gradientFractionOnEnd;

  const FadingEdgeScrollView._internal({
    super.key,
    required this.child,
    required this.scrollController,
    required this.reverse,
    required this.scrollDirection,
    required this.gradientFractionOnStart,
    required this.gradientFractionOnEnd,
  })  : assert(gradientFractionOnStart >= 0 && gradientFractionOnStart <= 1),
        assert(gradientFractionOnEnd >= 0 && gradientFractionOnEnd <= 1);
  factory FadingEdgeScrollView.fromScrollView({
    Key? key,
    required ScrollView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
  }) {
    final controller = child.controller;
    if (controller == null) {
      throw Exception("Child must have controller set");
    }

    return FadingEdgeScrollView._internal(
      key: key,
      scrollController: controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      child: child,
    );
  }
  factory FadingEdgeScrollView.fromSingleChildScrollView({
    Key? key,
    required SingleChildScrollView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
  }) {
    final controller = child.controller;
    if (controller == null) {
      throw Exception("Child must have controller set");
    }

    return FadingEdgeScrollView._internal(
      key: key,
      scrollController: controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      child: child,
    );
  }
  factory FadingEdgeScrollView.fromPageView({
    Key? key,
    required PageView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
  }) {
    final controller = child.controller;
    return FadingEdgeScrollView._internal(
      key: key,
      scrollController: controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      child: child,
    );
  }
  factory FadingEdgeScrollView.fromAnimatedList({
    Key? key,
    required AnimatedList child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
  }) {
    final controller = child.controller;
    if (controller == null) {
      throw Exception("Child must have controller set");
    }

    return FadingEdgeScrollView._internal(
      key: key,
      scrollController: controller,
      scrollDirection: child.scrollDirection,
      reverse: child.reverse,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      child: child,
    );
  }
  factory FadingEdgeScrollView.fromListWheelScrollView({
    Key? key,
    required ListWheelScrollView child,
    double gradientFractionOnStart = 0.1,
    double gradientFractionOnEnd = 0.1,
  }) {
    final controller = child.controller;
    if (controller == null) {
      throw Exception("Child must have controller set");
    }

    return FadingEdgeScrollView._internal(
      key: key,
      scrollController: controller,
      scrollDirection: Axis.vertical,
      reverse: false,
      gradientFractionOnStart: gradientFractionOnStart,
      gradientFractionOnEnd: gradientFractionOnEnd,
      child: child,
    );
  }

  @override
  FadingEdgeScrollViewState createState() => FadingEdgeScrollViewState();
}

class FadingEdgeScrollViewState extends State<FadingEdgeScrollView>
    with WidgetsBindingObserver {
  late ScrollController _controller;
  _ScrollState _scrollState = _ScrollState.notScrollable;
  int lastScrollViewListLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.scrollController;
    _controller.addListener(_updateScrollState);

    WidgetsBinding.instance.addObserver(this);
  }

  bool get _controllerIsReady =>
      _controller.hasClients && _controller.positions.last.hasContentDimensions;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _controller.removeListener(_updateScrollState);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _updateScrollState();
  }

  @override
  Widget build(BuildContext context) => ShaderMask(
        shaderCallback: (bounds) => _createShaderGradient().createShader(
          bounds.shift(Offset(-bounds.left, -bounds.top)),
          textDirection: Directionality.of(context),
        ),
        blendMode: BlendMode.dstIn,
        child: NotificationListener<ScrollMetricsNotification>(
          child: widget.child,
          onNotification: (_) {
            _updateScrollState();
            return false;
          },
        ),
      );

  Gradient _createShaderGradient() => LinearGradient(
        begin: _gradientStart,
        end: _gradientEnd,
        stops: [
          0,
          widget.gradientFractionOnStart * 0.5,
          1 - widget.gradientFractionOnEnd * 0.5,
          1,
        ],
        colors: _getColors(
            widget.gradientFractionOnStart > 0 &&
                _scrollState.isShowGradientAtStart,
            widget.gradientFractionOnEnd > 0 &&
                _scrollState.isShowGradientAtEnd),
      );

  AlignmentGeometry get _gradientStart =>
      widget.scrollDirection == Axis.vertical
          ? _verticalStart
          : _horizontalStart;

  AlignmentGeometry get _gradientEnd =>
      widget.scrollDirection == Axis.vertical ? _verticalEnd : _horizontalEnd;

  Alignment get _verticalStart =>
      widget.reverse ? Alignment.bottomCenter : Alignment.topCenter;

  Alignment get _verticalEnd =>
      widget.reverse ? Alignment.topCenter : Alignment.bottomCenter;

  AlignmentDirectional get _horizontalStart => widget.reverse
      ? AlignmentDirectional.centerEnd
      : AlignmentDirectional.centerStart;

  AlignmentDirectional get _horizontalEnd => widget.reverse
      ? AlignmentDirectional.centerStart
      : AlignmentDirectional.centerEnd;

  List<Color> _getColors(bool showGradientAtStart, bool showGradientAtEnd) => [
        (showGradientAtStart ? Colors.transparent : Colors.white),
        Colors.white,
        Colors.white,
        (showGradientAtEnd ? Colors.transparent : Colors.white)
      ];

  void _updateScrollState() {
    if (!_controllerIsReady) {
      return;
    }

    final offset = _controller.positions.last.pixels;
    final minOffset = _controller.positions.last.minScrollExtent;
    final maxOffset = _controller.positions.last.maxScrollExtent;

    final isScrolledToEnd = offset >= maxOffset;
    final isScrolledToStart = offset <= minOffset;

    final scrollState = () {
      if (isScrolledToStart && isScrolledToEnd) {
        return _ScrollState.notScrollable;
      } else if (isScrolledToStart && !isScrolledToEnd) {
        return _ScrollState.scrollableAtStart;
      } else if (!isScrolledToStart && isScrolledToEnd) {
        return _ScrollState.scrollableAtEnd;
      } else {
        return _ScrollState.scrollableInTheMiddle;
      }
    }();

    if (_scrollState != scrollState) {
      setState(() {
        _scrollState = scrollState;
      });
    }
  }
}

enum _ScrollState {
  notScrollable,
  scrollableAtStart,
  scrollableAtEnd,
  scrollableInTheMiddle;

  bool get isShowGradientAtStart =>
      this == _ScrollState.scrollableAtEnd ||
      this == _ScrollState.scrollableInTheMiddle;

  bool get isShowGradientAtEnd =>
      this == _ScrollState.scrollableAtStart ||
      this == _ScrollState.scrollableInTheMiddle;
}
