// import 'dart:math';
//
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// class AgentDetailsController extends GetxController {
//   //TODO: Implement AgentDetailsController
//   final dio = Dio();
//
//   final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _defaultFileNameController = TextEditingController();
//   final _dialogTitleController = TextEditingController();
//   final _initialDirectoryController = TextEditingController();
//   final _fileExtensionController = TextEditingController();
//   String? _fileName;
//   String? _saveAsFileName;
//   List<PlatformFile>? _paths;
//   String? _directoryPath;
//   String? _extension;
//   bool _isLoading = false;
//   bool _lockParentWindow = false;
//   bool _userAborted = false;
//   bool _multiPick = false;
//   FileType _pickingType = FileType.any;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//   void _pickFiles() async {
//     // _resetState();
//     try {
//       _directoryPath = null;
//       _paths = (await FilePicker.platform.pickFiles(
//         compressionQuality: 30,
//         type: _pickingType,
//         allowMultiple: false,
//         onFileLoading: (FilePickerStatus status) => print(status),
//         allowedExtensions: (_extension?.isNotEmpty ?? false)
//             ? _extension?.replaceAll(' ', '').split(',')
//             : null,
//         dialogTitle: _dialogTitleController.text,
//         initialDirectory: _initialDirectoryController.text,
//         lockParentWindow: _lockParentWindow,
//       ))
//           ?.files;
//     } on PlatformException catch (e) {
//       _logException('Unsupported operation' + e.toString());
//     } catch (e) {
//       _logException(e.toString());
//     }
//     // if (!mounted) return;
//     // setState(() {
//       _isLoading = false;
//       _fileName =
//       _paths != null ? _paths!.map((e) => e.name).toString() : '...';
//       _userAborted = _paths == null;
//     // });
//   }
//
//   void _logException(String message) {
//     print(message);
//     _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//     _scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
// }
