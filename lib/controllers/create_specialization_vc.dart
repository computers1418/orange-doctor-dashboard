import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common_methods/common_methods.dart';
import '../constants/constants.dart';
import '../models/specilization.dart';
import '../models/specilization_detail.dart';
import '../pages/specialization/create/create_specialization_view.dart';
import '../pages/specialization/edit/edit_specialization_view.dart';
import '../respositories/api_middle_wear_api.dart';
import '../services/api/api.dart';

class CreateSpecializationVC extends GetxController {
  RxStatus rxGetList = RxStatus.empty();
  Api api = Api();
  var isFetching = false.obs;

  List<String> pickedPath = [];

  RxList selectedImagesPath = [].obs;
  final ImagePicker picker = ImagePicker();

  void pickFiles() async {
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result?.path.isNotEmpty ?? false) {
      pickedPath.add(result!.path);
    }
  }

  List<Specialization> specializations = [];
  SpecializationDetails specilisationDetails = SpecializationDetails();

  Future getSpecializatonList() async {
    isFetching.value = true;
    rxGetList = RxStatus.loading();
    specializations = [];
    Map<String, dynamic> resp = {};
    SharedPreferences shared = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${shared.getString("access_token")}'
    };
    var request =
        http.Request('GET', Uri.parse('$baseUrl/api/specialization/list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    resp = await CommonMethods.decodeStreamedResponse(response);
    if (response.statusCode == 200) {
      if (resp["data"] != null) {
        specializations = (resp["data"] as List)
            .map(
                (item) => Specialization.fromJson(item as Map<String, dynamic>))
            .toList();
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
    isFetching.value = false;
    update();
  }

  clearSpecialization() {
    specializations.clear();
    update();
  }

  Future deleteSpecializaton(String id, FToast fToast) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    rxGetList = RxStatus.loading();
    update();
    Response response =
        await api.sendRequest.delete("specialization/delete/$id");
    if (response.statusCode == 200) {
      if (response.data != null) {
        showToast(
            fToast, "Specialization has been deleted successfully.", false);
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
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    rxGetList = RxStatus.loading();
    update();
    Response response = await api.sendRequest.get("specialization/details/$id");
    if (response.statusCode == 200) {
      if (response.data != null) {
        try {
          specilisationDetails =
              SpecializationDetails.fromJson(response.data["data"]);
          update();
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

  Future deleteIconById(
      BuildContext context, String id, String iconId, fToast) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';
    Response response =
        await api.sendRequest.get("specialization/delete-icon/$id/$iconId");
    if (response.statusCode == 200) {
      showToast(fToast, "Icon has been deleted successfully.", false);
      if (response.data != null) {
        update();
      }
    } else {
      showToast(fToast, response.data["message"], true);
      update();
    }
    update();
  }

  Future updateSpecializatonById(String id, updateName, fToast) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';

    Response response =
        await api.sendRequest.post("specialization/update/$id", data: {
      "name": updateName,
    });
    if (response.statusCode == 200) {
      showToast(fToast, "Specialization has been updated successfully.", false);
      // if (response.data != null) {
      //   update();
      // }
    } else {
      showToast(fToast, response.data["message"], true);
      update();
    }
    update();
  }

  Future<void> addIconById(BuildContext context, List<String> paths,
      List<String> name, fToast, String id) async {
    List<MultipartFile> iconFiles = [];
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';

    for (int i = 0; i < paths.length; i++) {
      iconFiles.add(
        await MultipartFile.fromFile(
          paths[i],
          filename: name[i],
          contentType: DioMediaType("image", "jpeg"),
        ),
      );
    }

    try {
      FormData formData = FormData.fromMap({'icons': iconFiles});

      Response response = await api.sendRequest
          .post("specialization/add-icon/$id", data: formData);
      if (response.statusCode == 200) {
        showToast(fToast, "Icons has been added successfully.", false);
        update();
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

  Future<void> uploadImage(BuildContext context, List<String> paths,
      List<String> name, String specializationName, fToast) async {
    List<MultipartFile> iconFiles = [];
    SharedPreferences shared = await SharedPreferences.getInstance();
    api.dio.options.headers['Authorization'] =
        'Bearer ${shared.getString("access_token")}';

    for (int i = 0; i < paths.length; i++) {
      iconFiles.add(
        await MultipartFile.fromFile(
          paths[i],
          filename: name[i],
          contentType: DioMediaType("image", "jpeg"),
        ),
      );
    }

    try {
      FormData formData = FormData.fromMap({
        'name': specializationName,
        'icons': iconFiles,
        "createdBy": "668fe0a5f368b564f171e85e",
        "updatedBy": "668fe0a5f368b564f171e85e"
      });
      Response response =
          await api.sendRequest.post("specialization/create", data: formData);
      if (response.statusCode == 200) {
        showToast(
            fToast, "Specialization has been created successfully.", false);
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
