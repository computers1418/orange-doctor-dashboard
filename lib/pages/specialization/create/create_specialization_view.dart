import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/pages/specialization/create/create_specialization_vc.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';

class CreateSpecializationView extends StatefulWidget {
  const CreateSpecializationView({super.key});

  @override
  State<CreateSpecializationView> createState() =>
      _CreateSpecializationViewState();
}

class _CreateSpecializationViewState extends State<CreateSpecializationView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  String? _fileName;
  String? _saveAsFileName;
  final List<PlatformFile?> _paths = List.generate(
    4,
    (index) => null,
  );
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.image;

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      List<PlatformFile>? pickedResut = (await FilePicker.platform.pickFiles(
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
          .files;
      if (!mounted) return;
      _paths.removeWhere((element) => element == null);
      _paths.addAll(pickedResut);
      _paths.addAll(
        List.generate(
          4 - (_paths.length % 4),
          (index) => null,
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.ease,
        );
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths.map((e) => e?.name).toString();
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
      // _paths = [];
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  int get _totalSelectedFiles => {
        for (int i = 0; i < _paths.length; i++)
          if (_paths[i] != null) i
      }.length;

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
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
  }

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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                hintText: "Specialization Name",
                                hintStyle: CustomFonts.poppins14W500(
                                    color: HexColor("#222425")),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 100,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    itemCount: _paths.length > 1
                                        ? _paths.length + 1
                                        : 1,
                                    itemBuilder: (_, idx) {
                                      if (idx == _paths.length) {
                                        return Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _paths.addAll(
                                                  [
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                  ],
                                                );
                                              });
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                _scrollController.animateTo(
                                                  _scrollController
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  curve: Curves.ease,
                                                );
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          HexColor("#FF724C"),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "More",
                                                    style: CustomFonts
                                                        .poppins12W500(
                                                      color:
                                                          HexColor("#222425"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: SizedBox(
                                            child: Column(
                                              children: [
                                                _paths[idx] == null
                                                    ? GestureDetector(
                                                        onTap: () async {
                                                          _pickFiles();
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Icon(
                                                            Icons.add,
                                                            color: HexColor(
                                                              "#FF724C",
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        child: Image.file(
                                                          fit: BoxFit.fill,
                                                          height: 60,
                                                          width: 60,
                                                          File(
                                                            _paths[idx]!
                                                                .path
                                                                .toString(),
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "$_totalSelectedFiles Icons Added",
                              style: CustomFonts.poppins14W500(),
                            ),
                            const SizedBox(width: 20),
                            GetBuilder(
                              init: CreateSpecializationVC(),
                              initState: (state) async {
                                state.controller?.refresh();
                              },
                              builder: (CreateSpecializationVC controller) {
                                return Container(
                                  height: 37,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: HexColor("#FF724C"),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: controller.rxGetList.isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8),
                                          child: Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            List<String> paths = [];
                                            List<String> names = [];

                                            for (int i = 0;
                                                i < _paths.length;
                                                i++) {
                                              if (_paths[i] != null) {
                                                paths
                                                    .add(_paths[i]!.xFile.path);
                                                names
                                                    .add(_paths[i]!.xFile.name);
                                              }
                                            }
                                            if (paths.isEmpty ||
                                                names.isEmpty ||
                                                _nameController.text.isEmpty) {
                                              return;
                                            }
                                            controller.uploadImage(
                                              paths,
                                              names,
                                              specilizationName:
                                                  _nameController.text.trim(),
                                            );
                                            // controller.deleteSpecializatonIconById('668d6b77b1e15c3b7368f968',_paths?.first);
                                          },
                                          child: Center(
                                            child: Text(
                                              'Save',
                                              style: CustomFonts.poppins14W700(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                );
                              },
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
                    child: Column(
                      children: [
                        for (int index = 0; index < 10; index++) card(index),
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

  Widget card(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No.',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    '${index + 1}',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Specialization',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    'Dental',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. of Icons Added',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    '04',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    'Nov 21, 2024',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: CustomFonts.poppins10W600(
                        color: HexColor("#222425").withOpacity(.5)),
                  ),
                  Text(
                    '12:37 pm',
                    style:
                        CustomFonts.poppins12W600(color: HexColor("#222425")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 22,
                margin: const EdgeInsets.only(left: 30),
                // width: 66,
                decoration: BoxDecoration(
                    color: HexColor("#FF724C"),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'View',
                    style: CustomFonts.poppins10W700(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        if (index < 9)
          Divider(
            color: HexColor("#F8E3BD"),
            height: 32,
          )
      ],
    );
  }
}
