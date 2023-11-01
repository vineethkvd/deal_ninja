import 'package:deal_ninja/controller/email_pass_controller.dart';
import 'package:deal_ninja/controller/product_controller.dart';
import 'package:deal_ninja/views/auth-ui/splash-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/email_validation_controller.dart';
import 'controller/google_auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(GoogleAuthController());
  Get.put(EmailPassController());
  Get.put(EmailValidationController());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(home: SplashScreen());
      },
    );
  }
}
