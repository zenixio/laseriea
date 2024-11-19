import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:laseriea/utils/app_locale.dart';

// Helper method to encode Uint8List to base64 string
String? tryEncode(Uint8List data) {
  try {
    return base64Encode(data);
  } catch (e) {
    return null;
  }
}

// Helper method to decode base64 string to Uint8List
Uint8List? tryDecode(String? base64String) {
  if (base64String == null) return null;
  try {
    return base64Decode(base64String);
  } catch (e) {
    return null;
  }
}

String toTitleCamelCase(BuildContext context) {
  var camelCaseTitle = '';

  final title = AppLocale.of(context)?.appTitle ?? '';
  for (var i = 0; i < title.length; i++) {
    if (i == 0 || i == 2 || i == 7) {
      camelCaseTitle += title[i].toUpperCase();
    } else {
      camelCaseTitle += title[i];
    }
  }

  return camelCaseTitle;
}
