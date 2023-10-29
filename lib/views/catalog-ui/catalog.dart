import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/product_controller.dart';

class CatalogProducts extends StatefulWidget {
  const CatalogProducts({super.key});

  @override
  State<CatalogProducts> createState() => _CatalogProductsState();
}

class _CatalogProductsState extends State<CatalogProducts> {
  final productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: productController.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .58,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: Offset(3, 2),
                        blurRadius: 7)
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          '${productController.products[index].imageUrl}',
                          width: double.infinity,
                        )),
                  ),
                  Text(
                    '${productController.products[index].name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${productController.products[index].brand}',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ ${productController.products[index].price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {})
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
