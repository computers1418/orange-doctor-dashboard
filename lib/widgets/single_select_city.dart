import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/models/city_model.dart';
import 'package:orange_doctor_dashboard/controllers/city_controller.dart';

import '../constants/text_style.dart';

class SingleSelectCity extends StatefulWidget {
  final bool invert;
  const SingleSelectCity({
    super.key,
    this.invert = false,
  });

  @override
  State<SingleSelectCity> createState() => _SingleSelectCityState();
}

class _SingleSelectCityState extends State<SingleSelectCity> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  CityModel? selectedValue;
  // List<TextEditingController> _textEditingControllers = [];
  final List<String> _cities = [];
  int _currentEditIndex = -1;
  FocusNode node = FocusNode();

  CityController controller = Get.find();

  @override
  void initState() {
    super.initState();
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
                    borderRadius: BorderRadius.circular(17),
                  ),
                  constraints: const BoxConstraints(maxHeight: 260),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    children: controller.cities.map((item) {
                      int itemIndex = controller.cities.indexOf(item);
                      return StatefulBuilder(builder: (context, setState2) {
                        return GetBuilder(
                            init: CityController(),
                            builder: (controller) {
                              if (controller.rxGetList.value.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.rxGetList.value.isSuccess) {
                                for (var city in controller.cities) {
                                  _cities.add(city.name);
                                }
                              }
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
                                                focusNode: node,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                                onChanged: (value) {
                                                  _cities[itemIndex] = value;
                                                },
                                                initialValue: item.name,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 2,
                                                    horizontal: 10,
                                                  ),
                                                  isDense: true,
                                                  // white round border
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      30,
                                                    ),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                item.name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                      ),
                                      controller.updatingCity == itemIndex
                                          ? const CircularProgressIndicator()
                                          : GestureDetector(
                                              onTap: () async {
                                                if (_currentEditIndex ==
                                                    itemIndex) {
                                                  controller.updatingCity =
                                                      itemIndex;
                                                  await controller
                                                      .updateCityName(
                                                    name: _cities[itemIndex],
                                                    cityId: item.id,
                                                  );
                                                  controller.updatingCity = -1;
                                                }
                                                node.requestFocus();
                                                setState2(() {
                                                  _currentEditIndex =
                                                      _currentEditIndex ==
                                                              itemIndex
                                                          ? -1
                                                          : itemIndex;
                                                  if (_currentEditIndex ==
                                                      itemIndex) {
                                                    _cities[itemIndex] =
                                                        item.name;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: HexColor("#222425"),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    _currentEditIndex ==
                                                            itemIndex
                                                        ? 'Save'
                                                        : "Edit",
                                                    style: CustomFonts
                                                        .poppins8W600(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            });
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
                  selectedValue?.name ?? "View City",
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
