import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';

class PreviousSchedulesView extends StatefulWidget {
  const PreviousSchedulesView({Key? key}) : super(key: key);

  @override
  State<PreviousSchedulesView> createState() => _PreviousSchedulesViewState();
}

class _PreviousSchedulesViewState extends State<PreviousSchedulesView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  bool isCollapsed = true;
  late double screenWidth, screenHeight;

  int selectedDate = 0;
  int selectedSchedule = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            content(context)
          ],
        ));
  }

  Widget content(context) {
    return Container(
      width: double.infinity,
      color: HexColor("#FF724C"),
      child: Column(
        children: [
          CustomAppbar(
            showback: true, 
            title: Column(
              children: [
                Text("ASO1235SX : Ashley Martin", style: CustomFonts.poppins13W600(
                  color: Colors.white
                ),),
                 Text("+91 9087654321 : ashley123@gmail.com", textAlign: TextAlign.center, style: CustomFonts.poppins13W600(
                  color: Colors.white
                ),),
                 Text("Precilo Dental", style: CustomFonts.poppins13W600(
                  color: Colors.white
                ),),
              ],
            ), 
            scaffoldKey: scaffoldKey,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Text("Previous Schedules",
                            style: CustomFonts.poppins20W600(
                              color: Colors.white
                            ),),
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Container(
                           padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16
                            ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: HexColor("#FFFFFF"),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45),
                              // bottomLeft: Radius.circular(45),
                              // bottomRight: Radius.circular(45),
                            ),
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 8; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 20
                            ),
                            decoration: BoxDecoration(
                                color: HexColor("#FFF7E9"),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "26 Feb, Monday",
                                          style:
                                              CustomFonts.poppins16W700(
                                                  color: HexColor(
                                                      "#6A5633")),
                                        ),
                                        Text(
                                          "10 Appointments scheduled for today",
                                          style: TextStyle(
                                            color: HexColor("#201A3F")
                                                .withOpacity(.4),
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () => setState(() {
                                        if(selectedDate == i){
                                          selectedDate = -1;
                                        }else{
                                          selectedDate = i;
                                        }
                                      }),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: HexColor("#FF724C"),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "schedules ",
                                              style:
                                                  CustomFonts.poppins8W600(
                                                      color: Colors.white),
                                            ),
                                            Icon(selectedDate == i ?
                                              Icons.keyboard_arrow_down : Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 14,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                if(selectedDate == i)
                                const SizedBox(height: 8,),
                                if(selectedDate == i)
                                Row(
                                  children: [
                                    Container(
                                        width: 68,
                                        padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4),
                                        decoration: BoxDecoration(
                                          color: HexColor("#FF724C"),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Morning",
                                            style:
                                                CustomFonts.poppins10W500(
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      Container(
                                        width: 68,
                                        padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Afternoon",
                                            style:
                                                CustomFonts.poppins10W500(
                                                    color: HexColor("#E49356")),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6,),
                                      Container(
                                        width: 68,
                                        padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Evening",
                                            style:
                                                CustomFonts.poppins10W500(
                                                    color: HexColor("#E49356")),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if(selectedDate == i)
                                const SizedBox(
                                  height: 16,
                                ),
                                if(selectedDate == i)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < 8; i++)
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                selectedSchedule = i;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 24,
                                                    vertical: 16),
                                                // height: 110,
                                                decoration: BoxDecoration(
                                                  color: selectedSchedule == i ? HexColor("#FF724C"): HexColor("#FFFFFF"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25),
                                                ),
                                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "am",
                                                      style: CustomFonts
                                                          .poppins10W600(
                                                              color: selectedSchedule == i 
                                                              ? Colors.white.withOpacity(0.3)
                                                              : HexColor("#6A5633").withOpacity(.3)),
                                                    ),
                                                     Text(
                                                      "09:00",
                                                      style: CustomFonts
                                                          .poppins14W700(
                                                              color: selectedSchedule == i ? Colors.white: HexColor("#222425")),
                                                    ),
                                                     Text(
                                                      "-",
                                                      style: CustomFonts
                                                          .poppins14W700(
                                                              color: selectedSchedule == i ? Colors.white: HexColor("#222425")),
                                                    ),
                                                     Text(
                                                      "09:30",
                                                      style: CustomFonts
                                                          .poppins14W700(
                                                              color: selectedSchedule == i ? Colors.white: HexColor("#222425")),
                                                    ),
                                                     Text(
                                                      "am",
                                                      style: CustomFonts
                                                          .poppins10W700(
                                                              color: selectedSchedule == i 
                                                              ? Colors.white.withOpacity(0.3)
                                                              : HexColor("#6A5633").withOpacity(.3)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),                                    
                              ],
                            ),
                          ),
                        ),
                            ],
                          ),
                        ),
                      ],
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
