import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/google_auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  bool _obscurePassword = true;
  final GoogleAuthController _googleAuthController = Get.put(GoogleAuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('asset/images/Welcome Screen .png')),
        ),
        child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text("Login here",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          color: Color(0xFF1F41BB))),
                  SizedBox(
                    height: 19,
                  ),
                  Text(
                    "Welcome back you’ve",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: ' Poppins-SemiBold'),
                  ),
                  Text(
                    "been missed!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: ' Poppins-SemiBold'),
                  ),
                  const SizedBox(height: 180),
                  Container(
                    width: size.width*0.80,
                    child: Column(children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        focusNode: _focusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscurePassword,
                        focusNode: _focusNodePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: _obscurePassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 250 ),
                        child: TextButton(
                            onPressed: () {
                            },
                            child: Center(
                              child: Text(
                                "Forgot password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 14),
                              ),
                            )),
                      ),
                      ElevatedButton(
                          onPressed: () async {

                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStatePropertyAll(
                                  Size(size.width, 46)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(9))),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF1F41BB))),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(height: 30,),
                      TextButton(
                          onPressed: () {
                            Get.offNamed('/signup');
                          },
                          child: Center(
                            child: Text(
                              "Create account",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 14),
                            ),
                          )),
                    ]),
                  ),
                  const SizedBox(height: 80),
                  Text(
                    "Or continue with",
                    style: TextStyle(
                        color: Color(0xFF1F41BB),
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),  IconButton(
                      onPressed: () {
                        _googleAuthController.signInWithGoogle().then((result) {
                          if (result != null) {
                            Get.offNamed('/main');
                          }
                        });
                        print("clicked");
                      },
                      icon: Image.asset(
                          width: 60,
                          height: 30,
                          'asset/images/google.png')),
                ],
              ),
            )),
      ),
    );
  }
}
