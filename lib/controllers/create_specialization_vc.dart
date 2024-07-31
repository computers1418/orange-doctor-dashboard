import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';

import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

import '../models/specilization.dart';
import '../models/specilization_detail.dart';
import '../pages/specialization/create/create_specialization_view.dart';
import '../respositories/api_middle_wear_api.dart';

class CreateSpecializationVC extends GetxController {
  RxStatus rxGetList = RxStatus.empty();

  Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10), // 10 seconds
    receiveTimeout: const Duration(seconds: 10), // 10 seconds
  ));
  List<String> pickedPath = [];

  RxList selectedImagesPath = [].obs;
  final ImagePicker picker = ImagePicker();

  void pickFiles() async {
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result?.path.isNotEmpty ?? false) {
      pickedPath.add(result!.path);
    }
  }

  void refresh() {
    rxGetList = RxStatus.success();
  }

  List<Specialization> specializations = [];
  SpecializationDetails specilisationDetails = SpecializationDetails();

  Future getSpecializatonList() async {
    rxGetList = RxStatus.loading();
    update();
    specializations.clear();
    final response =
        await ApiMiddleWear(url: 'specialization/list', data: FormData()).get();
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var specialization in response.data["data"]) {
          specializations.add(Specialization.fromJson(specialization));
        }
        update();
      }
      if (specializations.isEmpty) {
        rxGetList = RxStatus.empty();
        update();
      }
    } else {
      rxGetList = RxStatus.error();
      update();
    }
    update();
  }

  Future deleteSpecializaton(String id, FToast fToast) async {
    rxGetList = RxStatus.loading();
    update();
    final response =
        await ApiMiddleWear(url: 'specialization/delete/$id', data: FormData())
            .delete();
    if (response.statusCode == 200) {
      if (response.data != null) {
        showToast(fToast, response.data["message"], false);
        update();
      }
    } else {
      showToast(fToast, response.data["message"], true);
      rxGetList = RxStatus.error();
      update();
    }
    update();
  }

  Future getSpecializatonById(String id) async {
    rxGetList = RxStatus.loading();
    update();
    final response =
        await ApiMiddleWear(url: 'specialization/details/$id', data: FormData())
            .get();
    if (response.statusCode == 200) {
      print('Stat:${response.data["data"]}');
      if (response.data != null) {
        try {
          specilisationDetails =
              SpecializationDetails.fromJson(response.data["data"]);
        } catch (e) {
          print('error$e');
        }
        update();
      }
    } else {
      rxGetList = RxStatus.error();
      update();
    }
    update();
  }

  Future updateSpecializatonById(String id, updateName, fToast) async {
    FormData formData = FormData.fromMap({
      "name": updateName,
    });
    final response =
        await ApiMiddleWear(url: 'specialization/update/$id', data: formData)
            .post();
    if (response.statusCode == 200) {
      showToast(fToast, response.data["message"], false);
      if (response.data != null) {
        update();
      }
    } else {
      showToast(fToast, response.data["message"], true);
      update();
    }
    update();
  }

  Future deleteSpecializatonIconById(String id, file) async {
    rxGetList = RxStatus.loading();
    update();
    FormData formData = FormData.fromMap({
      "icons": MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });
    final response = await ApiMiddleWear(
            url: 'specialization/delete-icon/$id', data: formData)
        .post();
    if (response.statusCode == 200) {
      if (response.data != null) {
        update();
      }
    } else {
      rxGetList = RxStatus.error();
      update();
    }
    update();
  }

  Future addSpecializatonIconById(String id, file) async {
    rxGetList = RxStatus.loading();
    update();
    FormData formData = FormData.fromMap({
      "icons": MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });
    final response =
        await ApiMiddleWear(url: 'specialization/add-icon/$id', data: formData)
            .post();
    if (response.statusCode == 200) {
      print('Stat:${response.data}');
      if (response.data != null) {
        update();
      }
    } else {
      rxGetList = RxStatus.error();
      update();
    }
    update();
  }

  Future<dynamic> sendSpecializatonList(platformFile) async {
    // File file = File(platformFile.first.path);
    for (var items in platformFile) {
      selectedImagesPath.add(items);
    }
    rxGetList = RxStatus.loading();
    // String path;
    // String extension;
    // List<String> parts;
    // path = platformFile!.path.toString();
    // parts = path.split('.');
    // extension = parts.last;
    update();
    // print('extension:${extension}');
    // print('extension:${file.path.split('/').last}');
    // print('extension:${file.path}');
    // List<Future<MapEntry<String, MultipartFile>>> futures = [];
    FormData formData = FormData.fromMap({
      'name': 'testsds',
    });
    formData.files
        .addAll(await Future.wait(selectedImagesPath.map((imagePath) async {
      return MapEntry(
          "icons",
          await MultipartFile.fromFile(imagePath.path,
              filename: imagePath.name));
    })));
    // for (var imagePath in file) {
    //   futures.add(Future<MapEntry<String, MultipartFile>>(() async {
    //     return MapEntry(
    //       "icons",
    //       await MultipartFile.fromFile(imagePath.path,
    //           filename: imagePath.name),
    //     );
    //   }));
    // }
    // formData.files.addAll(await Future.wait(futures));
    print('formData:${formData.fields.asMap()}');
    try {
      Response response = await dio.post(
        'http://13.127.57.197/api/specialization/create',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          // validateStatus: (status) {
          //   return status! < 500; // Accept responses with status codes less than 500
          // },
        ),
      );
      // final response = await Dio().post(
      //   'http://13.127.57.197/api/specialization/create',
      //   data: formData,
      //   options: Options(headers: {
      //     'Content-Type': 'multipart/form-data'
      //   },),
      // );
      print('Status:${response.statusCode}');
      if (response.statusCode == 200) {
        if (response.data != null) {
          for (var specialization in response.data["data"]) {
            specializations.add(Specialization.fromJson(specialization));
          }
        }
        if (specializations.isEmpty) {
          rxGetList = RxStatus.empty();
          update();
        }
        rxGetList = RxStatus.success();
      } else {
        rxGetList = RxStatus.success();
        update();
      }
      update();
    } catch (e) {
      print('error: $e');
      rxGetList = RxStatus.success();
      update();
    }
  }

  Future<void> uploadImage(BuildContext context, String path, String name,
      String specializationName, fToast) async {
    Dio dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'name': specializationName,
        'icons': await MultipartFile.fromFile(
          path,
          filename: name,
          contentType: new DioMediaType("image", "jpeg"),
        ),
        "createdBy": "668fe0a5f368b564f171e85e",
        "updatedBy": "668fe0a5f368b564f171e85e"
      });
      var response = await dio.post(
        'http://13.127.57.197/api/specialization/create',
        data: formData,
      );
      if (response.statusCode == 200) {
        showToast(fToast, response.data["message"], false);
        Navigator.pop(context);
        getSpecializatonList().then((val) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateSpecializationView()));
        });
      } else {
        showToast(fToast, response.data["message"], true);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error
        showToast(fToast, e.response!.data['message'].toString(), true);
      } else {
        // The request was not sent due to a network issue, timeout, etc.
        showToast(fToast, "An error occurred: ${e.message}", true);
      }
    } catch (e) {
      showToast(fToast, "An unexpected error occurred", true);
    }
  }
}
