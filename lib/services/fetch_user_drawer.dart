import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

Future<void> fetchUserDetailsFromFirestore(String userId) async {
  try {
    final userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      final fetchedUser = UserModel.fromMap(data);
    }
  } catch (error) {
    print('Error fetching user data from Firestore: $error');
    // Handle the error, show a message, etc.
  }
}