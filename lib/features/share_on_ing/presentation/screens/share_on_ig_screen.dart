import 'package:flutter/material.dart';
import 'package:laseriea/main.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/utils/colors.dart';
import 'package:laseriea/utils/dialogs.dart';
import 'package:laseriea/utils/ig_launcher.dart';

class ShareOnIgScreen extends StatelessWidget {
  const ShareOnIgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocale.of(context)?.igOpenButtonDesc ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: AppLocale.of(context)?.pageName ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (getIt.isRegistered<IgLauncher>()) {
              getIt.get<IgLauncher>().launch(
                onFailure: () {
                  showErrorDialog(context);
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Dcolors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          child: Text(
            AppLocale.of(context)?.openIg ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
