import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';
import '../components/delete_file_dialog.dart';

class EditSpecializationView extends StatefulWidget {
  const EditSpecializationView({super.key});

  @override
  State<EditSpecializationView> createState() => _EditSpecializationViewState();
}

class _EditSpecializationViewState extends State<EditSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

  var icons = [
    'icon1.png', 'icon2.png', 'icon3.png', 'icon4.png', 'icon5.png', 'icon1.png'
  ];

  int selected = 0;


  onDeleteClick(){
    showDialog(context: context, builder: (_){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        child: const DeleteFileDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(showback: true, scaffoldKey: scaffoldKey),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit Specialization",
                    style: CustomFonts.poppins20W600(),),
                  const SizedBox(height: 15),
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: HexColor("#FFF7E9"),
                      ),
                      child: Column(
                        children: [
                          
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Specialization", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Text("Dental", style: CustomFonts.poppins12W600(
                                      color: HexColor("#FF222425")
                                    )),
                                    const SizedBox(width: 14,),
                                    CircleAvatar(
                                      radius: 11,
                                      backgroundColor: HexColor("#FF724C"),
                                      child: const Icon(Icons.edit, size: 12, color: Colors.white,),
                                    ),
                                    const Spacer(),
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: HexColor("#E5D7BC"),
                                      child: const Icon(Icons.close, color: Colors.white, size: 16,),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14,),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("No. of Icons Added", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text("06", style: CustomFonts.poppins12W600(
                                  color: HexColor("#FF222425")
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Date", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text("Nov 21, 2024", style: CustomFonts.poppins12W600(
                                  color: HexColor("#FF222425")
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Time", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text("12:37 pm", style: CustomFonts.poppins12W600(
                                  color: HexColor("#FF222425")
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("All Icons", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),



                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6
                            ), 
                            itemCount: 7,
                            itemBuilder: (_, idx){
                              return InkWell(
                                onTap: (){
                                  if(idx!=6){
                                    setState(() {
                                      selected = idx;
                                    });
                                  }
                                },
                                child: Stack(
                                  children: [
                                    
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: selected==idx
                                        ? HexColor("#FF724C")
                                        : Colors.white,
                                      child: idx==6
                                      ? Icon(Icons.add, color: HexColor("#FF724C"),)
                                      : Image.asset('assets/images/icons/${icons[idx]}', color: selected==idx ? Colors.white: HexColor("#FF724C"), width: 24, height: 24,),
                                    ),
                                    Visibility(
                                      visible: selected==idx,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: ()=>onDeleteClick(),
                                          child: CircleAvatar(
                                            radius: 8,
                                            backgroundColor: HexColor("#2A2C41"),
                                            child: const Icon(Icons.close, color: Colors.white, size: 8,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          
                          const SizedBox(height: 24),
                          
                        ],
                      ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}