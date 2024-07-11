import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_style.dart';
import '../../../utility/CustomEditText.dart';
import '../../../widgets/custom_appbar.dart';
import '../components/delete_file_dialog.dart';
import '../create/create_specialization_vc.dart';

class EditSpecializationView extends StatefulWidget {
  String  id;
  EditSpecializationView({super.key,required this.id});

  @override
  State<EditSpecializationView> createState() => _EditSpecializationViewState();
}

class _EditSpecializationViewState extends State<EditSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

  final TextEditingController specializationText = TextEditingController();
  final controller = Get.find<CreateSpecializationVC>();
  var icons = [
    'icon1.png', 'icon2.png', 'icon3.png', 'icon4.png', 'icon5.png', 'icon1.png'
  ];

  int selected = 0;
bool tap=true;

  onDeleteClick(){
    showDialog(context: context, builder: (_){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        child: DeleteFileDialog(id:widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final specialization = controller.specilisationDetails;
    specializationText.text=specialization.name.toString()??'';
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(showback: true, scaffoldKey: scaffoldKey),
        GetBuilder(
        init: CreateSpecializationVC(),
    builder: (c) {
          return Expanded(
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
                                flex: !tap ? 2 : 5,
                                child: Text("Specialization", style: CustomFonts.poppins10W600(
                                  color: HexColor("#80222425")
                                )),
                              ),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: !tap,
                                      child: SizedBox(
                                        width:150,
                                        height: 30,
                                        child: CustomTextFormField(controller: specializationText,textFormPaddingVerticle:0,
                                            onChanged: (value) {
                                              // controller
                                              //     .handleConfirmPassword();
                                            },),
                                      ),
                                    ),
                                    Visibility(
                                      visible: tap,
                                      child: Text(specialization.name.toString()?? '', style: CustomFonts.poppins12W600(
                                        color: HexColor("#FF222425")
                                      )),
                                    ),
                                    const SizedBox(width: 14,),
                                    Visibility(
                                      visible: tap,
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            tap=false;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 11,
                                          backgroundColor: HexColor("#FF724C"),
                                          child: const Icon(Icons.edit, size: 12, color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !tap,
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            tap=true;
                                            controller.updateSpecializatonById(widget.id,specializationText.text.toString());
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 11,
                                          backgroundColor: HexColor("#FF724C"),
                                          child: const Icon(Icons.done, size: 12, color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: ()=>onDeleteClick(),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: HexColor("#E5D7BC"),
                                        child: const Icon(Icons.close, color: Colors.white, size: 16,),
                                      ),
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
                                child: specialization.icons ==null ?const SizedBox():Text(specialization.icons!.length.toString(), style: CustomFonts.poppins12W600(
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
                                child:specialization.updatedAt==null?SizedBox(): Text(DateFormat("MMM dd yyyy").format(
                                    DateTime.parse(specialization.updatedAt ?? '')
                                        .toLocal()), style: CustomFonts.poppins12W600(
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
                                child: specialization.updatedAt==null?SizedBox(): Text(DateFormat().add_jms().format(
                                    DateTime.parse(specialization.updatedAt??'')
                                        .toLocal()), style: CustomFonts.poppins12W600(
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
                            itemCount: specialization.icons?.length,
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
                                      child:specialization.icons==null ? SizedBox():Image.network(specialization.icons![idx].url.toString(),),
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
          );})
        ],
      ),
    );
  }
}