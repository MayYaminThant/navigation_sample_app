import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'properties/popup_safearea_props.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuHorizontalPadding = 0.0;
const double _kMenuMinWidth = 2.0 * _kMenuWidthStep;
const double _kMenuVerticalPadding = 0.0;
const double _kMenuWidthStep = 1.0;
const double _kMenuScreenPadding = 0.0;

class _MenuItem extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    Widget? child,
  }) : super(key: key, child: child);

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderShiftedBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
    }
    final BoxParentData childParentData = child!.parentData as BoxParentData;
    childParentData.offset = Offset.zero;
    onLayout(size);
  }
}

class CustomPopupMenuItem<T> extends PopupMenuEntry<T> {
  const CustomPopupMenuItem({
    Key? key,
    this.value,
    this.height = kMinInteractiveDimension,
    this.textStyle,
    required this.child,
  }) : super(key: key);
  final T? value;
  @override
  final double height;
  final TextStyle? textStyle;
  final Widget child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  PopupMenuItemState<T, CustomPopupMenuItem<T>> createState() =>
      PopupMenuItemState<T, CustomPopupMenuItem<T>>();
}

class PopupMenuItemState<T, W extends CustomPopupMenuItem<T>> extends State<W> {
  @protected
  Widget buildChild() => widget.child;
  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle? style = widget.textStyle ??
        popupMenuTheme.textStyle ??
        theme.textTheme.titleMedium;

    Widget item = AnimatedDefaultTextStyle(
      style: style!,
      duration: kThemeChangeDuration,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: widget.height),
        padding:
            const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: buildChild(),
      ),
    );

    return InkWell(
      onTap: null,
      canRequestFocus: false,
      child: item,
    );
  }
}

class _PopupMenu<T> extends StatelessWidget {
  const _PopupMenu({
    Key? key,
    this.route,
    this.semanticLabel,
  }) : super(key: key);

