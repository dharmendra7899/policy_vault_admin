import 'package:flutter/material.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';
import 'package:policy_vault_admin/theme/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function()? onPressed;
  final bool isLoading;
  final bool? isBorder;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.color,
    this.textColor,
    this.borderColor,
    this.isBorder,
    this.radius,
    this.height = 50,
    this.fontSize = 16,
    this.borderWidth,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return

      InkWell(
        onTap: isLoading == true ? null : onPressed,
        borderRadius: BorderRadius.circular(radius ?? 12),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? appColors.secondary,

            borderRadius: BorderRadius.circular(radius ?? 12),
            border: Border.all(
              color: borderColor ?? appColors.secondaryLight,
              width: borderWidth??2,
            ),
          ),
          child: Center(
            child:
            isLoading == true
                ? CircularProgressIndicator.adaptive(
              strokeAlign: BorderSide.strokeAlignCenter,
              strokeWidth: 2,
              trackGap: 12,
              strokeCap: StrokeCap.round,
              constraints: BoxConstraints(minHeight: 25, minWidth: 25),
              backgroundColor: appColors.appWhite,
              valueColor: AlwaysStoppedAnimation<Color>(
                appColors.appWhite,
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : SizedBox(),
                icon != null ? SizedBox(width: 6) : SizedBox(),
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: fontSize,
                    color: textColor ?? appColors.appWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class ResetButton extends StatefulWidget {
  final void Function() onPressed;

  const ResetButton({super.key, required this.onPressed});

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: const SelectionContainer.disabled(
        child: Text(
          'Reset',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(0, 0, 0, 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
