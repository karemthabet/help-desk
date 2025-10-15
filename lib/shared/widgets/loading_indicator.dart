import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final bool withBackground;
  final Color? backgroundColor;
  final double backgroundOpacity;
  final bool expand;
  final String? message;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry padding;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final double spacing;

  const LoadingIndicator({
    Key? key,
    this.size = 32.0,
    this.strokeWidth = 3.0,
    this.color,
    this.withBackground = false,
    this.backgroundColor,
    this.backgroundOpacity = 0.6,
    this.expand = false,
    this.message,
    this.messageStyle,
    this.padding = const EdgeInsets.all(16.0),
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.direction = Axis.vertical,
    this.spacing = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? theme.colorScheme.primary,
        ),
      ),
    );

    Widget content = indicator;

    if (message != null) {
      content = direction == Axis.horizontal
          ? Row(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                indicator,
                SizedBox(width: spacing),
                Text(
                  message!,
                  style: messageStyle ?? theme.textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                indicator,
                SizedBox(height: spacing),
                Text(
                  message!,
                  style: messageStyle ?? theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            );
    }

    if (withBackground) {
      content = Container(
        padding: padding,
        decoration: BoxDecoration(
          color: (backgroundColor ?? theme.scaffoldBackgroundColor)
              .withOpacity(backgroundOpacity),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: content,
      );
    } else if (padding != EdgeInsets.zero) {
      content = Padding(
        padding: padding,
        child: content,
      );
    }

    if (expand) {
      return Center(
        child: content,
      );
    }

    return content;
  }

  static Widget small() => const LoadingIndicator(size: 20.0, strokeWidth: 2.0);
  
  static Widget medium() => const LoadingIndicator(size: 32.0, strokeWidth: 3.0);
  
  static Widget large() => const LoadingIndicator(size: 48.0, strokeWidth: 4.0);
  
  static Widget withMessage(String message, {bool withBackground = true}) {
    return LoadingIndicator(
      message: message,
      withBackground: withBackground,
    );
  }
}
