import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import 'package:orange_doctor_dashboard/pages/specialization/create/create_specialization_vc.dart';
import 'package:orange_doctor_dashboard/pages/specialization/create/create_specialization_view.dart';
import 'package:orange_doctor_dashboard/pages/specialization/edit/edit_specialization_view.dart';

// ignore: must_be_immutable
class Navigation extends StatelessWidget {
  Navigation({ Key? key }) : super(key: key);
  final CreateSpecializationVC controller = Get.find<CreateSpecializationVC>();
  List popItems = [
    'Edit Profile',
    'Edit Problem',
    'Edit Time',
    'Freeze Account',
    'Delete Account'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
            children: [
              
              InkWell(
                onTap: () {controller.getSpecializatonList().then((val) {Navigator.push(context, MaterialPageRoute(
            builder: (context) => const CreateSpecializationView()));});} ,
                            child: Card(
                  child: Container(width: double.infinity,
                            padding: const EdgeInsets.all(16),
                    child: const Text("Create Specialization")),
                ),
              ),
              // InkWell(
              //   onTap: () => Navigator.push(context, MaterialPageRoute(
              //     builder: (context) =>  EditSpecializationView(id: '',))),
              //               child: Card(
              //     child: Container(width: double.infinity,
              //               padding: const EdgeInsets.all(16),
              //       child: const Text("Edit Specialization")),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  popUp1(context, String type){
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: StatefulBuilder(builder: (context, setState) {
              return SizedBox(height: 430,
              // width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: HexColor("#FFE8BF")
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset("assets/images/popup/${type.toLowerCase()}.png"),
                      )),
                      ),
                    ),
                    Expanded(child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        color: HexColor("#FFFFFF")
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 14,),
                          Text("$type File",
                          style: CustomFonts.poppins24W700(),),
                          const SizedBox(height: 10,),
                          Text("Are you sure you want to\n$type this file?",
                          textAlign: TextAlign.center,
                          style: CustomFonts.poppins12W500(),),
                          const SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(height: 52,
                              width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: HexColor("#FF724C"),
                                ),
                                child: Center(
                                  child: Text(type.toUpperCase(),
                                  style: CustomFonts.poppins16W600(
                                    color: Colors.white
                                  ),),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(height: 52,
                                width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: HexColor("#2A2C41"),
                                  ),
                                  child: Center(
                                    child: Text("CANCEL",
                                    style: CustomFonts.poppins16W600(
                                      color: Colors.white
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            
          );
        });
  }

  popUp3(context){
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: StatefulBuilder(builder: (context, setState) {
              return SizedBox(height: 380,
              width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#FFE8BF")
                      ),
                      child: SizedBox(width: MediaQuery.of(context).size.width,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i = 0; i < popItems.length; i++)
                          SizedBox(width: double.infinity,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(popItems[i],
                                style: CustomFonts.poppins24W600(
                                  color: HexColor("#222425")
                                ),),
                                if(i < popItems.length - 1)
                                Divider(color: HexColor("#E7CD9E"),
                                height: 30,)
                              ],
                            ),
                          )
                          ],
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            
          );
        });
  }


  popUp2(context){
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: StatefulBuilder(builder: (context, setState) {
              return SizedBox(height: 300,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: HexColor("#FFE8BF")
                        ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(int i = 0; i < popItems.length; i++)
                        SizedBox(width: double.infinity,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(popItems[i],
                              style: CustomFonts.poppins24W600(
                                color: HexColor("#222425")
                              ),),
                              if(i < popItems.length - 1)
                              Divider(color: HexColor("#E7CD9E"),)
                            ],
                          ),
                        )

                    ],
                  ),
                ),
              );
            }),
            
          );
        });
  }
}

