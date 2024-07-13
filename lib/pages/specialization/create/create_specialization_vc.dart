import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_doctor_dashboard/models/specialization.dart';
import 'package:orange_doctor_dashboard/models/specilizationdetail.dart';
import 'package:orange_doctor_dashboard/respositories/specialization_api.dart';

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
    print('response:${response.data}');
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

  Future deleteSpecializaton(String id) async {
    rxGetList = RxStatus.loading();
    update();
    final response =
        await ApiMiddleWear(url: 'specialization/delete/$id', data: FormData())
            .get();
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
      if (response.data != null) {
        // update the name of the specialization
        specilisationDetails.name = updateName;
        for (var specialization in specializations) {
          if (specialization.sId == id) {
            specialization.name = updateName;
          }
        }
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

  Future<dynamic> createSpecialization({
    required List<String> paths,
    required List<String> names,
    required String specilizationName,
  }) async {
    rxGetList = RxStatus.loading();
    update();
    List<MultipartFile> files = [];
    for (var i = 0; i < paths.length; i++) {
      files.add(await MultipartFile.fromFile(paths[i], filename: names[i]));
    }
    var data = FormData.fromMap({
      'icons': files,
      'name': specilizationName,
    });
    try {
      final response = await ApiMiddleWear(
        url: 'specialization/create',
        data: data,
      ).post();
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

  Future<void> uploadImage(
    List<String> path,
    List<String> name, {
    required String specilizationName,
  }) async {
    Dio dio = Dio();
    var headers = {
      'Cookie':
          'connect.sid=s%3ARgk4CF6icDr7rIOuYOTzTstB2ziJJryr.AYXSVarBo1inNaEnSczCkEz6q5p3FZpogjbJs1NfLrY'
    };
    List<MultipartFile> files = [];
    for (var i = 0; i < path.length; i++) {
      print('path:$path');
      files.add(await MultipartFile.fromFile(
        path[i],
        filename: name[i],
      ));
    }
    var data = FormData.fromMap({
      'icons': files,
      'name': specilizationName,
    });

    data.fields.forEach((field) {
      print('Field: ${field.key} = ${field.value}');
    });
    data.files.forEach((file) {
      print('File: ${file.key} = ${file.value.filename}');
    });

    try {
      var response = await dio.request(
        'http://13.127.57.197/api/specialization/create',
        options: Options(
          method: 'POST',
          headers: headers,
          validateStatus: (status) {
            return true;
          },
        ),
        data: data,
      );
      print("Response status: ${response.statusCode} ${response.data}");
    } catch (e) {
      print('Upload error: $e');
    }
  }
}
