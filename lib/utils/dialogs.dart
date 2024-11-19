import 'package:flutter/material.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/widgets/dialogs.dart';

void showErrorDialog(
  BuildContext context, {
  VoidCallback? retryAction,
  String? message,
}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => CustomDialog(
      title: AppLocale.of(context)?.error ?? '',
      message: message ?? AppLocale.of(context)?.genericErrorMessage ?? '',
      buttonText: AppLocale.of(context)?.retry,
      backgroundColor: Colors.white,
      onButtonPressed: retryAction,
    ),
  );
}
