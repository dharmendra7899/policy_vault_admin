import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AppTextField extends StatelessWidget {
  final Widget? iconData;
  final Widget? leadingIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool readOnly;
  final Color? borderColor;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? counterText;
  final double? fontSize;
  final double radius;
  final double borderWidth;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final String? prefixText;
  final TextStyle? hintStyle;
  final Color? bgColor;
  final Color? textColor;
  final bool? isSearch;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.inputFormatters,

    this.labelText,
    this.isSearch,
    this.iconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.hintText,
    this.onChanged,
    this.hintStyle,
    this.bgColor,
    this.prefixIcon,
    this.leadingIcon,
    this.initialValue,
    this.style = const TextStyle(),
    this.validator,
    this.fontSize = 12,
    this.obscureText = false,
    this.focusNode,
    this.keyBoardType,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderColor,
    this.labelStyle,
    this.maxLength,
    this.prefixText,
    this.counterText,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 15,
    ),
    this.textColor,
    this.radius = 12,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      textCapitalization: textCapitalization,
      enabled: enabled,
      focusNode: focusNode,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      obscureText: obscureText,
      onTap: onTap,
      textAlign: textAlign,
      keyboardType: keyBoardType,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      maxLines: maxLines,
      enableSuggestions: true,
      style: context.textTheme.bodyMedium?.copyWith(
        fontSize: fontSize,
        color: textColor,
      ),

      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        counterText: '',
        prefix: leadingIcon,
        prefixText: prefixText,
        filled: readOnly,
        hintText: hintText,
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          fontSize: 15,
          color: textColor,
        ),
        hintStyle: context.textTheme.labelMedium?.copyWith(
          color: appColors.editTextColor,
        ),
        suffixIcon: iconData,
        labelText: labelText == '' ? null : labelText,
        contentPadding: contentPadding,
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: borderColor ?? appColors.borderColor,
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: borderColor ?? appColors.borderColor,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}
