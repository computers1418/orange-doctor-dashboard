import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import '../../../controllers/create_specialization_vc.dart';
import '../edit/edit_specialization_view.dart';

Widget specializationCard(index, context) {
  final controller = Get.find<CreateSpecializationVC>();
  final specialization = controller.specializations[index];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            flex: 4,
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
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
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
                  'Specialization',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                Text(
                  specialization.name.toString(),
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
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
                  'No. of Icons Added',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                Text(
                  (specialization.icons?.length ?? 0).toString(),
                  style: CustomFonts.poppins12W600(color: HexColor("#222425")),
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
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)),
                ),
                specialization.updatedAt == null
                    ? Container()
                    : Text(
                        DateFormat("MMM dd yyyy").format(
                            DateTime.parse(specialization.updatedAt!)
                                .toLocal()),
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
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
                specialization.updatedAt == null
                    ? Container()
                    : Text(
                        DateFormat().add_jms().format(
                            DateTime.parse(specialization.updatedAt!)
                                .toLocal()),
                        style: CustomFonts.poppins12W600(
                            color: HexColor("#222425")),
                      ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                controller
                    .getSpecializatonById(specialization.sId.toString())
                    .then((val) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditSpecializationView(
                              id: specialization.sId.toString()))).then(
                    (value) {
                      controller.getSpecializatonList();
                    },
                  );
                });
              },
              child: Container(
                height: 22,
                margin: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'View',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Divider(
        color: HexColor("#F8E3BD"),
        height: 32,
      )
    ],
  );
}
