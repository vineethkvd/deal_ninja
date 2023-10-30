import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.find();
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan, // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1.0, // Border width
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${controller.total ?? "0.00"}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16), // Add some spacing

              // Checkout Button
              ElevatedButton(
                onPressed: () {
                  // Implement your checkout logic here
                  // This is where you can navigate to a checkout page or perform checkout actions.
                },
                child: Text("Checkout"),
              ),
            ],
        ),
      ),
          ),
    );
  }
}
