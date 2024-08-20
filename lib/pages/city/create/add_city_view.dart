import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/common_methods/common_methods.dart';
import 'package:orange_doctor_dashboard/models/doctor_model.dart';
import 'package:orange_doctor_dashboard/pages/city/components/count_info.dart';
import 'package:orange_doctor_dashboard/pages/city/components/doctor_info_card.dart';
import 'package:orange_doctor_dashboard/pages/city/components/filters.dart';
import 'package:orange_doctor_dashboard/pages/city/components/search_input.dart';
import 'package:orange_doctor_dashboard/controllers/city_controller.dart';
import 'package:orange_doctor_dashboard/widgets/single_select_city.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/pagination.dart';
import '../../../widgets/single_select.dart';

class AddCityView extends StatefulWidget {
  const AddCityView({super.key});

  @override
  State<AddCityView> createState() => _AddCityViewState();
}

class _AddCityViewState extends State<AddCityView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPage = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _viewAddCity = true;
  String? selectedBrandId;
  String? selectedSpecializationId;
  String? selectedDoctorId;
  String? selectCityId;
  final TextEditingController _nameController = TextEditingController();
  CityController cityController = Get.put(CityController());
  FToast? fToast;

  @override
  initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    _nameController.addListener(() {
      setState(() {});
    });

    cityController.getBrandsList();
    cityController.getSpecializatonList();
    cityController.getCitiesList("", "");
    if (selectCityId == null ||
        selectedSpecializationId == null ||
        selectedBrandId == null) {
      cityController.getAllDoctorList();
    } else {
      cityController.getDoctorListByCity({
        'cityId': '',
        'brandId': '',
        'specializationId': '',
      });
    }

    fToast = FToast();
    fToast?.init(context);
  }

  callback(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        int totalPages = 1;
        List<DoctorModel> paginatedItems = [];
        if (cityController.doctorList.isNotEmpty) {
          int totalItems = cityController.doctorList.length;
          totalPages = (totalItems / 10).ceil();

          int start = currentPage * 10;

          int end = start + 10;
          paginatedItems = cityController.doctorList
              .sublist(start, end > totalItems ? totalItems : end);
        }
        return cityController.isFetching.value
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.orange,
              ))
            : Column(
                children: [
                  CustomAppbar(showback: true, scaffoldKey: scaffoldKey),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add City",
                                style: CustomFonts.poppins20W600(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _viewAddCity = !_viewAddCity;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: HexColor("#FF724C"),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _viewAddCity ? "Minimize" : "Expand",
                                        style: CustomFonts.poppins14W600(
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        _viewAddCity
                                            ? Icons.keyboard_arrow_up_outlined
                                            : Icons
                                                .keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_viewAddCity) ...[
                            Obx(
                              () {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: HexColor("#FFE8BF"),
                                  ),
                                  child: Column(
                                    children: [
                                      SingleSelect(
                                        label: "Brand",
                                        items: cityController.brands
                                            .map((e) => e.toJson())
                                            .toList(),
                                        onTap: (String value) {
                                          setState(() {
                                            selectedBrandId = value;
                                          });
                                          if (selectedSpecializationId !=
                                              null) {
                                            cityController.getCitiesList(
                                                selectedBrandId!,
                                                selectedSpecializationId!);
                                          }
                                          if (selectCityId == null ||
                                              selectedSpecializationId ==
                                                  null ||
                                              selectedBrandId == null) {
                                            cityController.getAllDoctorList();
                                          } else {
                                            cityController.getDoctorListByCity({
                                              'cityId': selectCityId,
                                              'brandId': selectedBrandId,
                                              'specializationId':
                                                  selectedSpecializationId,
                                            });
                                          }
                                        },
                                        value: "_id",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SingleSelect(
                                        label: "Specialization",
                                        items: cityController.specializations
                                            .map((e) => e.toJson())
                                            .toList(),
                                        onTap: (String value) {
                                          setState(() {
                                            selectedSpecializationId = value;
                                          });
                                          if (selectedBrandId != null) {
                                            cityController.getCitiesList(
                                                selectedBrandId!,
                                                selectedSpecializationId!);
                                          }
                                          if (selectCityId == null ||
                                              selectedSpecializationId ==
                                                  null ||
                                              selectedBrandId == null) {
                                            cityController.getAllDoctorList();
                                          } else {
                                            cityController.getDoctorListByCity({
                                              'cityId': selectCityId,
                                              'brandId': selectedBrandId,
                                              'specializationId':
                                                  selectedSpecializationId,
                                            });
                                          }
                                        },
                                        value: "_id",
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SingleSelectCity(
                                        fToast: fToast!,
                                        onTap: (value) {
                                          setState(() {
                                            selectCityId = value.id;
                                          });
                                          if (selectCityId == null ||
                                              selectedSpecializationId ==
                                                  null ||
                                              selectedBrandId == null) {
                                            cityController.getAllDoctorList();
                                          } else {
                                            cityController.getDoctorListByCity({
                                              'cityId': selectCityId,
                                              'brandId': selectedBrandId,
                                              'specializationId':
                                                  selectedSpecializationId,
                                            });
                                          }
                                        },
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
                                            horizontal: 0,
                                          ),
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ),
                                              hintText: "Add City",
                                              hintStyle:
                                                  CustomFonts.poppins14W500(
                                                color: HexColor("#222425"),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      // SingleSelect(
                                      //   label: "Select Doctor",
                                      //   items: cityController.doctorList.isEmpty
                                      //       ? []
                                      //       : cityController.doctorList
                                      //           .map((e) => e.toJson())
                                      //           .toList(),
                                      //   onTap: (String value) {
                                      //     setState(() {
                                      //       selectedDoctorId = value;
                                      //     });
                                      //     // if (selectedBrandId != null) {
                                      //     //   cityController.getCitiesList(
                                      //     //       selectedBrandId!,
                                      //     //       selectedSpecializationId!);
                                      //     // }
                                      //   },
                                      //   value: "_id",
                                      // ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Select Doctor",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFF222425)),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            selectedItemBuilder: (_) {
                                              return cityController.doctorList
                                                  .map((e) => e.toJson())
                                                  .toList()
                                                  .map((e) {
                                                return Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    e["personalInfo"]['name'] ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            color: HexColor(
                                                                "#222425")),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            items: cityController
                                                    .doctorList.isEmpty
                                                ? []
                                                : cityController.doctorList
                                                    .map((e) => e.toJson())
                                                    .toList()
                                                    .map(
                                                        (dynamic item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  item["_id"],
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  Text(
                                                                    item == null
                                                                        ? ''
                                                                        : (item["personalInfo"]['name'] ??
                                                                            ''),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          12),
                                                                  if (cityController
                                                                          .doctorList
                                                                          .map((e) => e
                                                                              .toJson())
                                                                          .toList()
                                                                          .indexOf(
                                                                              item) <
                                                                      cityController
                                                                              .doctorList
                                                                              .map((e) => e.toJson())
                                                                              .toList()
                                                                              .length -
                                                                          1)
                                                                    const Divider(
                                                                      height: 0,
                                                                      color: Color(
                                                                          0x33FFFFFF),
                                                                    )
                                                                ],
                                                              ),
                                                            ))
                                                    .toList(),
                                            value: selectedDoctorId,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedDoctorId = value;
                                              });
                                              // widget.onTap(value!);
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 48,
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white,
                                              ),
                                            ),
                                            iconStyleData: IconStyleData(
                                              icon: const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                              ),
                                              iconSize: 24,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: 200,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color:
                                                      const Color(0xEFFF724C),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(0, 10),
                                                        blurRadius: 20,
                                                        color:
                                                            Color(0x1A000000)),
                                                  ]),
                                              offset: const Offset(0, 0),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                radius:
                                                    const Radius.circular(40),
                                                thickness:
                                                    MaterialStateProperty.all(
                                                        6),
                                                thumbVisibility:
                                                    MaterialStateProperty.all(
                                                        true),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 42,
                                              padding: EdgeInsets.only(
                                                  left: 14, right: 14),
                                            ),
                                            ap),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: cityController.creatingCity.value
                                            ? const CircularProgressIndicator()
                                            : InkWell(
                                                onTap: () async {
                                                  bool success = await cityController
                                                      .createCity(
                                                          brandId:
                                                              selectedBrandId!,
                                                          specializationId:
                                                              selectedSpecializationId!,
                                                          name: _nameController
                                                              .text
                                                              .trim(),
                                                          fToast: fToast!);
                                                  if (success) {
                                                    _nameController.clear();
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  height: 37,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: HexColor("#FF724C"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Done',
                                                      style: CustomFonts
                                                          .poppins14W700(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                          Filters(
                            viewDoctor: () {
                              cityController.getDoctorListByCity({
                                'cityId': selectCityId,
                                'brandId': selectedBrandId,
                                'specializationId': selectedSpecializationId,
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SearchInput(
                            controller: _searchController,
                            onChanged: (value) {
                              cityController.getDoctorListBySearch(
                                  {"searchElement": value});
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Doctor Details(147)",
                                    style: CustomFonts.poppins20W600(),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Pagination(
                                    pagesLenght: totalPages - 1,
                                    currentPage: currentPage,
                                    callback: callback,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: HexColor("#FFE8E1"),
                                      child: Image.asset(
                                        "assets/images/user.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Patients Treated",
                                            style: CustomFonts.poppins10W500(
                                                color: HexColor("#80222425")),
                                          ),
                                          Text(
                                            "371",
                                            style: CustomFonts.poppins32W800(),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: HexColor("#FFE8E1"),
                                      child: Image.asset(
                                        "assets/images/doctor.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Doctors",
                                            style: CustomFonts.poppins10W500(
                                                color: HexColor("#80222425")),
                                          ),
                                          Text(
                                            cityController.doctorList.length
                                                .toString(),
                                            style: CustomFonts.poppins32W800(),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
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
                                int originalIndex = currentPage * 10 + index;
                                return DoctorInfoCard(
                                  index: originalIndex,
                                  model: data,
                                  brandList: cityController.brands,
                                  specializationList:
                                      cityController.specializations,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
