import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  Future<void> getAllProducts() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();

      products.assignAll(
        querySnapshot.docs
            .map((doc) =>
                ProductModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList(),
      );
    } catch (error) {
      print('Error fetching products: $error');
    }
  }
}
