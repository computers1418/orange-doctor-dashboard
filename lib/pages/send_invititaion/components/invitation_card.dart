import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../constants/text_style.dart';
import '../../../models/list_invitation_model.dart';

class InvitationCard extends StatelessWidget {
  final int index;
  final ListInvitationModel model;
  final VoidCallback onTap;

  const InvitationCard({
    super.key,
    required this.index,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                    model.brand,
                    style:
                        CustomFonts.poppins10W600(color: HexColor("#FF724C")),
                  ),
                  Text(
                    model.specialization,
                    style: CustomFonts.poppins12W600(
                        color: HexColor("#222425"),
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 16,
              child: Column(
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
                        DateFormat('MMM d, yyyy at h:mm a')
                            .format(model.createdAt),
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Last Updated - ',
                        style: CustomFonts.poppins10W600(
                            color: HexColor("#222425").withOpacity(.5)),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy at h:mm a')
                            .format(model.updatedAt),
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No. of Resent Invitation - ',
                        style: CustomFonts.poppins10W600(
                            color: HexColor("#222425").withOpacity(.5)),
                      ),
                      Text(
                        model.sendCount.toString(),
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                'Doctor Name',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                model.name.isEmpty ? "-" : model.name,
                style: CustomFonts.poppins12W600(color: HexColor("#222425")),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                'Email',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                model.email.isEmpty ? "-" : model.email,
                style: CustomFonts.poppins12W600(color: HexColor("#222425")),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                'Phone Number',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                model.phone.isEmpty ? "-" : model.phone,
                style: CustomFonts.poppins12W600(color: HexColor("#222425")),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                'City',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                model.city.isEmpty ? "-" : model.city,
                style: CustomFonts.poppins12W600(color: HexColor("#222425")),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 7,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Doctor Name',
        //             style: CustomFonts.poppins10W600(
        //                 color: HexColor("#222425").withOpacity(.5)),
        //           ),
        //           Text(
        //             model.name.isEmpty ? "-" : model.name,
        //             style:
        //                 CustomFonts.poppins12W600(color: HexColor("#222425")),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //       flex: 5,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Phone Number',
        //             style: CustomFonts.poppins10W600(
        //                 color: HexColor("#222425").withOpacity(.5)),
        //           ),
        //           Text(
        //             model.phone.isEmpty ? "-" : model.phone,
        //             style:
        //                 CustomFonts.poppins12W600(color: HexColor("#222425")),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 7,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Email',
        //             style: CustomFonts.poppins10W600(
        //                 color: HexColor("#222425").withOpacity(.5)),
        //           ),
        //           Text(
        //             model.email.isEmpty ? "-" : model.email,
        //             style:
        //                 CustomFonts.poppins12W600(color: HexColor("#222425")),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //       flex: 5,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'City',
        //             style: CustomFonts.poppins10W600(
        //                 color: HexColor("#222425").withOpacity(.5)),
        //           ),
        //           Text(
        //             model.city.isEmpty ? "-" : model.city,
        //             style:
        //                 CustomFonts.poppins12W600(color: HexColor("#222425")),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        Row(
          children: [
            if (index == 0)
              Container(
                height: 24,
                // width: 66,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Unregistered',
                    style: CustomFonts.poppins10W700(
                        color: HexColor("#222425").withOpacity(0.7)),
                  ),
                ),
              ),
            if (index == 1 || index == 3)
              Container(
                height: 24,
                // width: 66,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: HexColor("#222425"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Registered',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            if (index == 2)
              Container(
                height: 24,
                // width: 66,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: HexColor("#FFDD4C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Express Registration',
                    style:
                        CustomFonts.poppins10W700(color: HexColor("#6E5900")),
                  ),
                ),
              ),
            if (index == 4)
              Container(
                height: 24,
                // width: 66,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: HexColor("#50CC1D"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Partial Registration',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            if (index == 0 || index == 1 || index == 2)
              Container(
                height: 24,
                // width: 66,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: HexColor("#42BEF3"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Moved to APK Page',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 22,
                  // width: 66,
                  decoration: BoxDecoration(
                      color: HexColor("#FF724C"),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Delete',
                      style: CustomFonts.poppins10W700(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
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
              child: Container(
                height: 22,
                // width: 66,
                decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Send APK',
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
              child: Container(
                height: 22,
                // width: 66,
                decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Resend',
                    style: CustomFonts.poppins10W700(color: Colors.white),
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
