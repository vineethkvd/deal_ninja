import 'package:deal_ninja/controller/cart_controller.dart';
import 'package:deal_ninja/views/auth-ui/emailvalidationpage.dart';
import 'package:deal_ninja/views/auth-ui/sign-in-screen.dart';
import 'package:deal_ninja/views/auth-ui/sign-up-screen.dart';
import 'package:deal_ninja/views/auth-ui/splash-screen.dart';
import 'package:deal_ninja/views/auth-ui/welcome-screen.dart';
import 'package:deal_ninja/views/banner-ui/banner-widget.dart';
import 'package:deal_ninja/views/cart-ui/cart-products.dart';
import 'package:deal_ninja/views/cart-ui/cart-screen.dart';
import 'package:deal_ninja/views/cart-ui/cart_total.dart';
import 'package:deal_ninja/views/catalog-ui/catalog.dart';
import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/google_auth_controller.dart';
import 'controller/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  Get.put(ProductController());
  Get.put(CartController());
  Get.put(GoogleAuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/signin': (context) => const SignInScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/main': (context) => const MainScreen(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainScreen();
            } else {
              return SplashScreen();
            }
          },
        ));
  }
}
