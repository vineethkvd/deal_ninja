import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/product_controller.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final productController = Get.find<ProductController>();

  getData() {
    productController.products.forEach((product) {
      print('Product name: ${product.name}');
      print('Product price: ${product.price}');
      print('Product image URL: ${product.imageUrl}');
      print('Product brand: ${product.brand}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child:
                Image.network(productController.products[index].imageUrl),
              ),
              title: Text(productController.products[index].brand),
            ),
          );
        },
      ),
    );
  }
}
