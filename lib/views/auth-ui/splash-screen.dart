import 'package:deal_ninja/views/auth-ui/welcome-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 8), () {
      Get.off(WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300.h,
                ),
                Center(
                    child: Image.asset(
                  'asset/images/deal-ninja-logo.png',
                  width: 150.w,
                )),
                SizedBox(
                  height: 240.h,
                ),
                const CircularProgressIndicator(
                  color: Color(0xFF1F41BB),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
