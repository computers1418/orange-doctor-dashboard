import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';

class SendApkInvitationcard extends StatelessWidget {
  final int index;

  const SendApkInvitationcard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
                            "Precilo",
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
                    "Homeopathy",
                    style: CustomFonts.poppins12W600(
                        color: HexColor("#222425"),
                        decoration: TextDecoration.underline),
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
                  "Nov 21, 2024 at 12:37 PM",
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
                  "Nov 21, 2024 at 12:37 PM",
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
                  "05",
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
                  "Dr. Arnold Nilson",
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
                  "Drnilson89@gmail.com",
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
                'Phone Number',
                style: CustomFonts.poppins10W600(
                    color: HexColor("#222425").withOpacity(.5)),
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "+91 9087654321",
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
                  "Delhi",
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
                    'APK Logged In',
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
            const Expanded(
              flex: 3,
              child: SizedBox(),
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
              child: GestureDetector(
                child: Container(
                  height: 22,
                  // width: 66,
                  decoration: BoxDecoration(
                      color: HexColor("#FF724C"),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Resend(2)',
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
