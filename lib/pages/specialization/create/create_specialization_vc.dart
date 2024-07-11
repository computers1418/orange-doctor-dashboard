import 'dart:convert';
import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_doctor_dashboard/models/specialization.dart';
import 'package:orange_doctor_dashboard/models/specilizationdetail.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

class CreateSpecializationVC extends GetxController {
  RxStatus rxGetList = RxStatus.empty();

  Dio dio  = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),// 10 seconds
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
    final response =
        await ApiMiddleWear(url: 'specialization/list', data: FormData()).get();
    if (response.statusCode == 200) {
      if (response.data != null) {
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

  Future deleteSpecializaton(String id) async {
    rxGetList = RxStatus.loading();
    update();
    final response =
        await ApiMiddleWear(url: 'specialization/delete/$id', data: FormData())
            .get();
    if (response.statusCode == 200) {
      if (response.data != null) {
        getSpecializatonList();
        update();
      }
    } else {
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

  Future updateSpecializatonById(String id, updateName) async {
    FormData formData = FormData.fromMap({
      "name": updateName,
    });
    final response =
        await ApiMiddleWear(url: 'specialization/update/$id', data: formData)
            .post();
    if (response.statusCode == 200) {
      print('Stat:${response.data}');
      if (response.data != null) {
        update();
      }
    } else {
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

  Future<void> uploadImage(String path,String name) async {
    Dio dio = Dio();
    var headers = {
      'Cookie': 'connect.sid=s%3ARgk4CF6icDr7rIOuYOTzTstB2ziJJryr.AYXSVarBo1inNaEnSczCkEz6q5p3FZpogjbJs1NfLrY'
    };
    var data = FormData.fromMap({
      'files': [
        await MultipartFile.fromFile(path, filename: name)
      ],
      'name': 'test8'
    });


    try {
      var response = await dio.request(
        'http://13.127.57.197/api/specialization/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
    } catch (e) {
      print('Upload error: $e');
    }
  }
}
