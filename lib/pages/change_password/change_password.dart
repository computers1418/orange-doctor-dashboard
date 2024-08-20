import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/text_style.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack(
          //   alignment: Alignment.centerLeft,
          //   children: [
          //     Image.asset(
          //       "lib/pages/admin_login/assets/bg.png",
          //       fit: BoxFit.fill,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 20, left: 40),
          //       child: const Text(
          //         "Admin\nLogin",
          //         style: TextStyle(
          //             fontSize: 40,
          //             fontWeight: FontWeight.w800,
          //             color: Colors.white),
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            width: double.infinity,
            height: 320,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: HexColor("#FF724C"),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: const Text(
                "Change\nPassword",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Change Password",
              style: CustomFonts.poppins20W600(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: HexColor("#FFE8BF"),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            hintText: "Previous Password",
                            hintStyle: CustomFonts.poppins14W500(
                                color: HexColor("#222425")),
                            border: InputBorder.none),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            hintText: "New Password",
                            hintStyle: CustomFonts.poppins14W500(
                                color: HexColor("#222425")),
                            border: InputBorder.none),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            hintText: "Retack New Password",
                            hintStyle: CustomFonts.poppins14W500(
                                color: HexColor("#222425")),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor("#FF724C"),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: CustomFonts.poppins24W700(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
