import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja/views/cart-ui/cart-screen.dart';
import 'package:deal_ninja/views/catalog-ui/catalog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/google_auth_controller.dart';
import '../banner-ui/banner-widget.dart';
import '../widgets/notification_screen.dart';
import '../widgets/settings_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GoogleAuthController _authController = Get.find();
  final currentUser = FirebaseAuth.instance;
  int _currentSelectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    CatalogProducts(),
    NotificationScreen(),
    CartScreen(),
    SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("userId", isEqualTo: currentUser.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading state
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No user data found'); // No data found
            }

            final userData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            final userName = userData['name'] as String;
            final userEmail = userData['email'] as String;
            final imageUrl = userData['imageUrl'] as String;

            return Column(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                      backgroundImage: Image.network(imageUrl).image),
                ),
                Text(userName),
                Text(userEmail),
              ],
            );
          },
        ),
      ),
      body: Column(children: [
        if (_currentSelectedIndex == 0) BannerWidget(),
        Expanded(child: _pages[_currentSelectedIndex])
      ]),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(fontFamily: 'Poppins-Regular'),
          unselectedItemColor: Colors.black,
          currentIndex: _currentSelectedIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('asset/images/deal.png')),
              label: "Deals",
            ),
            BottomNavigationBarItem(
              icon: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('asset/images/bell.png')),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('asset/images/shopping-cart.png')),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('asset/images/settings.png')),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
