import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';

class CreateSpecializationView extends StatefulWidget {
  const CreateSpecializationView({super.key});

  @override
  State<CreateSpecializationView> createState() => _CreateSpecializationViewState();
}

class _CreateSpecializationViewState extends State<CreateSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(showback: false, scaffoldKey: scaffoldKey),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create Specialization",
                    style: CustomFonts.poppins20W600(),),
                  const SizedBox(height: 15),
                  Container(
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
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16
                                    ),
                                    hintText: "Specialization Name",
                                    hintStyle: CustomFonts.poppins14W500(
                                      color: HexColor("#222425")
                                    ),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 0.8
                            ), 
                            itemCount: 4,
                            itemBuilder: (_, idx){
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.add, color: HexColor("#FF724C")),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(idx==3 ? "More":"Add Icon", style: CustomFonts.poppins10W500(),),
                                ],
                              );
                            }),
                          
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("5 Icons Added",
                                style: CustomFonts.poppins14W500()),
                              const SizedBox(width: 20),
                              Container(
                                height: 37,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: HexColor("#FF724C"),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Center(
                                  child: Text('Save',
                                    style: CustomFonts.poppins14W700(
                                  color: Colors.white
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),

                  const SizedBox(height: 40,),

                  Text("List of Specialization",
                    style: CustomFonts.poppins20W600(),),
                  const SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: HexColor("#FFF7E9"),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        for(int index = 0; index < 10; index++)
                          card(index),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget card(index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
           children: [
             Expanded(
              flex: 4,
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No.',
                   style: CustomFonts.poppins10W600(
                     color: HexColor("#222425").withOpacity(.5)
                   ),),
                   Text('${index+1}',
                   style: CustomFonts.poppins12W600(
                     color:  HexColor("#222425")
                   ),),
                ],
               ),
             ),
             Expanded(
              flex: 4,
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Specialization',
                   style: CustomFonts.poppins10W600(
                     color: HexColor("#222425").withOpacity(.5)
                   ),),
                   Text('Dental',
                   style: CustomFonts.poppins12W600(
                     color:  HexColor("#222425")
                   ),),
                ],
               ),
             ),
             Expanded(
              flex: 4,
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No. of Icons Added',
                   style: CustomFonts.poppins10W600(
                     color: HexColor("#222425").withOpacity(.5)
                   ),),
                   Text('04',
                   style: CustomFonts.poppins12W600(
                     color:  HexColor("#222425")
                   ),),
                ],
               ),
             ),
           ],
         ),
        const SizedBox(height: 16,),
        Row(
           children: [
             Expanded(flex: 4,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Date',
                    style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)
                    ),),
                    Text('Nov 21, 2024',
                    style: CustomFonts.poppins12W600(
                      color:  HexColor("#222425")
                    ),),
                 ],
               ),
             ),
             Expanded(flex: 4,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Time',
                    style: CustomFonts.poppins10W600(
                      color: HexColor("#222425").withOpacity(.5)
                    ),),
                    Text('12:37 pm',
                    style: CustomFonts.poppins12W600(
                      color: HexColor("#222425")
                    ),),
                 ],
               ),
             ),
             
             Expanded(flex: 4,
                child: Container(
                  height: 22,
                  margin: const EdgeInsets.only(left: 30),
                  // width: 66,
                  decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(
                    child: Text('View',
                      style: CustomFonts.poppins10W700(
                    color: Colors.white
                    ),),
                  ),
                ),
              )
           ],
         ),
         if(index < 9)
          Divider(color: HexColor("#F8E3BD"),
            height: 32,)
      ],
    );
  }
}