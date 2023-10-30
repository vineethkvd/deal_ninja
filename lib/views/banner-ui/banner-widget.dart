// ignore_for_file: file_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/banners-controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final bannerController _bannerController = Get.put(bannerController());
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return Column(
          children: [
            CarouselSlider(
              items: _bannerController.bannerUrls
                  .map(
                    (imageUrls) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls,
                    fit: BoxFit.cover,
                    width: Get.width - 10,
                    placeholder: (context, url) => ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                ),
              )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                _bannerController.bannerUrls.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? Colors.red
                            : Colors.teal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        );
      }),
    );
  }
}
