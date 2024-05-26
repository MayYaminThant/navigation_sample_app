part of 'widgets.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: height,
        padding: const EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.paddingAll15:
        return const EdgeInsets.all(15.0);
      case IconButtonPadding.paddingAll3:
        return const EdgeInsets.all(3.0);
      default:
        return const EdgeInsets.all(11.0);
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.fillBluegray10019:
        return AppColors.blueGray10019;
      case IconButtonVariant.outline:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.roundedBorder5:
        return BorderRadius.circular(
          5.00,
        );
      default:
        return BorderRadius.circular(
          10.00,
        );
    }
  }
}

enum IconButtonShape {
  roundedBorder10,
  roundedBorder5,
}

enum IconButtonPadding {
  paddingAll11,
  paddingAll15,
  paddingAll3,
}

enum IconButtonVariant {
  outline,
  fillBluegray10019,
}
