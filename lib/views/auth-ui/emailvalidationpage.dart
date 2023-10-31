import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign-up-controller.dart';

class EmailValidationPage extends StatefulWidget {
  final User user;

  const EmailValidationPage({required this.user});

  @override
  State<EmailValidationPage> createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
  bool _isSendingVerification = false;
  late User currentUser;

  @override
  void initState() {
    currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${currentUser.email}"),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (currentUser != null) {
                    if (!currentUser.emailVerified) {
                      setState(() {
                        _isSendingVerification = true; // Show loading indicator
                      });

                      try {
                        await currentUser.sendEmailVerification();
                        await currentUser.reload();
                        User? user = FirebaseAuth.instance.currentUser;

                        if (user!.emailVerified) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ));
                        } else {
                          Get.snackbar('Error', 'Email not verified yet');
                        }
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _isSendingVerification =
                              false; // Hide loading indicator
                        });
                      }
                    }
                  }
                },
                child: _isSendingVerification
                    ? CircularProgressIndicator() // Show loading indicator
                    : Text("Verify"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
