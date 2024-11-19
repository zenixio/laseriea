import 'package:flutter/foundation.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher_string.dart';

abstract class ILauncherManager {
  /// A function that try to launch an external url
  Future<bool> launchUrl({required Uri uri});
}

class LauncherManager extends ILauncherManager {
  LauncherManager();

  @override
  Future<bool> launchUrl({required Uri uri}) async {
    try {
      return await url_launcher.launchUrl(
        uri,
        mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      );
    } catch (_) {
      LoggerService.log(tag: 'LauncherManager', message: 'launchUrl Error: $_');
      return false;
    }
  }
}
