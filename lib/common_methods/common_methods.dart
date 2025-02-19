import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommonMethods {
  static customSnackBar(title, msg) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(title, msg,
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
          maxWidth: 300,
          margin: const EdgeInsets.all(20),
          colorText: Colors.white);
    }
  }

  static successCustomSnackBar(title, msg) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        msg,
        backgroundColor: Colors.green,
        snackStyle: SnackStyle.FLOATING,
        maxWidth: 300,
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
      );
    }
  }

  static String getValue(String value) {
    if (double.parse(value) == double.parse(value).toInt()) {
      return double.parse(value).toStringAsFixed(0);
    }
    return double.parse(value).toStringAsFixed(2);
  }

  static showSnackbar(text, context, {color, durationInMs}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: durationInMs ?? 3000),
      content: Text(text ?? ''),
      backgroundColor: color,
    ));
  }

  static Map decodeResponse(String response) {
    Map respJson = {};
    try {
      respJson = jsonDecode(response);
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }

  static Future<Map<String, dynamic>> decodeStreamedResponse(
      http.StreamedResponse response) async {
    Map<String, dynamic> respJson = {};
    try {
      respJson = jsonDecode(await response.stream.bytesToString());
      return respJson;
    } catch (e) {
      respJson = {};
      return respJson;
    }
  }

  static String formatDateTime(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }
}

class MapAppOption {
  final String name;
  final String package;

  MapAppOption(this.name, this.package);
}
