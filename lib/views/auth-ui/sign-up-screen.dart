import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/google_auth_controller.dart';
import '../../controller/sign-up-controller.dart';
import 'emailvalidationpage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final GoogleAuthController _googleAuthController =
      Get.put(GoogleAuthController());
  final SignUpController _signUpController = Get.put(SignUpController());

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
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text("Create Account",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          color: Color(0xFF1F41BB))),
                  Text(
                    "Create an account so you can explore all the",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: ' Poppins-SemiBold'),
                  ),
                  Text(
                    "existing jobs",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: ' Poppins-SemiBold'),
                  ),
                  const SizedBox(height: 180),
                  Container(
                    width: size.width * 0.80,
                    child: Column(children: [
                      TextFormField(
                        controller: _nameTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          } else if (value.contains(RegExp(r'[0-9]'))) {
                            return 'Name cannot contain numbers';
                          } else if (value.contains(RegExp(r'\s{2,}'))) {
                            return 'Name cannot have consecutive white spaces';
                          } else if (value.contains(RegExp(r'[^a-zA-Z\s]'))) {
                            return 'Name cannot contain special characters';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: const Icon(Icons.person_outline),
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
                        controller: _emailTextController,
                        focusNode: _focusNodeEmail,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          } else if (!value.contains("@")) {
                            return "please enter a valid email";
                          } else {
                            return null;
                          }
                        },
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
                        controller: _passwordTextController,
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
                      ElevatedButton(
                          onPressed: () async {
                            final signUpController =
                                Get.find<SignUpController>();

                            try {
                              await signUpController.signupUser(
                                _emailTextController.text,
                                _passwordTextController.text,
                                _nameTextController.text,
                              );
                              if (signUpController.currentUser != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EmailValidationPage(
                                      user: signUpController.currentUser!),
                                ));
                              } else {
                                // No user is currently authenticated
                                print('No user is currently authenticated');
                              }
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                            }
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStatePropertyAll(
                                  Size(size.width, 46)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF1F41BB))),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.offNamed('/signin');
                          },
                          child: Center(
                            child: Text(
                              "Already have an account",
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
                  ),
                  IconButton(
                      onPressed: () {
                        _googleAuthController.signInWithGoogle().then((result) {
                          if (result != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main', (route) => false);
                          }
                        });
                        print("clicked");
                      },
                      icon: Image.asset(
                          width: 60, height: 30, 'asset/images/google.png')),
                ],
              ),
            )),
      ),
    );
  }
}
