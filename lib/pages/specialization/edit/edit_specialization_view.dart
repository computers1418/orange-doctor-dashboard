import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_style.dart';
import '../../../controllers/create_specialization_vc.dart';
import '../../../utility/custom_edit_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../components/delete_file_dialog.dart';
import '../create/create_specialization_view.dart';

class EditSpecializationView extends StatefulWidget {
  String id;

  EditSpecializationView({super.key, required this.id});

  @override
  State<EditSpecializationView> createState() => _EditSpecializationViewState();
}

class _EditSpecializationViewState extends State<EditSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateSpecializationVC createSpecializationVC =
      Get.put(CreateSpecializationVC());

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
  FToast? fToast;

  int selected = 0;
  bool tap = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  Future<void> _pickFiles() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
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

  onDeleteClick(fToast) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: DeleteFileDialog(
              id: widget.id,
              fToast: fToast,
            ),
          );
        });
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
                                        Visibility(
                                          visible: tap,
                                          child: Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                specialization.name
                                                        .toString() ??
                                                    '',
                                                style:
                                                    CustomFonts.poppins12W600(
                                                        color: HexColor(
                                                            "#FF222425")),
                                                maxLines: 1,
                                              ),
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
                                                            .toString(),
                                                        fToast)
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
                                            child: CircleAvatar(
                                              radius: 11,
                                              backgroundColor:
                                                  HexColor("#FF724C"),
                                              child: const Icon(
                                                Icons.done,
                                                size: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () => onDeleteClick(fToast),
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                HexColor("#E5D7BC"),
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
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text("No. of Icons Added",
                                        style: CustomFonts.poppins10W600(
                                            color: HexColor("#80222425"))),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: specialization.icons == null
                                        ? const SizedBox()
                                        : Text(
                                            specialization.icons!.length
                                                .toString(),
                                            style: CustomFonts.poppins12W600(
                                                color: HexColor("#FF222425"))),
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
                                        ? SizedBox()
                                        : Text(
                                            DateFormat("MMM dd yyyy").format(
                                                DateTime.parse(specialization
                                                            .updatedAt ??
                                                        '')
                                                    .toLocal()),
                                            style: CustomFonts.poppins12W600(
                                                color: HexColor("#FF222425"))),
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
                                    child: Text("Time",
                                        style: CustomFonts.poppins10W600(
                                            color: HexColor("#80222425"))),
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
                                                color: HexColor("#FF222425"))),
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
                                    child: Text("All Icons",
                                        style: CustomFonts.poppins10W600(
                                            color: HexColor("#80222425"))),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    height: 60,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            specialization.icons!.length + 1,
                                        itemBuilder: (_, idx) {
                                          if (idx ==
                                              specialization.icons!.length) {
                                            return Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    _pickFiles().then(
                                                      (value) {
                                                        if (_paths.isNotEmpty) {
                                                          createSpecializationVC
                                                              .addIconById(
                                                                  context,
                                                                  _paths
                                                                      .map(
                                                                        (e) => e
                                                                            .path!,
                                                                      )
                                                                      .toList(),
                                                                  _paths
                                                                      .map(
                                                                        (e) => e
                                                                            .name,
                                                                      )
                                                                      .toList(),
                                                                  fToast,
                                                                  widget.id)
                                                              .then(
                                                            (value) {
                                                              controller
                                                                  .getSpecializatonById(
                                                                      specialization
                                                                          .sId
                                                                          .toString())
                                                                  .then((val) {
                                                                setState(() {});
                                                              });
                                                            },
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(Icons.add,
                                                          color: HexColor(
                                                              "#FF724C")))),
                                            );
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (idx != 6) {
                                                      setState(() {
                                                        selected = idx;
                                                      });
                                                    }
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            color: selected ==
                                                                    idx
                                                                ? HexColor(
                                                                    "#FF724C")
                                                                : Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    specialization
                                                                        .icons![
                                                                            idx]
                                                                        .url
                                                                        .toString()),
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: Visibility(
                                                          // visible:
                                                          //     selected == idx,
                                                          child: InkWell(
                                                            onTap: () {
                                                              createSpecializationVC
                                                                  .deleteIconById(
                                                                      context,
                                                                      widget.id,
                                                                      specialization
                                                                          .icons![
                                                                              idx]
                                                                          .sId
                                                                          .toString(),
                                                                      fToast)
                                                                  .then(
                                                                (value) {
                                                                  controller
                                                                      .getSpecializatonById(specialization
                                                                          .sId
                                                                          .toString())
                                                                      .then(
                                                                          (val) {
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                },
                                                              );
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 8,
                                                              backgroundColor:
                                                                  HexColor(
                                                                      "#2A2C41"),
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
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
                                        }))
                              ]),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
