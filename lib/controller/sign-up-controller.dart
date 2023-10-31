import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja/views/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  Future<void> signupUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);
      Get.snackbar('Success', 'Registration Successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Password Provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Email Provided already Exists');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  User? get currentUser => _auth.currentUser;
  Future<void> signinUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'You are Logged in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user Found with this Email');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Password did not match');
      }
    }
  }

  // Function to send an email verification link
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;

    if (user != null) {
      if (!user.emailVerified) {
        try {
          await user.sendEmailVerification();

          // Listen for changes in the user's email verification status
          await user.reload();
          user = _auth.currentUser; // Refresh the user object

          if (user != null && user.emailVerified) {
            Get.snackbar('Success', 'Email verification link sent');

            // Automatically route to the main page when email is verified
            Get.put(MainScreen()); // Replace '/MainPage' with your route
          } else {
            Get.snackbar('Error',
                'Email verification link sent, but email is not verified yet');
          }
        } catch (e) {
          Get.snackbar('Error', 'Failed to send email verification link');
        }
      } else {
        Get.snackbar('Error', 'User is already verified');
      }
    } else {
      Get.snackbar('Error', 'User is not logged in');
    }
  }
}

class FirestoreServices {
  static Future<void> saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}
