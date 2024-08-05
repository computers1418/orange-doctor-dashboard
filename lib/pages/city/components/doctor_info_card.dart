import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:orange_doctor_dashboard/models/doctor_model.dart';

import '../../../constants/text_style.dart';
import '../../../models/brands_model.dart';
import '../../../models/specilization.dart';

class DoctorInfoCard extends StatelessWidget {
  final int index;
  final DoctorModel model;
  final List<BrandsModel> brandList;
  final List<Specialization> specializationList;

  const DoctorInfoCard(
      {super.key,
      required this.index,
      required this.model,
      required this.brandList,
      required this.specializationList});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       children: [
    //         Expanded(
    //           flex: 2,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'No.',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 '${index + 1}',
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 4,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 model.brandId.isEmpty ||
    //                         brandList.indexWhere(
    //                               (element) => element.id == model.brandId,
    //                             ) ==
    //                             -1
    //                     ? "-"
    //                     : brandList
    //                         .firstWhere(
    //                           (element) => element.id == model.brandId,
    //                         )
    //                         .name,
    //                 style:
    //                     CustomFonts.poppins10W600(color: HexColor("#FF724C")),
    //               ),
    //               Text(
    //                 model.specializationId.isEmpty ||
    //                         specializationList.indexWhere(
    //                               (element) =>
    //                                   element.sId == model.specializationId,
    //                             ) ==
    //                             -1
    //                     ? "-"
    //                     : specializationList
    //                             .firstWhere(
    //                               (element) =>
    //                                   element.sId == model.specializationId,
    //                             )
    //                             .name ??
    //                         "",
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'User Name',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 'Arnold21',
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Doctor Name',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 model.personalInfo.name,
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Email',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 model.personalInfo.email,
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Doctor ID',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 model.id,
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'City',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 model.address.city,
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       children: [
    //         Expanded(
    //           flex: 6,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Phone Number',
    //                 style: CustomFonts.poppins10W600(
    //                     color: HexColor("#222425").withOpacity(.5)),
    //               ),
    //               Text(
    //                 model.personalInfo.phone,
    //                 style:
    //                     CustomFonts.poppins12W600(color: HexColor("#222425")),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 6,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   height: 22,
    //                   // width: 66,
    //                   decoration: BoxDecoration(
    //                       color: HexColor("#222425"),
    //                       borderRadius: BorderRadius.circular(30)),
    //                   child: Center(
    //                     child: Text(
    //                       'Live',
    //                       style: CustomFonts.poppins10W700(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   height: 22,
    //                   margin: const EdgeInsets.only(left: 4),
    //                   // width: 66,
    //                   decoration: BoxDecoration(
    //                       color: HexColor("#FF724C"),
    //                       borderRadius: BorderRadius.circular(30)),
    //                   child: Center(
    //                     child: Text(
    //                       'Freeze',
    //                       style: CustomFonts.poppins10W700(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   height: 22,
    //                   margin: const EdgeInsets.only(left: 4),
    //                   // width: 66,
    //                   decoration: BoxDecoration(
    //                       color: HexColor("#FF724C"),
    //                       borderRadius: BorderRadius.circular(30)),
    //                   child: Center(
    //                     child: Text(
    //                       'Profile',
    //                       style: CustomFonts.poppins10W700(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     Divider(
    //       color: HexColor("#F8E3BD"),
    //       height: 32,
    //     )
    //   ],
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No.',
                        style: CustomFonts.poppins10W600(
                            color: HexColor("#222425").withOpacity(.5)),
                      ),
                      Text(
                        '${index + 1}',
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brand',
                          style: CustomFonts.poppins10W600(
                              color: HexColor("#222425").withOpacity(.5)),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            model.brandId.isEmpty ||
                                    brandList.indexWhere(
                                          (element) =>
                                              element.id == model.brandId,
                                        ) ==
                                        -1
                                ? "-"
                                : brandList
                                    .firstWhere(
                                      (element) => element.id == model.brandId,
                                    )
                                    .name,
                            style: CustomFonts.poppins12W600(
                              color: HexColor("#222425"),
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Specialization',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    model.specializationId.isEmpty ||
                            specializationList.indexWhere(
                                  (element) =>
                                      element.sId == model.specializationId,
                                ) ==
                                -1
                        ? "-"
                        : specializationList
                            .firstWhere(
                              (element) =>
                                  element.sId == model.specializationId,
                            )
                            .name!,
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Created - ',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                Text(
                  DateFormat('MMM d, yyyy at h:mm a').format(model.createdAt),
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Last Updated - ',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                Text(
                  DateFormat('MMM d, yyyy at h:mm a').format(model.updatedAt),
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'No. of Resent Invitation - ',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                Text(
                  "",
                  // model.sendCount.toString(),
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'User Name',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.firstName.isEmpty
                      ? "-"
                      : "${model.firstName} ${model.lastName}",
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'Doctor Name',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.personalInfo.name,
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'Phone Number 1',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.personalInfo.phone,
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'Phone Number 2',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.personalInfo.phone,
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'Email',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.personalInfo.email,
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Text(
                'City',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  model.address.city,
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 22,
                // width: 66,
                decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Profile',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                child: Container(
                  height: 22,
                  // width: 66,
                  decoration: BoxDecoration(
                      color: HexColor("#FF724C"),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Freeze',
                      style: CustomFonts.poppins10W700(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        // if (index < 9)
        Divider(
          color: HexColor("#F8E3BD"),
          height: 32,
        )
      ],
    );
  }
}
