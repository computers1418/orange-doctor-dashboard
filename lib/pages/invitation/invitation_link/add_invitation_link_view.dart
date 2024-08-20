import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import 'package:orange_doctor_dashboard/controllers/invitation_controller.dart';
import 'package:orange_doctor_dashboard/widgets/single_select.dart';
import 'package:get/get.dart';
import '../../../common_methods/common_methods.dart';
import '../../../common_methods/delete_dialog.dart';
import '../../../models/invitation_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/pagination.dart';

class AddInvitationLinkView extends StatefulWidget {
  const AddInvitationLinkView({Key? key}) : super(key: key);

  @override
  State<AddInvitationLinkView> createState() => _AddInvitationLinkViewState();
}

class _AddInvitationLinkViewState extends State<AddInvitationLinkView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ic = Get.put(InvitationController());

  final linkController = TextEditingController();

  int currentPage = 0;

  String selectedBrandId = '';
  String selectedSpecializationId = '';
  FToast? fToast;

  callback(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    // ic.getBrands();
    // ic.getSpecialization();
  }

  showSnackbar(data) => CommonMethods.showSnackbar(data, context);

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
            List<InvitationModel> paginatedItems = [];
            if (ic.invitationsList.isNotEmpty) {
              int totalItems = ic.invitationsList.length;
              totalPages = (totalItems / 10).ceil();

              int start = currentPage * 10;

              int end = start + 10;
              paginatedItems = ic.invitationsList
                  .sublist(start, end > totalItems ? totalItems : end);
            }
            return Column(
              children: [
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
                            "Add Invitation Link",
                            style: CustomFonts.poppins20W600(),
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
                                  items:
                                      ic.brands.map((e) => e.toJson()).toList(),
                                  onTap: (String value) {
                                    setState(() {
                                      selectedBrandId = value;
                                    });
                                  },
                                  value: "_id",
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SingleSelect(
                                  label: "Specialization",
                                  items: ic.specializations
                                      .map((e) => e.toJson())
                                      .toList(),
                                  onTap: (String value) {
                                    setState(() {
                                      selectedSpecializationId = value;
                                    });
                                  },
                                  value: "_id",
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 98,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        TextField(
                                          maxLines: 3,
                                          controller: linkController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                            hintText: "Add Link URL",
                                            hintStyle:
                                                CustomFonts.poppins14W500(
                                              color: HexColor("#222425"),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ],
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
                                      ic.addInvitationLink({
                                        'specializationId':
                                            selectedSpecializationId,
                                        'brandId': selectedBrandId,
                                        'link': linkController.text
                                      }, fToast).then((_) {
                                        setState(() {
                                          linkController.text = '';
                                          ic.isDataLoading.value = true;
                                          ic.isDataLoading.value = false;
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 37,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: HexColor("#FF724C"),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: CustomFonts.poppins14W700(
                                              color: Colors.white),
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
                              Container(
                                width: 132,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: HexColor("#222425"),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "All Brands",
                                      style: CustomFonts.poppins14W600(
                                          color: Colors.white),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
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
                          ic.isDataLoading.value
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
                                              "URL List (${ic.invitationsList.length})",
                                              style:
                                                  CustomFonts.poppins20W600(),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: HexColor("#2A2C41"),
                                                  ),
                                                  child: Text(
                                                    "Refresh",
                                                    style: CustomFonts
                                                        .poppins10W700(
                                                      color:
                                                          HexColor("#FF724C"),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                // Pagination(
                                                //   pagesLenght: 10,
                                                //   currentPage: currentPage,
                                                //   callback: callback,
                                                // ),
                                                Pagination(
                                                  pagesLenght: totalPages - 1,
                                                  currentPage: currentPage,
                                                  callback: callback,
                                                ),
                                              ],
                                            ),
                                          ),
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
                                          InvitationModel data =
                                              paginatedItems[index];
                                          int originalIndex =
                                              currentPage * 10 + index;
                                          return card(
                                            originalIndex,
                                            data,
                                            () {
                                              showModalBottomSheet(
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return DeleteDialog(
                                                    onTap: () {
                                                      ic.deleteInvitationLink({
                                                        'specializationId': ic
                                                            .invitationsList[
                                                                index]
                                                            .specializationId,
                                                        'brandId': ic
                                                            .invitationsList[
                                                                index]
                                                            .brandId
                                                            ?.id,
                                                      }, fToast);
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget card(int index, InvitationModel data, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No.',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    '${index + 1}',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ic.invitationsList[index].brandId?.name ?? "Brand Name",
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#FF724C").withOpacity(.5)),
                  ),
                  Text(
                    ic.invitationsList[index].specializationId?.name ??
                        "Specialization Name",
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    DateFormat('dd MMM yy').format(
                      DateTime.parse(ic.invitationsList[index].createdAt ?? ""),
                    ),
                    style: CustomFonts.poppins12W600(
                      color: HexColor("#222425"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    DateFormat('hh:mm a').format(
                      DateTime.parse(
                        ic.invitationsList[index].createdAt ?? "",
                      ),
                    ),
                    style: CustomFonts.poppins12W600(
                      color: HexColor("#222425"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'URL',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    ic.invitationsList[index].link ?? "Link",
                    style: CustomFonts.poppins12W600(
                      color: HexColor("#222425"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 22,
                width: 66,
                decoration: BoxDecoration(
                  color: HexColor("#FF724C"),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Delete',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: HexColor("#F8E3BD"),
          height: 32,
        )
      ],
    );
  }
}
