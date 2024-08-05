import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/controllers/doctor_controller.dart';

import '../../constants/text_style.dart';
import '../../models/doctor_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/pagination.dart';
import '../../widgets/single_select.dart';
import '../../widgets/single_select2.dart';
import '../city/components/doctor_info_card.dart';
import '../city/components/filters.dart';
import '../city/components/search_input.dart';

class DoctorCreate extends StatefulWidget {
  const DoctorCreate({super.key});

  @override
  State<DoctorCreate> createState() => _DoctorCreateState();
}

class _DoctorCreateState extends State<DoctorCreate> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DoctorController doctorController = Get.put(DoctorController());
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController emailConteoller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String selectedBrandId = '';
  String selectBrandName = '';
  String selectedSpecializationId = '';
  String selectedSpecializationName = '';
  FToast? fToast;
  int currentPage = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    doctorController.getBrandsList();
    doctorController.getSpecializatonList();
    // if (selectedCityId.isEmpty ||
    //     selectedSpecializationId.isEmpty ||
    //     selectedBrandId.isEmpty) {
    doctorController.getAllDoctorList();
    // } else {
    //   doctorController.getDoctorListByCity({
    //     'cityId': '',
    //     'brandId': '',
    //     'specializationId': '',
    //   });
    // }
  }

  callback(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
      ),
      body: Obx(
        () {
          int totalPages = 1;
          List<DoctorModel> paginatedItems = [];
          if (doctorController.doctorList.isNotEmpty) {
            int totalItems = doctorController.doctorList.length;
            totalPages = (totalItems / 10).ceil();

            int start = currentPage * 10;

            int end = start + 10;
            paginatedItems = doctorController.doctorList
                .sublist(start, end > totalItems ? totalItems : end);
          }
          return doctorController.isFetching.value
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.orange,
                ))
              : Column(
                  children: [
                    CustomAppbar(
                      showback: true,
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: true,
                        shrinkWrap: false,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add Doctor",
                                      style: CustomFonts.poppins20W600(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: HexColor("#FFE8BF"),
                                  ),
                                  child: Column(
                                    children: [
                                      SingleSelect(
                                        label: "Brand",
                                        items: doctorController.brands
                                            .map((e) => e.toJson())
                                            .toList(),
                                        onTap: (String value) {
                                          setState(() {
                                            selectedBrandId = value;
                                            selectBrandName =
                                                doctorController.brands
                                                    .firstWhere(
                                                      (element) =>
                                                          element.id ==
                                                          selectedBrandId,
                                                    )
                                                    .name;
                                          });
                                        },
                                        value: "_id",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SingleSelect(
                                        label: "Specialization",
                                        items: doctorController.specializations
                                            .map((e) => e.toJson())
                                            .toList(),
                                        onTap: (String value) {
                                          setState(() {
                                            selectedSpecializationId = value;
                                            selectedSpecializationName =
                                                doctorController.specializations
                                                    .firstWhere(
                                                      (element) =>
                                                          element.sId ==
                                                          selectedSpecializationId,
                                                    )
                                                    .name!;
                                          });
                                        },
                                        value: "_id",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                  hintText: "Doctor Name",
                                                  hintStyle:
                                                      CustomFonts.poppins14W500(
                                                    color: HexColor("#222425"),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                controller:
                                                    doctorNameController,
                                              ),
                                              Positioned(
                                                right: 0,
                                                child: Image.asset(
                                                  "assets/images/edit.png",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              hintText: "Email ID",
                                              hintStyle:
                                                  CustomFonts.poppins14W500(
                                                color: HexColor("#222425"),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            controller: emailConteoller,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              hintText: "Phone Number",
                                              hintStyle:
                                                  CustomFonts.poppins14W500(
                                                      color:
                                                          HexColor("#222425")),
                                              border: InputBorder.none,
                                            ),
                                            controller: phoneController,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      // SingleSelect(
                                      //   label: "View City",
                                      //   items: doctorController.cities
                                      //       .map((e) => e.toJson())
                                      //       .toList(),
                                      //   onTap: (String value) {
                                      //     setState(() {
                                      //       selectedCityId = value;
                                      //       selectedCityName =
                                      //           doctorController.cities
                                      //               .firstWhere(
                                      //                 (element) =>
                                      //                     element.id ==
                                      //                     selectedCityId,
                                      //               )
                                      //               .name;
                                      //     });
                                      //   },
                                      //   value: "_id",
                                      // ),
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              hintText: "City",
                                              hintStyle:
                                                  CustomFonts.poppins14W500(
                                                      color:
                                                          HexColor("#222425")),
                                              border: InputBorder.none,
                                            ),
                                            controller: cityController,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          doctorController
                                              .creatDoctorList(
                                                  cityController.text.isEmpty
                                                      ? {
                                                          "personalInfo": {
                                                            "name":
                                                                doctorNameController
                                                                    .text,
                                                            "phone":
                                                                phoneController
                                                                    .text,
                                                            "email":
                                                                emailConteoller
                                                                    .text
                                                          },
                                                          "brandId":
                                                              selectedBrandId,
                                                          "brandName":
                                                              selectBrandName,
                                                          "specializationId":
                                                              selectedSpecializationId,
                                                          "specializationName":
                                                              selectedSpecializationName
                                                        }
                                                      : {
                                                          "personalInfo": {
                                                            "name":
                                                                doctorNameController
                                                                    .text,
                                                            "phone":
                                                                phoneController
                                                                    .text,
                                                            "email":
                                                                emailConteoller
                                                                    .text
                                                          },
                                                          "brandId":
                                                              selectedBrandId,
                                                          "brandName":
                                                              selectBrandName,
                                                          "specializationId":
                                                              selectedSpecializationId,
                                                          "specializationName":
                                                              selectedSpecializationName,
                                                          "city": cityController
                                                              .text
                                                        },
                                                  fToast!)
                                              .then(
                                            (value) {
                                              doctorController
                                                  .getAllDoctorList();
                                            },
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 37,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              color: HexColor("#FF724C"),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Add Doctor',
                                                style:
                                                    CustomFonts.poppins14W700(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 140,
                                  child: SingleSelect2(items: [
                                    "All Brands",
                                    "Orange Brand Dental",
                                    "Orange Brand Orthopedics",
                                    "Orange Brand Homeopathy",
                                    "Precilo Brand Dental",
                                    "Precilo Brand Orthopedics1",
                                    "Precilo Brand Orthopedics2",
                                    "Precilo Brand Orthopedics3"
                                  ], label: 'All Brands'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: HexColor("#FF724C"),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Filter",
                                        style: CustomFonts.poppins14W600(
                                            color: Colors.white),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SearchInput(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    doctorController.getDoctorListBySearch(
                                        {"searchElement": value});
                                  },
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      doctorController.getAllDoctorList();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: HexColor("#2A2C41")),
                                      child: Text(
                                        "Refresh",
                                        style: CustomFonts.poppins10W700(
                                            color: HexColor("#FF724C")),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Doctor’s List (${doctorController.doctorList.length.toString()})",
                                        style: CustomFonts.poppins20W600(),
                                      ),
                                    ),
                                    Pagination(
                                      pagesLenght: totalPages - 1,
                                      currentPage: currentPage,
                                      callback: callback,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: HexColor("#FFF7E9"),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    itemCount: paginatedItems.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      DoctorModel data = paginatedItems[index];
                                      int originalIndex =
                                          currentPage * 10 + index;
                                      return DoctorInfoCard(
                                        index: originalIndex,
                                        model: data,
                                        brandList: doctorController.brands,
                                        specializationList:
                                            doctorController.specializations,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
