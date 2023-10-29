

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controller/google_auth_controller.dart';



class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GoogleAuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Obx(() {
        final user = _authController.user.value;
        if (user != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${_authController.name.value}'),
                Text('Email: ${_authController.email.value}'),
                Image.network(_authController.imageUrl.value),
                ElevatedButton(
                  onPressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    await googleSignIn.signOut();
                    Get.offAllNamed('/welcome');
                  },
                  child: Text('Sign Out'),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('User not logged in.'),
          );
        }
      }),// Your main content

      drawer: Drawer(
        child: Obx(() {
          final user = _authController.user.value;
          if (user != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data!.data() as Map<String, dynamic>;
                    final name = userData['name'] as String;
                    final email = userData['email'] as String;
                    final imageUrl = userData['imageUrl'] as String;

                    return Column(
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(name),
                          accountEmail: Text(email),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                        // Add other drawer items here
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('User data not found in the drawer.'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: Text('User not logged in in the drawer.'),
            );
          }
        }),
      ),
    );
  }
}
