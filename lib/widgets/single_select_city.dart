// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// import '../constants/text_style.dart';

// class SingleSelectCity extends StatefulWidget {
//   final List<String> items;
//   final String label;
//   final bool invert;
//   final Function(String, int) onEditName;
//   const SingleSelectCity({
//     super.key,
//     required this.items,
//     required this.label,
//     this.invert = false,
//     required this.onEditName,
//   });

//   @override
//   State<SingleSelectCity> createState() => _SingleSelectCityState();
// }

// class _SingleSelectCityState extends State<SingleSelectCity> {
//   String? selectedValue;
//   final List<TextEditingController> _textEditingControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.items.length; i++) {
//       _textEditingControllers.add(TextEditingController());
//       _textEditingControllers[i].addListener(() {
//         setState(() {});
//       });
//     }
//   }

//   int _currentEditIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 widget.label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: widget.invert ? Colors.white : const Color(0xFF222425),
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         selectedItemBuilder: (_) {
//           return widget.items.map((e) {
//             return Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 e,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(color: widget.invert ? Colors.white : null),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             );
//           }).toList();
//         },
//         items: widget.items.map(
//           (String item) {
//             int itemIndex = widget.items.indexOf(item);
//             return DropdownMenuItem<String>(
//               key: ValueKey(item),
//               value: item,
//               child: StatefulBuilder(builder: (context, setState) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       children: [
//                         StatefulBuilder(
//                           builder: (context, setState2) {
//                             return Expanded(
//                               child: _currentEditIndex == itemIndex
//                                   ? TextFormField(
//                                       controller:
//                                           _textEditingControllers[itemIndex],
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white,
//                                       ),
//                                       autofocus: true,
//                                       decoration: const InputDecoration(
//                                         contentPadding: EdgeInsets.all(0),
//                                         isDense: true,
//                                         border: InputBorder.none,
//                                       ),
//                                     )
//                                   : Text(
//                                       item,
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                             );
//                           },
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if (_currentEditIndex == itemIndex) {
//                               widget.onEditName(
//                                   _textEditingControllers[_currentEditIndex]
//                                       .text,
//                                   itemIndex);
//                             }
//                             setState(() {
//                               _currentEditIndex = _currentEditIndex == itemIndex
//                                   ? -1
//                                   : itemIndex;
//                               if (_currentEditIndex == itemIndex) {
//                                 _textEditingControllers[itemIndex].text = item;
//                               }
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(4),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: HexColor("#222425"),
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 4,
//                                 horizontal: 10,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   _currentEditIndex == itemIndex
//                                       ? 'Save'
//                                       : "Edit",
//                                   style: CustomFonts.poppins8W600(
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     if (widget.items.indexOf(item) < widget.items.length - 1)
//                       const Divider(
//                         height: 0,
//                         color: Color(0x33FFFFFF),
//                       )
//                   ],
//                 );
//               }),
//             );
//           },
//         ).toList(),
//         value: selectedValue,
//         onChanged: (value) {
//           setState(() {
//             selectedValue = value;
//             _currentEditIndex = -1;
//           });
//         },
//         buttonStyleData: ButtonStyleData(
//           height: 48,
//           padding: const EdgeInsets.only(left: 0, right: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: widget.invert
//                 ? HexColor("#F7F8FC").withOpacity(0.1)
//                 : Colors.white,
//           ),
//         ),
//         iconStyleData: IconStyleData(
//           icon: const Icon(
//             Icons.keyboard_arrow_down_outlined,
//           ),
//           iconSize: 24,
//           iconEnabledColor: widget.invert ? Colors.white : Colors.black,
//           iconDisabledColor: Colors.grey,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: const Color(0xEFFF724C),
//             boxShadow: const [
//               BoxShadow(
//                   offset: Offset(0, 10),
//                   blurRadius: 20,
//                   color: Color(0x1A000000)),
//             ],
//           ),
//           offset: const Offset(0, 0),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             minThumbLength: 24,
//             trackVisibility: const MaterialStatePropertyAll(true),
//             trackColor:
//                 MaterialStatePropertyAll(HexColor("#ffffff").withOpacity(0.5)),
//             thickness: MaterialStateProperty.all(6),
//             thumbColor: const MaterialStatePropertyAll(Colors.white),
//             thumbVisibility: MaterialStateProperty.all(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 44,
//           padding: EdgeInsets.only(left: 14, right: 14),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class SingleSelectCity extends StatefulWidget {
  final List<String> items;
  final String label;
  final bool invert;
  final Function(String, int) onEditName;
  const SingleSelectCity({
    super.key,
    required this.items,
    required this.label,
    this.invert = false,
    required this.onEditName,
  });

  @override
  State<SingleSelectCity> createState() => _SingleSelectCityState();
}

class _SingleSelectCityState extends State<SingleSelectCity> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? selectedValue;
  final List<TextEditingController> _textEditingControllers = [];
  int _currentEditIndex = -1;
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      _textEditingControllers.add(TextEditingController());
      _textEditingControllers[i].addListener(() {
        setState(() {});
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(onTap: _removeOverlay),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 10),
              child: Material(
                elevation: 4.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor("#FF724C").withOpacity(0.85),
                      borderRadius: BorderRadius.circular(17)),
                  constraints: const BoxConstraints(maxHeight: 260),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    children: widget.items.map((item) {
                      int itemIndex = widget.items.indexOf(item);
                      return StatefulBuilder(builder: (context, setState2) {
                        return InkWell(
                          onTap: () {
                            setState2(() {
                              selectedValue = item;
                              _currentEditIndex = -1;
                            });
                            setState(() {
                              selectedValue = item;
                              _currentEditIndex = -1;
                            });
                            _removeOverlay();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _currentEditIndex == itemIndex
                                      ? TextFormField(
                                          controller: _textEditingControllers[
                                              itemIndex],
                                          focusNode: node,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 10,
                                            ),
                                            isDense: true,
                                            // white round border
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_currentEditIndex == itemIndex) {
                                      widget.onEditName(
                                        _textEditingControllers[
                                                _currentEditIndex]
                                            .text,
                                        itemIndex,
                                      );
                                    }
                                    node.requestFocus();
                                    setState2(() {
                                      _currentEditIndex =
                                          _currentEditIndex == itemIndex
                                              ? -1
                                              : itemIndex;
                                      if (_currentEditIndex == itemIndex) {
                                        _textEditingControllers[itemIndex]
                                            .text = item;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: HexColor("#222425"),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _currentEditIndex == itemIndex
                                            ? 'Save'
                                            : "Edit",
                                        style: CustomFonts.poppins8W600(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _showOverlay,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 32,
            right: 16,
            top: 12,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue ?? widget.label,
                  style: CustomFonts.poppins14W500(),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
