import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/product_controller.dart';

class CatalogProducts extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: productController.products.length,
        itemBuilder: (BuildContext context, int index) {
          return CatalogProductCard(index: index);
        },
      ),
    );
  }
}

class CatalogProductCard extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final ProductController productController = Get.find();
  final int index;

  CatalogProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productController.products[index];
    print(product);
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'product_image_$index',
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          IconButton(
            onPressed: () {
              cartController.addProduct(product);
              print(product.price);
            },
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
    );
  }
}
