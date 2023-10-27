import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/Welcome Screen .png')),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Image.asset('asset/images/deal-ninja-logo.png',
                          width: 220),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    width: size.width,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Color(0xFF1F41BB),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
