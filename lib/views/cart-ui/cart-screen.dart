import 'package:flutter/material.dart';

import 'cart-products.dart';
import 'cart_total.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  width: size.width,
                  alignment: Alignment.topCenter,
                  child: CartProducts()),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: size.width,
                alignment: Alignment.center,
                child: CartTotal()),
          ],
        ),
      ),
    );
  }
}
