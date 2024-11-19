import 'package:flutter/foundation.dart';

bool isAndroid() {
  return defaultTargetPlatform == TargetPlatform.android;
}

bool isIOS() {
  return defaultTargetPlatform == TargetPlatform.iOS;
}
