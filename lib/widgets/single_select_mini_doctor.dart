import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class SingleSelectMiniDoctor extends StatefulWidget {
  final List<String> items;
  final String label;
  final bool invert;
  final double? dropdownWidth;
  const SingleSelectMiniDoctor({super.key, required this.items, required this.label, this.invert = false, this.dropdownWidth});

  @override
  State<SingleSelectMiniDoctor> createState() => _SingleSelectMiniDoctorState();
}

class _SingleSelectMiniDoctorState extends State<SingleSelectMiniDoctor> {

  String? selectedValue;
  List<Map> items = [
    {
      "name": "Default"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
    {
      "name": "Dr. Justin Ross",
      "id": "ID : 123407211",
      "area": "Ramnagar, DL"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.invert ?  HexColor("#FF724C"):  HexColor("#2A2C41"),
                borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.label, textAlign: TextAlign.center, style: CustomFonts.poppins8W600(
                    color: Colors.white
                  )),
                  const SizedBox(width: 6,),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 10,)
                ],
              ),
            ),
            items: items.map((Map item) => DropdownMenuItem<String>(
                  value: item['name'],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12,),
                      Text(
                        item['name'],
                        style: CustomFonts.poppins10W500(
                          color: HexColor("#FFFFFF")
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if(item['id']!=null)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item['id'],
                              style: CustomFonts.poppins6W500(
                                color: HexColor("#FFFFFF")
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              item['area'],
                              style: CustomFonts.poppins6W500(
                                color: HexColor("#FFFFFF")
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                        ],
                      ),
                      const SizedBox(height: 12),
                      if(items.indexOf(item)<items.length-1)
                      const Divider(height: 0, color: Color(0x33FFFFFF),)
                    ],
                  ),
                ))
            .toList(),
            onChanged: (value) {
              
            },
            buttonStyleData: ButtonStyleData(
              width: 100,
              // This is necessary for the ink response to match our customButton radius.
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: widget.dropdownWidth ?? 200,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xEFFF724C),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 10), blurRadius: 20, color: Color(0x1A000000)
                  ),
                ]
              ),
              offset: const Offset(-40, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                minThumbLength: 24,
                trackVisibility: const MaterialStatePropertyAll(true),
                trackColor: MaterialStatePropertyAll(HexColor("#ffffff").withOpacity(0.5)),
                thickness: MaterialStateProperty.all(6),
                thumbColor: const MaterialStatePropertyAll(Colors.white),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 50,
              padding: EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        );
  }
}