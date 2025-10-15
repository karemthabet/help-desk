import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? errorText;
  final bool showErrorBorder;
  final bool showLabel;
  final bool showCounter;
  final bool expands;
  final double? height;
  final double? width;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.borderRadius = 12,
    this.fillColor,
    this.inputFormatters,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorText,
    this.showErrorBorder = true,
    this.showLabel = true,
    this.showCounter = false,
    this.expands = false,
    this.height,
    this.width,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        readOnly: readOnly,
        autofocus: autofocus,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        focusNode: focusNode,
        textAlign: textAlign,
        style: style ?? theme.textTheme.bodyLarge,
        expands: expands,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: showLabel ? label : null,
          hintText: hint,
          hintStyle: hintStyle ??
              theme.inputDecorationTheme.hintStyle?.copyWith(
                color: theme.hintColor.withOpacity(0.5),
              ),
          labelStyle: labelStyle ?? theme.inputDecorationTheme.labelStyle,
          errorText: errorText,
          errorStyle: TextStyle(color: theme.colorScheme.error),
          counterText: showCounter ? null : '',
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: IconTheme(
                    data: IconThemeData(
                      color: theme.hintColor,
                      size: 24,
                    ),
                    child: prefixIcon!,
                  ),
                )
              : null,
          prefixIconConstraints: prefixIconConstraints ??
              BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: IconTheme(
                    data: IconThemeData(
                      color: theme.hintColor,
                      size: 24,
                    ),
                    child: suffixIcon!,
                  ),
                )
              : null,
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          filled: true,
          fillColor: fillColor ??
              (isDark ? theme.colorScheme.surface : theme.colorScheme.surface),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: showErrorBorder ? theme.colorScheme.error : Colors.transparent,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: theme.disabledColor.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
