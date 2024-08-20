import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:orange_doctor_dashboard/common_methods/custom_print.dart';
import 'package:orange_doctor_dashboard/models/brands_model.dart';
import 'package:orange_doctor_dashboard/models/doctor_model.dart';
import 'package:orange_doctor_dashboard/models/send_apk_model.dart';
import 'package:orange_doctor_dashboard/models/set_problem_model.dart';
import 'package:orange_doctor_dashboard/models/specilization.dart';
import 'package:orange_doctor_dashboard/respositories/api_middle_wear_api.dart';
import 'package:http/http.dart' as http;
import 'package:orange_doctor_dashboard/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../constants/url_const.dart';
import '../models/list_invitation_model.dart';

Future<List<Specialization>> getAllSepcilizations() async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<Specialization> specializations = [];
  try {
    Response response = await api.sendRequest.get("specialization/list");
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var specialization in response.data["data"]) {
          specializations.add(Specialization.fromJson(specialization));
        }
        return specializations;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<SetProblemModel>> getAllSetProblemList() async {
  Api api = Api();
  // SharedPreferences shared = await SharedPreferences.getInstance();
  // api.dio.options.headers['Authorization'] =
  // 'Bearer ${shared.getString("access_token")}';
  List<SetProblemModel> problemList = [];
  try {
    Response response = await api.sendRequest.post("doctor/problem/list");
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var specialization in response.data["data"]) {
          problemList.add(SetProblemModel.fromJson(specialization));
        }
        return problemList;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<BrandsModel>> getAllBrands() async {
  Api api = Api();
  List<BrandsModel> brands = [];
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  try {
    Response response = await api.sendRequest.get(UrlConst.brandList);
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var brand in response.data["data"]) {
          brands.add(BrandsModel.fromJson(brand));
        }
        return brands;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<DoctorModel>> getDoctorByCity(data) async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<DoctorModel> doctors = [];
  try {
    Response response = await api.sendRequest.get("city/doctors", data: data);
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse["data"] != null) {
        for (var brand in jsonResponse["data"]) {
          doctors.add(DoctorModel.fromJson(brand));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<DoctorModel>> getAllDoctorData() async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<DoctorModel> doctors = [];
  try {
    Response response = await api.sendRequest.get("doctor/get");
    if (response.statusCode == 200) {
      // var responseData = await response.stream.bytesToString();
      var jsonResponse = response.data;
      if (jsonResponse["data"] != null) {
        for (var brand in jsonResponse["data"]) {
          doctors.add(DoctorModel.fromJson(brand));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<SendApkModel>> sendApkListData() async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<SendApkModel> doctors = [];

  try {
    Response response = await api.sendRequest.get("doctor/send-apk/list");
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse["data"] != null) {
        for (var brand in jsonResponse["data"]) {
          if (brand["isDeleted"] == false)
            doctors.add(SendApkModel.fromJson(brand));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<SendApkModel>> apkInvitaionSearch(body) async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<SendApkModel> doctors = [];

  try {
    Response response =
        await api.sendRequest.post("subadmin/apkinvitationssearch", data: body);
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse["data"] != null) {
        for (var brand in jsonResponse["data"]) {
          if (brand["isDeleted"] == false)
            doctors.add(SendApkModel.fromJson(brand));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<ListInvitationModel>> invitaionSearch(body) async {
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  List<ListInvitationModel> doctors = [];

  try {
    Response response =
        await api.sendRequest.post("subadmin/invitationssearch", data: body);
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse["data"] != null) {
        for (var brand in jsonResponse["data"]) {
          if (brand["isDeleted"] == false)
            doctors.add(ListInvitationModel(
                id: brand["id"],
                brandName: brand["brand"],
                specializationName: brand["specialization"],
                doctorName: brand["name"],
                email: brand["email"],
                phone: brand["phone"],
                city: brand["city"],
                timeSent: DateTime.parse(brand["createdAt"]),
                timeUpdated: DateTime.parse(brand["updatedAt"])));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}

Future<List<DoctorModel>> getDoctorBySearch(body) async {
  List<DoctorModel> doctors = [];
  Api api = Api();
  SharedPreferences shared = await SharedPreferences.getInstance();
  api.dio.options.headers['Authorization'] =
      'Bearer ${shared.getString("access_token")}';
  try {
    Response response = await api.sendRequest.post("doctor/search", data: body);
    if (response.statusCode == 200) {
      if (response.data["data"] != null) {
        for (var brand in response.data["data"]) {
          doctors.add(DoctorModel.fromJson(brand));
        }
        return doctors;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // Server responded with an error
      print("Dio Error: ${e.response!.data["message"]}");
    } else {
      // Request failed due to network issues
      print("Network Error: ${e.message}");
    }
    return [];
  } catch (e) {
    // Unexpected error
    print("Unexpected Error: $e");
    return [];
  }
}
