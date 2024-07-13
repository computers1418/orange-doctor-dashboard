import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
import '../create/create_specialization_view.dart';

class EditSpecializationView extends StatefulWidget {
  String id;
  EditSpecializationView({super.key, required this.id});

  @override
  State<EditSpecializationView> createState() => _EditSpecializationViewState();
}

class _EditSpecializationViewState extends State<EditSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController specializationText = TextEditingController();
  final controller = Get.find<CreateSpecializationVC>();
  var icons = [
    'icon1.png',
    'icon2.png',
    'icon3.png',
    'icon4.png',
    'icon5.png',
    'icon1.png'
  ];
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile> _paths = [];
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.image;

  final ScrollController _scrollController = ScrollController();

  int selected = 0;
  bool tap = true;

  void _pickFiles() async {
    try {
      _directoryPath = null;
      List<PlatformFile>? _pickedResult = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        lockParentWindow: _lockParentWindow,
      ))!
          .files;
      if (_pickedResult.isNotEmpty) {
        _paths.addAll(_pickedResult);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      }
    } on PlatformException catch (e) {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths.map((e) => e.name).toString();
      _userAborted = _paths == [];
    });
  }

  onDeleteClick() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: DeleteFileDialog(id: widget.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final specialization = controller.specilisationDetails;
    specializationText.text = specialization.name.toString() ?? '';
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
                      Text(
                        "Edit Specialization",
                        style: CustomFonts.poppins20W600(),
                      ),
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
                                  child: Text("Specialization",
                                      style: CustomFonts.poppins10W600(
                                          color: HexColor("#80222425"))),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: !tap,
                                        child: SizedBox(
                                          width: 150,
                                          height: 30,
                                          child: CustomTextFormField(
                                            controller: specializationText,
                                            textFormPaddingVerticle: 0,
                                            onChanged: (value) {
                                              // controller
                                              //     .handleConfirmPassword();
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Visibility(
                                          visible: tap,
                                          child: Text(
                                            specialization.name.toString(),
                                            style: CustomFonts.poppins12W600(
                                              color: HexColor("#FF222425"),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Visibility(
                                        visible: tap,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tap = false;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: CircleAvatar(
                                              radius: 11,
                                              backgroundColor:
                                                  HexColor("#FF724C"),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !tap,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tap = true;
                                              controller
                                                  .updateSpecializatonById(
                                                      widget.id,
                                                      specializationText.text
                                                          .toString())
                                                  .then((val) {
                                                controller
                                                    .getSpecializatonById(
                                                        specialization.sId
                                                            .toString())
                                                    .then((val) {
                                                  setState(() {});
                                                });
                                              });
                                              // controller.updateSpecializatonById(widget.id,specializationText.text.toString());
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: CircleAvatar(
                                              radius: 11,
                                              backgroundColor:
                                                  HexColor("#FF724C"),
                                              child: const Icon(
                                                Icons.done,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          onDeleteClick();
                                        },
                                        child: CircleAvatar(
                                          radius: 11,
                                          backgroundColor: HexColor("#E5D7BC"),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "No. of Icons Added",
                                    style: CustomFonts.poppins10W600(
                                      color: HexColor("#80222425"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: specialization.icons == null
                                      ? const SizedBox()
                                      : Text(
                                          specialization.icons!.length
                                              .toString(),
                                          style: CustomFonts.poppins12W600(
                                            color: HexColor("#FF222425"),
                                          ),
                                        ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text("Date",
                                      style: CustomFonts.poppins10W600(
                                          color: HexColor("#80222425"))),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: specialization.updatedAt == null
                                      ? const SizedBox()
                                      : Text(
                                          DateFormat("MMM dd yyyy").format(
                                              DateTime.parse(specialization
                                                          .updatedAt ??
                                                      '')
                                                  .toLocal()),
                                          style: CustomFonts.poppins12W600(
                                            color: HexColor("#FF222425"),
                                          ),
                                        ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "Time",
                                    style: CustomFonts.poppins10W600(
                                      color: HexColor("#80222425"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: specialization.updatedAt == null
                                      ? SizedBox()
                                      : Text(
                                          DateFormat().add_jms().format(
                                              DateTime.parse(specialization
                                                          .updatedAt ??
                                                      '')
                                                  .toLocal()),
                                          style: CustomFonts.poppins12W600(
                                            color: HexColor("#FF222425"),
                                          ),
                                        ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "All Icons",
                                    style: CustomFonts.poppins10W600(
                                      color: HexColor("#80222425"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  height: 100,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    itemCount: specialization.icons!.length +
                                        _paths.length +
                                        1,
                                    itemBuilder: (_, idx) {
                                      if (idx ==
                                          specialization.icons!.length +
                                              _paths.length) {
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _pickFiles();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          HexColor("#FF724C"),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Add Icon",
                                                  style: CustomFonts
                                                      .poppins12W500(),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: InkWell(
                                              onTap: () {
                                                if (idx !=
                                                    specialization
                                                            .icons!.length +
                                                        _paths.length) {
                                                  setState(() {
                                                    selected = idx;
                                                  });
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: selected ==
                                                            idx
                                                        ? HexColor("#FF724C")
                                                        : Colors.white,
                                                    child: specialization
                                                                .icons ==
                                                            null
                                                        ? const SizedBox()
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: idx <
                                                                    specialization
                                                                        .icons!
                                                                        .length
                                                                ? Image.network(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    specialization
                                                                        .icons![
                                                                            idx]
                                                                        .url
                                                                        .toString(),
                                                                  )
                                                                : Image.file(
                                                                    height: 60,
                                                                    width: 60,
                                                                    File(
                                                                      _paths[idx -
                                                                              specialization.icons!.length]
                                                                          .path
                                                                          .toString(),
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                          ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Visibility(
                                                      visible: selected == idx,
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (idx <
                                                              specialization
                                                                  .icons!
                                                                  .length) {
                                                            // controller
                                                            //     .deleteSpecializatonIconById(
                                                            //   specialization
                                                            //           .sId ??
                                                            //       "",
                                                            //   specialization
                                                            //       .icons![idx]
                                                            //       .sId,
                                                            // );
                                                          } else {
                                                            _paths.removeAt(idx -
                                                                specialization
                                                                    .icons!
                                                                    .length);
                                                            if (selected ==
                                                                idx) {
                                                              setState(() {
                                                                selected = 0;
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 8,
                                                          backgroundColor:
                                                              HexColor(
                                                                  "#2A2C41"),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 8,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            // const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
