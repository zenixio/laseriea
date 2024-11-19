import 'package:flutter/material.dart';
import 'package:laseriea/utils/app_locale.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.backgroundColor,
    this.titleStyle,
    this.messageStyle,
    this.buttonTextStyle,
    this.textColor,
    this.titleColor,
    this.borderRadius,
    this.padding,
  });

  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? buttonTextStyle;
  final Color? titleColor;
  final Color? textColor;
  final double? borderRadius;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 16)),
      backgroundColor: backgroundColor ?? Colors.white,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: titleStyle ??
                  Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: titleColor ?? Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: messageStyle ??
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: textColor ?? Colors.grey.shade500,
                      ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onButtonPressed != null)
              ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText ?? AppLocale.of(context)?.close ?? '',
                  style: buttonTextStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
