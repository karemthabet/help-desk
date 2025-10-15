import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Color? textColor;
  final double? elevation;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.textColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.colorScheme.primary;
    final textStyle = this.textStyle ??
        theme.textTheme.labelLarge?.copyWith(
          color: isOutlined ? buttonColor : Colors.white,
          fontWeight: FontWeight.w600,
        );

    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: buttonColor,
                side: BorderSide(color: buttonColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: padding,
                elevation: elevation,
              ),
              child: _buildChild(theme, textStyle, buttonColor),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                elevation: elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: padding,
              ),
              child: _buildChild(theme, textStyle, buttonColor),
            ),
    );
  }

  Widget _buildChild(ThemeData theme, TextStyle? textStyle, Color buttonColor) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? buttonColor : Colors.white,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 8)],
        Text(
          text,
          style: textStyle?.copyWith(
            color: textColor ?? (isOutlined ? buttonColor : Colors.white),
          ),
          textAlign: TextAlign.center,
        ),
        if (suffixIcon != null) ...[SizedBox(width: 8), suffixIcon!],
      ],
    );
  }
}
