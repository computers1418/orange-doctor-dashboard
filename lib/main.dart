import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/navigation.dart';
import 'package:orange_doctor_dashboard/pages/specialization/create/create_specialization_vc.dart';
import 'constants/initial_binding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light // Set your desired color
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final CreateSpecializationVC authController = Get.put(CreateSpecializationVC());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialBinding: AppInitialBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
              return MediaQuery(
              
                  ///Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            },
      home: Navigation(),
    );
  }
}