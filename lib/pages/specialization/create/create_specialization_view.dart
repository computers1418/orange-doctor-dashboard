import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:orange_doctor_dashboard/pages/specialization/create/specialization_card.dart';

import '../../../constants/text_style.dart';
import '../../../controllers/create_specialization_vc.dart';
import '../../../widgets/custom_appbar.dart';

class CreateSpecializationView extends StatefulWidget {
  const CreateSpecializationView({super.key});

  @override
  State<CreateSpecializationView> createState() =>
      _CreateSpecializationViewState();
}

class _CreateSpecializationViewState extends State<CreateSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateSpecializationVC createSpecializationVC =
      Get.put(CreateSpecializationVC());
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final specializationController = TextEditingController();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createSpecializationVC.getSpecializatonList();
    fToast = FToast();
    fToast!.init(context);
  }

  void _pickFiles() async {
    // _resetState();
    try {
      _directoryPath = null;
      _paths.addAll((await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ))!
          .files);
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths.map((e) => e.name).toString();
      _userAborted = _paths == [];
    });
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = [];
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateSpecializationVC>(
        init: CreateSpecializationVC(),
        builder: (controller) => Column(
          children: [
            CustomAppbar(showback: false, scaffoldKey: scaffoldKey),
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Specialization",
                      style: CustomFonts.poppins20W600(),
                    ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: specializationController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    hintText: "Specialization Name",
                                    hintStyle: CustomFonts.poppins14W500(
                                        color: HexColor("#222425")),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Row(children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 60,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _paths.length + 1,
                                      itemBuilder: (_, idx) {
                                        if (idx == _paths.length) {
                                          return Align(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () {
                                                  _pickFiles();
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: SizedBox(
                                              width: 60,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  child: Image.file(
                                                      fit: BoxFit.fill,
                                                      File(_paths[idx]
                                                          .path
                                                          .toString()))),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("${_paths.length} Icons Added",
                                  style: CustomFonts.poppins14W500()),
                              const SizedBox(width: 20),
                              Container(
                                height: 37,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: HexColor("#FF724C"),
                                    borderRadius: BorderRadius.circular(30)),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_paths.isNotEmpty) {
                                      controller.uploadImage(
                                          context,
                                          _paths
                                              .map(
                                                (e) => e.path!,
                                              )
                                              .toList(),
                                          _paths
                                              .map(
                                                (e) => e.name,
                                              )
                                              .toList(),
                                          specializationController.text,
                                          fToast);
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: CustomFonts.poppins14W700(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "List of Specialization",
                      style: CustomFonts.poppins20W600(),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: HexColor("#FFF7E9"),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.specializations.length,
                        itemBuilder: (context, index) {
                          return specializationCard(index, context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
