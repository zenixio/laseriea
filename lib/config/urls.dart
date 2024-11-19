import 'package:laseriea/config/constants.dart';

class Urls {
  static String igWebUrl({required String pageId}) =>
      'https://www.instagram.com/laseriea/';
  static const igGplayUrl =
      'https://play.google.com/store/apps/details?id=com.instagram.android&hl=it';
  static const igAppStoreUrl =
      'https://apps.apple.com/it/app/instagram/id389801252';

  static Uri igAppId() =>
      Uri.parse('instagram://user?username=$igSerieAPageId');

  static const gazzettaFeed =
      'https://www.gazzetta.it/dynamic-feed/rss/section/Calcio/Serie-A.xml';
}
