import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import 'package:orange_doctor_dashboard/controllers/send_invitation_controller.dart';
import 'package:orange_doctor_dashboard/pages/send_invititaion/components/invitation_card.dart';
import 'package:orange_doctor_dashboard/widgets/single_select.dart';
import 'package:orange_doctor_dashboard/widgets/single_select2.dart';
import 'package:orange_doctor_dashboard/widgets/single_select_filter.dart';

import '../../common_methods/common_methods.dart';
import '../../common_methods/delete_dialog.dart';
import '../../models/list_invitation_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/pagination.dart';
import '../city/components/search_input.dart';
import '../invitation/invitation_link/add_invitation_link_view.dart';

class SendInvitation extends StatefulWidget {
  const SendInvitation({Key? key}) : super(key: key);

  @override
  State<SendInvitation> createState() => _SendInvitationState();
}

class _SendInvitationState extends State<SendInvitation> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SendInvitationController sendInvitationController =
      Get.put(SendInvitationController());

  String selectedBrandId = '';
  String invitationId = '';

  // RxString selectedBrandId = ''.obs;

  String selectedSpecializationId = '';
  TextEditingController doctorController = TextEditingController();
  TextEditingController emailConteoller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  bool resend = false;

  int currentPage = 0;

  callback(page) {
    setState(() {
      currentPage = page;
    });
  }

  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  showSnackbar(data) => CommonMethods.showSnackbar(data, context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
      ),
      body: Obx(() {
        int totalPages = 1;
        List<ListInvitationModel> paginatedItems = [];
        if (sendInvitationController.sendInvitationList.isNotEmpty) {
          int totalItems = sendInvitationController.sendInvitationList.length;
          totalPages = (totalItems / 10).ceil();

          int start = currentPage * 10;

          int end = start + 10;
          paginatedItems = sendInvitationController.sendInvitationList
              .sublist(start, end > totalItems ? totalItems : end);
        }
        if (sendInvitationController.isFetching.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          ));
        } else {
          return Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                resend
                                    ? "Resend Invitation"
                                    : "Send Invitation",
                                style: CustomFonts.poppins20W600(),
                              ),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddInvitationLinkView(),
                                    ),
                                  )
                                },
                                child: Container(
                                  height: 32,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FF724C"),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add Invitation Link',
                                      style: CustomFonts.poppins10W600(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                                // SingleSelect(
                                //   label: "Brand",
                                //   items: sendInvitationController.brands
                                //       .map((e) => e.toJson())
                                //       .toList(),
                                //   onTap: (String value) {
                                //     setState(() {
                                //       selectedBrandId.value = value;
                                //     });
                                //   },
                                //   value: "_id",
                                //   selectValue: selectedBrandId.value,
                                // ),
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
                                                    : const Color(0xFF222425)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    selectedItemBuilder: (_) {
                                      return sendInvitationController.brands
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
                                    items: sendInvitationController.brands
                                        .map((e) => e.toJson())
                                        .toList()
                                        .map((dynamic item) =>
                                            DropdownMenuItem<String>(
                                              value: item["_id"],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 12),
                                                  if (sendInvitationController
                                                          .brands
                                                          .map(
                                                              (e) => e.toJson())
                                                          .toList()
                                                          .indexOf(item) <
                                                      sendInvitationController
                                                              .brands
                                                              .map((e) =>
                                                                  e.toJson())
                                                              .toList()
                                                              .length -
                                                          1)
                                                    const Divider(
                                                      height: 0,
                                                      color: Color(0x33FFFFFF),
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
                                        borderRadius: BorderRadius.circular(30),
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
                                      iconEnabledColor:
                                          resend ? Colors.white : Colors.black,
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
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 42,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // SingleSelect(
                                //   label: "Specialization",
                                //   items: sendInvitationController
                                //       .specializations
                                //       .map((e) => e.toJson())
                                //       .toList(),
                                //   onTap: (String value) {
                                //     setState(() {
                                //       selectedSpecializationId = value;
                                //     });
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
                                            'Specialization',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: resend
                                                    ? Colors.white
                                                    : const Color(0xFF222425)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    selectedItemBuilder: (_) {
                                      return sendInvitationController
                                          .specializations
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
                                    items: sendInvitationController
                                        .specializations
                                        .map((e) => e.toJson())
                                        .toList()
                                        .map((dynamic item) =>
                                            DropdownMenuItem<String>(
                                              value: item["_id"],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 12),
                                                  if (sendInvitationController
                                                          .specializations
                                                          .map(
                                                              (e) => e.toJson())
                                                          .toList()
                                                          .indexOf(item) <
                                                      sendInvitationController
                                                              .specializations
                                                              .map((e) =>
                                                                  e.toJson())
                                                              .toList()
                                                              .length -
                                                          1)
                                                    const Divider(
                                                      height: 0,
                                                      color: Color(0x33FFFFFF),
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
                                        borderRadius: BorderRadius.circular(30),
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
                                      iconEnabledColor:
                                          resend ? Colors.white : Colors.black,
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
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 42,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                                        ? HexColor("#F7F8FC").withOpacity(.1)
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
                                            color: resend ? Colors.white : null,
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
                                        ? HexColor("#F7F8FC").withOpacity(.1)
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
                                        hintStyle: CustomFonts.poppins14W500(
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
                                    color: resend
                                        ? HexColor("#F7F8FC").withOpacity(.1)
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
                                        hintStyle: CustomFonts.poppins14W500(
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
                                        ? HexColor("#F7F8FC").withOpacity(.1)
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
                                        hintStyle: CustomFonts.poppins14W500(
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
                                GestureDetector(
                                  onTap: () {
                                    if (resend) {
                                      sendInvitationController
                                          .resendInvitationLink({
                                        'invitationId': invitationId,
                                        'name': doctorController.text,
                                        'phone': phoneController.text,
                                        'email': emailConteoller.text,
                                        'brandId': selectedBrandId,
                                        'specializationId':
                                            selectedSpecializationId,
                                        'city': cityController.text
                                      }, context, fToast).then(
                                        (value) {
                                          setState(() {
                                            resend = false;
                                            doctorController.clear();
                                            phoneController.clear();
                                            emailConteoller.clear();
                                            cityController.clear();
                                            sendInvitationController
                                                .isFetching.value = true;
                                            sendInvitationController
                                                .isFetching.value = false;
                                          });
                                          sendInvitationController
                                              .getListInvitation();
                                        },
                                      );
                                    } else {
                                      sendInvitationController
                                          .sendInvitationLink({
                                        'name': doctorController.text,
                                        'phone': phoneController.text,
                                        'email': emailConteoller.text,
                                        'brandId': selectedBrandId,
                                        'specializationId':
                                            selectedSpecializationId,
                                        'city': cityController.text
                                      }, context, fToast).then(
                                        (value) {
                                          setState(() {
                                            doctorController.clear();
                                            phoneController.clear();
                                            emailConteoller.clear();
                                            cityController.clear();
                                            sendInvitationController
                                                .isFetching.value = true;
                                            sendInvitationController
                                                .isFetching.value = false;
                                          });
                                          sendInvitationController
                                              .getListInvitation();
                                        },
                                      );
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Send Invitation',
                                          style: CustomFonts.poppins14W700(
                                            color: resend
                                                ? HexColor("#FF724C")
                                                : Colors.white,
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
                          const Row(
                            children: [
                              SizedBox(
                                width: 140,
                                child: SingleSelect2(
                                  items: [
                                    "All Brands",
                                    "Orange Brand Dental",
                                    "Orange Brand Orthopedics",
                                    "Orange Brand Homeopathy",
                                    "Precilo Brand Dental",
                                    "Precilo Brand Orthopedics1",
                                    "Precilo Brand Orthopedics2",
                                    "Precilo Brand Orthopedics3"
                                  ],
                                  label: 'All Brands',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SingleSelectFilter()
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SearchInput(
                            controller: _searchController,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  // flex: 4,
                                  child: Text(
                                    "Doctor’s\nInvitation List (${sendInvitationController.sendInvitationList.length})",
                                    style: CustomFonts.poppins20W600(),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: HexColor("#2A2C41"),
                                        ),
                                        child: Text(
                                          "Refresh",
                                          style: CustomFonts.poppins10W700(
                                              color: HexColor("#FF724C")),
                                        ),
                                      ),
                                      onTap: () {
                                        sendInvitationController
                                            .getListInvitation();
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Pagination(
                                      pagesLenght: totalPages - 1,
                                      currentPage: currentPage,
                                      callback: callback,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                                ListInvitationModel data =
                                    paginatedItems[index];
                                int originalIndex = currentPage * 10 + index;
                                return InvitationCard(
                                  index: originalIndex,
                                  model: data,
                                  onTap: () {
                                    showModalBottomSheet(
                                      barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return DeleteDialog(
                                          onTap: () {
                                            sendInvitationController
                                                .deleteInvitationLink(
                                                    {"invitationId": data.id},
                                                    context,
                                                    fToast);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onResend: () {
                                    sendInvitationController
                                        .fetchInvitationById(data.id)
                                        .then(
                                      (value) {
                                        setState(() {
                                          doctorController.text =
                                              sendInvitationController
                                                  .invitationData.value.name;
                                          emailConteoller.text =
                                              sendInvitationController
                                                  .invitationData.value.email;
                                          phoneController.text =
                                              sendInvitationController
                                                  .invitationData.value.phone;
                                          cityController.text =
                                              sendInvitationController
                                                  .invitationData.value.city;
                                          selectedBrandId =
                                              sendInvitationController
                                                  .invitationData.value.brandId;
                                          selectedSpecializationId =
                                              sendInvitationController
                                                  .invitationData
                                                  .value
                                                  .specializationId;
                                          invitationId =
                                              sendInvitationController
                                                  .invitationData.value.id;
                                          resend = true;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
