import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/controllers/doctor_controller.dart';

import '../../constants/text_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/single_select.dart';

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
  String selectedBrandId = '';
  String selectedSpecializationId = '';
  String selectedCity = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctorController.getBrandsList();
    doctorController.getSpecializatonList();
    doctorController.getCitiesList("", "");
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
                        primary: true,
                        shrinkWrap: false,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Doctor",
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
                                          });
                                          if (selectedSpecializationId
                                              .isNotEmpty) {
                                            doctorController.getCitiesList(
                                                selectedBrandId,
                                                selectedSpecializationId);
                                          }
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
                                          });
                                          if (selectedBrandId.isNotEmpty) {
                                            doctorController.getCitiesList(
                                                selectedBrandId,
                                                selectedSpecializationId);
                                          }
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
                                      SingleSelect(
                                        label: "View City",
                                        items: doctorController.cities
                                            .map((e) => e.toJson())
                                            .toList(),
                                        onTap: (String value) {
                                          setState(() {
                                            selectedCity = value;
                                          });
                                        },
                                        value: "_id",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
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
                                                'Create Doctor',
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
