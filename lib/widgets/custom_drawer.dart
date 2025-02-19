import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import 'package:orange_doctor_dashboard/controllers/city_controller.dart';
import 'package:orange_doctor_dashboard/controllers/home_controller.dart';
import 'package:orange_doctor_dashboard/pages/admin_login/admin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/apk/send/send_apk_view.dart';
import '../pages/create_brand/brand_list.dart';
import '../pages/doctor_details/doctor_create.dart';
import '../pages/invitation/invitation_link/add_invitation_link_view.dart';
import '../pages/send_invititaion/send_invititaion.dart';
import '../pages/specialization/create/create_specialization_view.dart';

class CustomDrawer extends StatefulWidget {
  final scaffoldKey;

  const CustomDrawer({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List options = [
    'Home',
    'Send Invitations',
    'Send APK',
    'Create Specialization',
    'Sub Admin',
    'Recent Activity',
    'Payment',
    'SMS & Voice Call (22)'
  ];

  List icons = [
    'home',
    'invitation',
    'apk',
    'specialization',
    'sub_admin',
    'activity',
    'payment',
    'sms'
  ];
  CityController cityController = Get.put(CityController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
              onTap: () => widget.scaffoldKey.currentState.closeEndDrawer(),
              child: const SizedBox()),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: HexColor("FF724C"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/image.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text(
                    "Admin Name",
                    style: CustomFonts.poppins20W700(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // for (String option in options) const Spacer(),
                Expanded(
                  child: ListView(
                    children: [
                      drawerWidget(
                        "Home",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(0);
                          homeController.addIndex(0);
                        },
                      ),
                      drawerWidget(
                        "Search Doctor",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(1);
                          homeController.addIndex(1);
                        },
                      ),
                      drawerWidget(
                        "Send Invitation",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(2);
                          homeController.addIndex(2);
                        },
                      ),
                      drawerWidget(
                        "Send APK",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(3);
                          homeController.addIndex(3);
                        },
                      ),
                      drawerWidget(
                        "Brand",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(4);
                          homeController.addIndex(4);
                        },
                      ),
                      drawerWidget(
                        "Specialization",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(5);
                          homeController.addIndex(5);
                        },
                      ),
                      drawerWidget(
                        "Invitation Link",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(6);
                          homeController.addIndex(6);
                        },
                      ),
                      drawerWidget(
                        "Professional Communication",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          cityController.changeDrawerIndex(7);
                          homeController.addIndex(7);
                        },
                      ),
                      drawerWidget(
                        "Admin Profile",
                        () {
                          widget.scaffoldKey.currentState.closeEndDrawer();
                          // homeController.addIndex(7);
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences shared =
                        await SharedPreferences.getInstance();
                    shared.setString("login_timestamp", "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminLogin()));
                  },
                  child: Container(
                    height: 42,
                    width: 110,
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'LOGOUT',
                        style: CustomFonts.poppins14W700(
                            color: HexColor("#FF724C")),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget drawerWidget(String text, VoidCallback onTap) {
    return GestureDetector(
      // onTap: () {
      //   widget.scaffoldKey.currentState.closeEndDrawer();
      // },
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.asset(
              "assets/images/icons/${icons[0]}.png",
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: CustomFonts.poppins16W600(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
