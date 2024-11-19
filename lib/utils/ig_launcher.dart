import 'package:flutter/foundation.dart';
import 'package:laseriea/config/constants.dart';
import 'package:laseriea/config/urls.dart';
import 'package:laseriea/utils/launcher_manager.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:laseriea/utils/platform_utils.dart';

class IgLauncher {
  final LauncherManager launcherManager;

  IgLauncher({required this.launcherManager});

  final String _url = kIsWeb
      ? Urls.igWebUrl(pageId: igSerieAPageId)
      : isIOS()
          ? Urls.igAppStoreUrl
          : Urls.igGplayUrl;

  Future<void> launch({
    required VoidCallback onFailure,
  }) async {
    try {
      if (kIsWeb) {
        await _launchUrl();
        return;
      }

      final appOpened = await launcherManager.launchUrl(uri: Urls.igAppId());

      if (!appOpened) {
        await _launchUrl();
      }
    } catch (_) {
      LoggerService.log(
          tag: 'IgLauncher', message: 'launch : cannot launch url');

      onFailure();
    }
  }

  Future<void> _launchUrl() async {
    final urlLaunched = await launcherManager.launchUrl(uri: Uri.parse(_url));

    if (!urlLaunched) {
      throw Exception();
    }
  }
}
