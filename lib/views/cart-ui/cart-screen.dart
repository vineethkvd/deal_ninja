import 'package:flutter/material.dart';

import 'cart-products.dart';
import 'cart_total.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.topCenter, child: CartProducts()),
        Container(
            margin: EdgeInsets.only(bottom: 20.0),
            alignment: Alignment.center,
            child: CartTotal()),
      ],
    );
  }
}
