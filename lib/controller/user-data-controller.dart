import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  RxList<UserModel> userData = RxList<UserModel>([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();

      userData.assignAll(
        querySnapshot.docs
            .map((doc) =>
            UserModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList(),
      );
    } catch (error) {
      print('Error fetching products: $error');
    }
  }
}
