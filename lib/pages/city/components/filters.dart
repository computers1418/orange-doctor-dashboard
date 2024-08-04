import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/widgets/single_select_appointment.dart';

import '../../../constants/text_style.dart';

class Filters extends StatelessWidget {
  VoidCallback viewDoctor;

  Filters({super.key, required this.viewDoctor});

  @override
  Widget build(BuildContext context) {
    var items = [
      "View Doctor",
      "View Appointment",
      "View Doctor",
      "View Appointment"
    ];

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 15, childAspectRatio: 0.8),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (_, idx) {
          return GestureDetector(
            onTap: idx == 0 ? viewDoctor : () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: HexColor("#2A2C41"),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(items[idx],
                  textAlign: TextAlign.center,
                  style: CustomFonts.poppins8W600(color: Colors.white)),
            ),
          );
        });
  }
}
