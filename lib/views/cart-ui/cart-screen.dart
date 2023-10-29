import 'package:flutter/material.dart';

import 'cart-products.dart';
import 'cart_total.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          CartProducts(),
          CartTotal(),
        ],
      ),
    );
  }
}
