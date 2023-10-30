import 'dart:convert';

import 'package:deal_ninja/model/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var _products = {}.obs;
  @override
  void onInit() {
    super.onInit();
    loadCartFromPrefs();
  }
  void addProduct(ProductModel product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeProduct(ProductModel product) {
    if (_products.containsKey(product)) {
      if (_products[product] == 1) {
        _products.removeWhere((key, value) => key == product);
      } else {
        _products[product] = (_products[product] ?? 0) - 1;
      }
    }
  }

  void saveCartToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(_products);
    await prefs.setString('cartItems', cartJson);
  }
  void loadCartFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getString('cartItems');
    if (cartItems != null) {
      final cartData = json.decode(cartItems);
      _products.assignAll(Map<ProductModel, int>.from(cartData));
    }
  }


  @override
  void dispose() {
    saveCartToPrefs();
    super.dispose();
  }

  get totalAmount => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element);

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries.isNotEmpty
      ? _products.entries
          .map((product) => product.key.price * product.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)
      : "0.00";
}
