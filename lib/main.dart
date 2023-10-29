import 'package:deal_ninja/test.dart';
import 'package:deal_ninja/views/auth-ui/sign-in-screen.dart';
import 'package:deal_ninja/views/auth-ui/sign-up-screen.dart';
import 'package:deal_ninja/views/auth-ui/splash-screen.dart';
import 'package:deal_ninja/views/auth-ui/welcome-screen.dart';
import 'package:deal_ninja/views/catalog-ui/catalog.dart';
import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/google_auth_controller.dart';
import 'controller/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ProductController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/main', page: () => MainScreen()),
      ],
      home: CatalogProducts(),
    );
  }
}