  final _PopupMenuRoute<T>? route;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 / (route!.items.length + 1.5);
    final List<Widget> children = <Widget>[];
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    for (int i = 0; i < route!.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: route!.animation!,
        curve: Interval(start, end),
      );
      Widget item = route!.items[i];
      if (route!.initialValue != null &&
          route!.items[i].represents(route!.initialValue)) {
        item = Container(
          color: Theme.of(context).highlightColor,
          child: item,
        );
      }
      children.add(
        _MenuItem(
          onLayout: (Size size) {
            route!.itemSizes[i] = size;
          },
          child: FadeTransition(
            opacity: opacity,
            child: item,
          ),
        ),
      );
    }

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: Interval(0.0, unit));
    final CurveTween height =
        CurveTween(curve: Interval(0.0, unit * route!.items.length));

    final Widget child = ConstrainedBox(
      constraints: const BoxConstraints(minWidth: _kMenuMinWidth),
      child: IntrinsicWidth(
        stepWidth: _kMenuWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(vertical: _kMenuVerticalPadding),
            child: ListBody(children: children),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: route!.animation!,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: opacity.evaluate(route!.animation!),
          child: Material(
            shape: route!.shape ?? popupMenuTheme.shape,
            color: route!.color ?? popupMenuTheme.color,
            type: MaterialType.card,
            elevation: route!.elevation ?? popupMenuTheme.elevation ?? 8.0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route!.animation!),
              heightFactor: height.evaluate(route!.animation!),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(this.position, this.itemSizes, this.selectedItemIndex,
      this.textDirection);
  final RelativeRect? position;
  List<Size?> itemSizes;
  final int? selectedItemIndex;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest -
            const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0)
        as Size);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = position!.top;
    if (selectedItemIndex != null) {
      double selectedItemOffset = _kMenuVerticalPadding;
      for (int index = 0; index < selectedItemIndex!; index += 1) {
        selectedItemOffset += itemSizes[index]!.height;
      }
      selectedItemOffset += itemSizes[selectedItemIndex!]!.height / 2;
      y = position!.top +
          (size.height - position!.top - position!.bottom) / 2.0 -
          selectedItemOffset;
    }
    late double x;
    if (position!.left > position!.right) {
      x = size.width - position!.right - childSize.width;
    } else if (position!.left < position!.right) {
      x = position!.left;
    } else {
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position!.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position!.left;
          break;
      }
    }

    if (x < _kMenuScreenPadding) {
      x = _kMenuScreenPadding;
    } else if (x + childSize.width > size.width - _kMenuScreenPadding) {
      x = size.width - childSize.width - _kMenuScreenPadding;
    }
    if (y < _kMenuScreenPadding) {
      y = _kMenuScreenPadding;
    } else if (y + childSize.height > size.height - _kMenuScreenPadding) {
      y = size.height - childSize.height - _kMenuScreenPadding;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    assert(itemSizes.length == oldDelegate.itemSizes.length);

    return position != oldDelegate.position ||
        selectedItemIndex != oldDelegate.selectedItemIndex ||
        textDirection != oldDelegate.textDirection ||
        !listEquals(itemSizes, oldDelegate.itemSizes);
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    this.position,
    required this.items,
    this.initialValue,
    this.elevation,
    this.theme,
    this.popupMenuTheme,
    this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
    this.showMenuContext,
    this.captureInheritedThemes,
    this.barrierColor,
    this.popupSafeArea = const PopupSafeAreaProps(),
    this.popupBarrierDismissible = true,
  }) : itemSizes = List<Size?>.filled(items.length, null, growable: false);

  final RelativeRect? position;
  final List<PopupMenuEntry<T>> items;
  final List<Size?> itemSizes;
  final T? initialValue;
  final double? elevation;
  final ThemeData? theme;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final PopupMenuThemeData? popupMenuTheme;
  final BuildContext? showMenuContext;
  final bool? captureInheritedThemes;
  @override
  final Color? barrierColor;
  final PopupSafeAreaProps popupSafeArea;
  final bool popupBarrierDismissible;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => popupBarrierDismissible;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    int? selectedItemIndex;
    if (initialValue != null) {
      for (int index = 0;
          selectedItemIndex == null && index < items.length;
          index += 1) {
        if (items[index].represents(initialValue)) selectedItemIndex = index;
      }
    }

    Widget menu = _PopupMenu<T>(route: this, semanticLabel: semanticLabel);
    if (captureInheritedThemes!) {
      menu = InheritedTheme.captureAll(showMenuContext!, menu);
    } else {
      if (theme != null) menu = Theme(data: theme!, child: menu);
    }

    return SafeArea(
      top: popupSafeArea.top,
      bottom: popupSafeArea.bottom,
      left: popupSafeArea.left,
      right: popupSafeArea.right,
      child: CustomSingleChildLayout(
        delegate: _PopupMenuRouteLayout(
          position,
          itemSizes,
          selectedItemIndex,
          Directionality.of(context),
        ),
        child: menu,
      ),
    );
  }
}

Future<T?> customShowMenu<T>({
  required BuildContext context,
  required RelativeRect position,
  required List<PopupMenuEntry<T>> items,
  T? initialValue,
  double? elevation,
  String? semanticLabel,
  Color? barrierColor,
  ShapeBorder? shape,
  Color? color,
  bool captureInheritedThemes = true,
  bool useRootNavigator = false,
  PopupSafeAreaProps popupSafeArea = const PopupSafeAreaProps(),
  bool barrierDismissible = true,
}) {
  assert(items.isNotEmpty);
  assert(debugCheckHasMaterialLocalizations(context));

  String? label = semanticLabel;
  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      label = semanticLabel ?? MaterialLocalizations.of(context).popupMenuLabel;
  }

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _PopupMenuRoute<T>(
      position: position,
      items: items,
      initialValue: initialValue,
      elevation: elevation,
      semanticLabel: label,
      theme: Theme.of(context),
      popupMenuTheme: PopupMenuTheme.of(context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor,
      shape: shape,
      color: color,
      showMenuContext: context,
      captureInheritedThemes: captureInheritedThemes,
      popupSafeArea: popupSafeArea,
    ),
  );
}
