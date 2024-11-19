import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class LoggerService {
  static void log({required String tag, required String message}) {
    if (kDebugMode) {
      developer.log("""
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

|$tag| => $message

|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
""");
    }
  }
}
