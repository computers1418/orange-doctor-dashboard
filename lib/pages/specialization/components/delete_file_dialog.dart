import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';
import '../../../controllers/create_specialization_vc.dart';
import '../create/create_specialization_view.dart';

class DeleteFileDialog extends StatelessWidget {
  String id;
  FToast fToast;

  DeleteFileDialog({super.key, required this.id, required this.fToast});

  final controller = Get.find<CreateSpecializationVC>();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: HexColor("#FFE8BF"),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40))),
            child: Image.asset("assets/images/delete.png"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
            child: Column(
              children: [
                Text("Delete File", style: CustomFonts.poppins26W800()),
                const SizedBox(height: 6),
                Text("Are you sure you want to delete the specialization?",
                    textAlign: TextAlign.center,
                    style:
                        CustomFonts.poppins12W500(color: HexColor("#606364"))),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.deleteSpecializaton(id, fToast).then((val) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // controller.clearSpecialization();
                          // controller.getSpecializatonList().then((val) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateSpecializationView()));
                        });
                        // });
                      },
                      child: Container(
                        height: 42,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor("#FF724C"),
                        ),
                        child: Center(
                          child: Text(
                            "DELETE",
                            style:
                                CustomFonts.poppins16W600(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 42,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor("#2A2C41"),
                        ),
                        child: Center(
                          child: Text(
                            "CANCEL",
                            style:
                                CustomFonts.poppins16W600(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
