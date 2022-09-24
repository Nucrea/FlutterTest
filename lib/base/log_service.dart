import 'package:flutter/foundation.dart';

class LogService {
  static logError(String msg, {Exception? e}) {
    if (kDebugMode) {
      print(msg);
    }
  }
}