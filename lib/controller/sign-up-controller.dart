import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signUpMethod(
      BuildContext context, // Pass the context here
      String userName,
      String userEmail,
      String userPassword) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        name: userName,
        email: userEmail,
        imageUrl: '',
      );
      // Save user data to Firestore
      try {
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());
      } catch (error) {
        print('Error saving user data to Firestore: $error');
        Get.snackbar(
          "Error",
          "$error",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      Get.offAll(() => MainScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
