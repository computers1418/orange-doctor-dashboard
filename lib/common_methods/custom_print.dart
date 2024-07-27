import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

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

showToast(FToast fToast, String text, bool error) {
  return fToast.showToast(
    toastDuration: Duration(seconds: 2),
    child: Container(
      decoration: BoxDecoration(
          color: HexColor("#222425"), borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(top: 11, bottom: 15, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              text,
              style: CustomFonts.poppins10W500(
                  color: error ? HexColor("#FF7171") : HexColor("#71FF7F")),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Image.asset("assets/images/close.png",
              width: 20,
              height: 20,
              color: error ? HexColor("#FF7171") : HexColor("#71FF7F"))
        ],
      ),
    ),
    gravity: ToastGravity.BOTTOM,
  );
}
