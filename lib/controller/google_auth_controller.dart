import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart'; // Import Firestore

class GoogleAuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;
  Rx<User?> user = Rx<User?>(null);

  Future<String> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);
      final currentUser = authResult.user;

      if (currentUser != null) {
        name.value = currentUser.displayName ?? '';
        email.value = currentUser.email ?? '';
        imageUrl.value = currentUser.photoURL ?? '';
        user(currentUser);

        if (name.value.contains(" ")) {
          name.value = name.value;
        }

        // Create a UserModel object and initialize it
        UserModel userModel = UserModel(
          userId: currentUser.uid,
          name: currentUser.displayName ?? '',
          email: currentUser.email ?? '',
          imageUrl: currentUser.photoURL ?? '',
        );

        print('signInWithGoogle succeeded: $currentUser');

        try {
          await FirebaseFirestore.instance // Save user data to Firestore
              .collection('users')
              .doc(currentUser.uid)
              .set(userModel.toMap());
        } catch (error) {
          print('Error saving user data to Firestore: $error');
          Get.snackbar(
            "Error",
            "$error",
            snackPosition: SnackPosition.BOTTOM,
          );
        }

        return '$user';
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return '';
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    user(null);
    print("User Signed Out");
  }
}
