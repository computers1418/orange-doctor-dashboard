import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFormField extends GetView {
  const CustomTextFormField({
    super.key,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.hintText,
    this.helperText,
    this.topRightRadius = 12,
    this.bottomRightRadius = 12,
    this.topLeftRadius = 12,
    this.bottomLeftRadius = 12,
    this.hintTextSize,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.fillColor,
    this.keyboardType,
    this.isPrefixText = false,
    this.isSuffixText = false,
    this.maxLength,
    this.inputFormatter,
    this.isPasswordVisible = false,
    this.isEnabled,
    this.textFormPaddingVerticle,
    this.fontSize,
    this.initialValue = "",
  });

  final double? fontSize;
  final String initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? isPrefixText;
  final bool? isSuffixText;
  final String? helperText;
  final double topRightRadius;
  final double bottomRightRadius;
  final double? hintTextSize;
  final bool isPassword;
  final bool isPasswordVisible;
  final int? maxLength;
  final bool? isEnabled;
  final double topLeftRadius;
  final double? textFormPaddingVerticle;
  final double bottomLeftRadius;
  final Color? fillColor;
  @override
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength ?? 100,
        style: TextStyle(fontSize: fontSize),
        enabled: isEnabled ?? true,
        inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
        decoration: InputDecoration(
          counterText: '',
          fillColor: fillColor == null ? null : fillColor!.withOpacity(0.5),
          filled: fillColor == null ? false : true,
          focusedBorder: border(context),
          border: border(context),
          enabledBorder: border(context),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          prefixText: isPrefixText == true ? "\$ " : null,
          prefixStyle: isPrefixText == true
              ? TextStyle(color: Colors.black, fontSize: fontSize)
              : null,
          suffixText: isSuffixText == true ? "months" : null,
          suffixStyle: isSuffixText == true
              ? TextStyle(color: Colors.black, fontSize: fontSize)
              : null,

          prefixIconConstraints: prefixIcon != null
              ? const BoxConstraints(maxWidth: 54, maxHeight: 44)
              : null, // Adjust size as needed

          contentPadding: EdgeInsets.symmetric(
              horizontal: 14.0, vertical: textFormPaddingVerticle ?? 12.0),
          hintStyle: inputDecorationTheme.hintStyle != null
              ? inputDecorationTheme.hintStyle!.copyWith(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  fontSize: hintTextSize,
                )
              : TextStyle(
                  fontSize: hintTextSize,
                ),
          helperStyle: inputDecorationTheme.helperStyle?.copyWith(
            letterSpacing: 0,
          ),
        ),
        obscureText: isPassword ? !isPasswordVisible : isPasswordVisible);
  }

  border(context) => OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRightRadius),
          topLeft: Radius.circular(topLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
        ),
        borderSide: Theme.of(context).inputDecorationTheme.border != null
            ? Theme.of(context).inputDecorationTheme.border!.borderSide
            : const BorderSide(color: Colors.grey),
      );
}
