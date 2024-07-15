import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

printC(dynamic value, {Color color = Colors.blue}) {
  if (!kDebugMode) return;
  final colorCode = getColorCode(color);
  debugPrint('$colorCode$value\x1B[0m');
}

getColorCode(Color color) {
  switch (color) {
    case Colors.black:
      return '\x1B[30m';
    case Colors.red:
      return '\x1B[31m';
    case Colors.green:
      return '\x1B[32m';
    case Colors.yellow:
      return '\x1B[33m';
    case Colors.blue:
      return '\x1B[34m';
    case Colors.white:
      return '\x1B[37m';
    default:
      return '\x1B[34m';
  }
}
