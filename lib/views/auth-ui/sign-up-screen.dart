import 'package:deal_ninja/views/auth-ui/email-validation-screen.dart';
import 'package:deal_ninja/views/auth-ui/sign-in-screen.dart';
import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/email_pass_controller.dart';
import '../../controller/google_auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  Widget getTextField(
      {required String hint, required var controllerData, required var icons}) {
    return TextFormField(
      controller: controllerData,
      decoration: InputDecoration(
          prefixIcon: icons,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }

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
                  height: 52.h,
                ),
                Text(
                  "Sign Up to Deal Ninja",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: darkTextColor,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(SignInScreen(), transition: Transition.fadeIn);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: purpleColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 36.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        getTextField(
                          hint: "Full Name",
                          controllerData: _nameTextController,
                          icons: const Icon(Icons.person_outline),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        getTextField(
                            hint: "Email",
                            controllerData: _emailTextController,
                            icons: const Icon(Icons.email_outlined)),
                        SizedBox(
                          height: 16.h,
                        ),
                        getTextField(
                            hint: "Password",
                            controllerData: _passwordTextController,
                            icons: const Icon(Icons.lock)),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final emailPassController =
                                  Get.find<EmailPassController>();

                              try {
                                await emailPassController.signupUser(
                                  _emailTextController.text,
                                  _passwordTextController.text,
                                  _nameTextController.text,
                                );
                                if (emailPassController.currentUser != null) {
                                  Get.off(EmailValidationScreen(
                                      user: emailPassController.currentUser!));
                                } else {
                                  // No user is currently authenticated
                                  print('No user is currently authenticated');
                                }
                              } catch (e) {
                                Get.snackbar('Error', e.toString());
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(purpleColor),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 14.h)),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ))),
                            child: Text("Create Account"),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "or sign up via",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: lightTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      try {
                        final googleController =
                            Get.find<GoogleAuthController>();
                        googleController.signInWithGoogle().then((result) {
                          if (result != null) {
                            final user = googleController.user.value;
                            print(user);
                            if (user != null) {
                              Get.off(MainScreen(user: user));
                            }
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: borderColor,
                        )),
                        foregroundColor:
                            MaterialStateProperty.all(darkTextColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                            width: 60,
                            height: 30,
                            'asset/images/google_icon.png'),
                        SizedBox(width: 10.w),
                        Text("Google"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " By signing up to Deal Ninja you agree to our ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor,
                      ),
                    ),
                    SizedBox(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "terms and conditions",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: purpleColor,
                            ),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
