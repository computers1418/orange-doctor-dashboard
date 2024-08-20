import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/controllers/apk_controller.dart';
import 'package:orange_doctor_dashboard/models/send_apk_model.dart';
import 'package:orange_doctor_dashboard/pages/apk/components/send_apk_invitationcard.dart';

import '../../../common_methods/delete_dialog.dart';
import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/pagination.dart';
import '../../../widgets/single_select.dart';
import '../../../widgets/single_select2.dart';
import '../../city/components/search_input.dart';

class SendApkView extends StatefulWidget {
  const SendApkView({super.key});

  @override
  State<SendApkView> createState() => _SendApkViewState();
}

class _SendApkViewState extends State<SendApkView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String selectedBrandId = "";
  String selectedSpecializationId = "";
  List<String> dateFilterList = [
    "Last 7 days",
    "Last 15 days",
    "Last 1 month",
    "Last 3 months",
    "Last 6 months",
    "Last 1 year"
  ];

  String selectedAllBrandId = "";
  String selectedAllSpecializationId = "";
  String selectedDateFiltering = "";

  String invitationId = '';
  ApkController apkController = Get.put(ApkController());
  String token = "";

  int currentPage = 0;
  FToast? fToast;
  bool resend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apkController.getBrandsList();
    apkController.getSpecializatonList();
    apkController.getAllSendApkList();
    fToast = FToast();
    fToast!.init(context);
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
        body: Obx(() {
          int totalPages = 1;
          List<SendApkModel> paginatedItems = [];
          if (apkController.sendApkList.isNotEmpty) {
            int totalItems = apkController.sendApkList.length;
            totalPages = (totalItems / 10).ceil();

            int start = currentPage * 10;

            int end = start + 10;
            paginatedItems = apkController.sendApkList
                .sublist(start, end > totalItems ? totalItems : end);
          }
          return Column(children: [
            CustomAppbar(
              showback: true,
              scaffoldKey: scaffoldKey,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                resend ? "Resend APK" : "Send APK",
                                style: CustomFonts.poppins20W600(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: resend
                                      ? HexColor("#FF724C")
                                      : HexColor("#FFE8BF"),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                            hintText: "User Name",
                                            hintStyle:
                                                CustomFonts.poppins14W500(
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: CustomFonts.poppins14W500(
                                            color: resend
                                                ? HexColor("#FFFFFF")
                                                : HexColor("#222425"),
                                          ),
                                          controller: userNameController,
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
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                            hintText: "Password",
                                            hintStyle:
                                                CustomFonts.poppins14W500(
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: CustomFonts.poppins14W500(
                                            color: resend
                                                ? HexColor("#FFFFFF")
                                                : HexColor("#222425"),
                                          ),
                                          controller: passwordController,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: Text(
                                            "8 Character alphanumeric password",
                                            style: CustomFonts.poppins10W600(
                                                color: resend
                                                    ? HexColor("#FFFFFF")
                                                    : HexColor("#FF724C"))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Brand",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: resend
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF222425)),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        selectedItemBuilder: (_) {
                                          return apkController.brands
                                              .map((e) => e.toJson())
                                              .toList()
                                              .map((e) {
                                            return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                e['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: resend
                                                            ? Colors.white
                                                            : null),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        items: apkController.brands
                                            .map((e) => e.toJson())
                                            .toList()
                                            .map((dynamic item) =>
                                                DropdownMenuItem<String>(
                                                  value: item["_id"],
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      if (apkController.brands
                                                              .map((e) =>
                                                                  e.toJson())
                                                              .toList()
                                                              .indexOf(item) <
                                                          apkController.brands
                                                                  .map((e) => e
                                                                      .toJson())
                                                                  .toList()
                                                                  .length -
                                                              1)
                                                        const Divider(
                                                          height: 0,
                                                          color:
                                                              Color(0x33FFFFFF),
                                                        )
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedBrandId.isEmpty
                                            ? null
                                            : selectedBrandId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedBrandId = value!;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 48,
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: resend
                                                ? HexColor("#F7F8FC")
                                                    .withOpacity(0.1)
                                                : Colors.white,
                                          ),
                                        ),
                                        iconStyleData: IconStyleData(
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconSize: 24,
                                          iconEnabledColor: resend
                                              ? Colors.white
                                              : Colors.black,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: const Color(0xEFFF724C),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 10),
                                                    blurRadius: 20,
                                                    color: Color(0x1A000000)),
                                              ]),
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                                MaterialStateProperty.all(6),
                                            thumbVisibility:
                                                MaterialStateProperty.all(true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 42,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Specialization',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: resend
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF222425)),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        selectedItemBuilder: (_) {
                                          return apkController.specializations
                                              .map((e) => e.toJson())
                                              .toList()
                                              .map((e) {
                                            return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                e['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: resend
                                                            ? Colors.white
                                                            : null),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        items: apkController.specializations
                                            .map((e) => e.toJson())
                                            .toList()
                                            .map((dynamic item) =>
                                                DropdownMenuItem<String>(
                                                  value: item["_id"],
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        item['name'],
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      if (apkController
                                                              .specializations
                                                              .map((e) =>
                                                                  e.toJson())
                                                              .toList()
                                                              .indexOf(item) <
                                                          apkController
                                                                  .specializations
                                                                  .map((e) => e
                                                                      .toJson())
                                                                  .toList()
                                                                  .length -
                                                              1)
                                                        const Divider(
                                                          height: 0,
                                                          color:
                                                              Color(0x33FFFFFF),
                                                        )
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedSpecializationId.isEmpty
                                            ? null
                                            : selectedSpecializationId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSpecializationId = value!;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 48,
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: resend
                                                ? HexColor("#F7F8FC")
                                                    .withOpacity(0.1)
                                                : Colors.white,
                                          ),
                                        ),
                                        iconStyleData: IconStyleData(
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconSize: 24,
                                          iconEnabledColor: resend
                                              ? Colors.white
                                              : Colors.black,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: const Color(0xEFFF724C),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 10),
                                                    blurRadius: 20,
                                                    color: Color(0x1A000000)),
                                              ]),
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                                MaterialStateProperty.all(6),
                                            thumbVisibility:
                                                MaterialStateProperty.all(true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 42,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
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
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                hintText: "Doctor Name",
                                                hintStyle:
                                                    CustomFonts.poppins14W500(
                                                  color: resend
                                                      ? HexColor("#FFFFFF")
                                                      : HexColor("#222425"),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              style: CustomFonts.poppins14W500(
                                                color: resend
                                                    ? HexColor("#FFFFFF")
                                                    : HexColor("#222425"),
                                              ),
                                              controller: doctorController,
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: Image.asset(
                                                "assets/images/edit.png",
                                                height: 20,
                                                width: 20,
                                                color: resend
                                                    ? Colors.white
                                                    : null,
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
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: CustomFonts.poppins14W500(
                                            color: resend
                                                ? HexColor("#FFFFFF")
                                                : HexColor("#222425"),
                                          ),
                                          controller: emailController,
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
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: CustomFonts.poppins14W500(
                                            color: resend
                                                ? HexColor("#FFFFFF")
                                                : HexColor("#222425"),
                                          ),
                                          controller: phoneController,
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
                                        color: resend
                                            ? HexColor("#F7F8FC")
                                                .withOpacity(.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: CustomFonts.poppins14W500(
                                            color: resend
                                                ? HexColor("#FFFFFF")
                                                : HexColor("#222425"),
                                          ),
                                          controller: cityController,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (resend) {
                                            apkController.resendApk({
                                              "phone": phoneController.text,
                                              "email": emailController.text,
                                              "name": doctorController.text,
                                              "brandId": selectedBrandId,
                                              "specializationId":
                                                  selectedSpecializationId,
                                              "city": cityController.text,
                                              "invitationId": invitationId,
                                              "token": token
                                            }, context, fToast!).then(
                                              (value) {
                                                resend = false;
                                              },
                                            );
                                          } else {
                                            if (emailController
                                                    .text.isNotEmpty &&
                                                phoneController
                                                    .text.isNotEmpty) {
                                              apkController.sendApk(data: {
                                                "phone": phoneController.text,
                                                "email": emailController.text,
                                                "name": doctorController.text,
                                                "brandId": selectedBrandId,
                                                "specializationId":
                                                    selectedSpecializationId,
                                                "city": cityController.text
                                              }, fToast: fToast!);
                                            } else if (emailController
                                                .text.isEmpty) {
                                              apkController.sendApk(data: {
                                                "phone": phoneController.text,
                                                "name": doctorController.text,
                                                "brandId": selectedBrandId,
                                                "specializationId":
                                                    selectedSpecializationId,
                                                "city": cityController.text
                                              }, fToast: fToast!);
                                            } else {
                                              apkController.sendApk(data: {
                                                "email": emailController.text,
                                                "name": doctorController.text,
                                                "brandId": selectedBrandId,
                                                "specializationId":
                                                    selectedSpecializationId,
                                                "city": cityController.text
                                              }, fToast: fToast!);
                                            }
                                          }
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 37,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              color: resend
                                                  ? HexColor("#FFFFFF")
                                                  : HexColor("#FF724C"),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                resend
                                                    ? "Resend APK"
                                                    : 'Send APK',
                                                style:
                                                    CustomFonts.poppins14W700(
                                                  color: resend
                                                      ? HexColor("#FF724C")
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SingleSelect(
                                      label: "All Brand",
                                      items: apkController.brands
                                          .map((e) => e.toJson())
                                          .toList(),
                                      onTap: (String value) {
                                        setState(() {
                                          selectedAllBrandId = value;
                                        });
                                      },
                                      value: "_id",
                                      invert: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SingleSelect(
                                      label: "All Specialization",
                                      items: apkController.specializations
                                          .map((e) => e.toJson())
                                          .toList(),
                                      onTap: (String value) {
                                        setState(() {
                                          selectedAllSpecializationId = value;
                                        });
                                      },
                                      value: "_id",
                                      invert: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SingleSelect2(
                                      label: "Date Filtering",
                                      items: dateFilterList,
                                      onTap: (value) {
                                        setState(() {
                                          selectedDateFiltering = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      apkController.getAllApkInvitationSearch({
                                        'brandId': selectedAllBrandId,
                                        'specializationId':
                                            selectedAllSpecializationId,
                                        'dateRange': getDateString(
                                            selectedDateFiltering),
                                      });
                                    },
                                    child: Container(
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: HexColor("#FF724C"),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Search",
                                          style: CustomFonts.poppins14W700(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SearchInput(
                                controller: _searchController,
                                onChanged: (value) {
                                  apkController.getAllApkInvitationSearch({
                                    'brandId': selectedAllBrandId,
                                    'specializationId':
                                        selectedAllSpecializationId,
                                    'dateRange':
                                        getDateString(selectedDateFiltering),
                                    'searchElement': value
                                  });
                                },
                              ),
                              apkController.isFetching.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    ))
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "Doctor’s\nInvitation List (${apkController.sendApkList.length})",
                                                  style: CustomFonts
                                                      .poppins20W600(),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: HexColor(
                                                                "#2A2C41")),
                                                        child: Text(
                                                          "Refresh",
                                                          style: CustomFonts
                                                              .poppins10W700(
                                                                  color: HexColor(
                                                                      "#FF724C")),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Pagination(
                                                        pagesLenght:
                                                            totalPages - 1,
                                                        currentPage:
                                                            currentPage,
                                                        callback: callback,
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                              color: HexColor("#FFF7E9"),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            itemCount: paginatedItems.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              SendApkModel data =
                                                  paginatedItems[index];
                                              int originalIndex =
                                                  currentPage * 10 + index;
                                              return SendApkInvitationcard(
                                                index: originalIndex,
                                                model: data,
                                                onResend: () {
                                                  apkController
                                                      .fetchSendApkById(data.id)
                                                      .then(
                                                    (value) {
                                                      setState(() {
                                                        doctorController.text =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .name;
                                                        emailController.text =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .email!;
                                                        phoneController.text =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .phone!;
                                                        cityController.text =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .city;
                                                        selectedBrandId =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .brandId;
                                                        selectedSpecializationId =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .specializationId;
                                                        invitationId =
                                                            apkController
                                                                .sendApkData
                                                                .value
                                                                .id;
                                                        token = apkController
                                                            .sendApkData
                                                            .value
                                                            .invitationUrl
                                                            .split("/")
                                                            .last;
                                                        resend = true;
                                                      });
                                                    },
                                                  );
                                                },
                                                onDelete: () {
                                                  showModalBottomSheet(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return DeleteDialog(
                                                        onTap: () {
                                                          apkController
                                                              .deleteApk(
                                                                  data.id,
                                                                  context,
                                                                  fToast);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                // brandList: doctorController.brands,
                                                // specializationList: doctorController
                                                //     .specializations,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                            ]))))
          ]);
        }));
  }

  String getDateString(value) {
    if (value == "Last 7 days") {
      return "7Days";
    } else if (value == "Last 15 days") {
      return "15Days";
    } else if (value == "Last 1 month") {
      return "1Month";
    } else if (value == "Last 3 months") {
      return "3Months";
    } else if (value == "Last 6 months") {
      return "6Months";
    } else {
      return "1Year";
    }
  }
}
