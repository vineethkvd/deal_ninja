import 'package:deal_ninja/views/auth-ui/sign-in-screen.dart';
import 'package:deal_ninja/views/auth-ui/sign-up-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.asset('asset/images/welcome image.png')),
                SizedBox(
                  height: 47.h,
                ),
                SizedBox(
                  width: 343.w,
                  child: Text(
                    'Discover Your Dream deal here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F41BB),
                      fontSize: 35.sp,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w600,
                      height: 0.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 23.h,
                ),
                SizedBox(
                  width: 323.w,
                  child: Text(
                    'Explore all the existing job roles based on your interest and study major',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w400,
                      height: 0.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 88.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.off(SignInScreen());
                          },
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9))),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF1F41BB))),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 120.w,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.off(SignUpScreen());
                          },
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Color(0xFF1F41BB)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9))),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF595959))),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
