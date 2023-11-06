import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_ninja/views/auth-ui/welcome-screen.dart';
import 'package:deal_ninja/views/cart-ui/cart-screen.dart';
import 'package:deal_ninja/views/catalog-ui/catalog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/google_auth_controller.dart';
import '../banner-ui/banner-widget.dart';
import '../widgets/notification_screen.dart';
import '../widgets/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GoogleAuthController _authController = Get.find();
  late String userName;
  late String userEmail;
  late String imageUrl;
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
            userName = userData['name'] as String;
            userEmail = userData['email'] as String;
            imageUrl = userData['imageUrl'] as String;

            return Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userName,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      )),
                  accountEmail: Text(userEmail,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      )),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: imageUrl.isNotEmpty
                        ? Image.network(imageUrl).image
                        : Image.asset('asset/images/google_icon.png').image,
                  ),
                ),
                ListTile(
                    title: Text(userName,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 14,
                        )),
                    leading: Icon(Icons.account_circle_rounded)),
                ListTile(
                    onTap: () {},
                    title: Text(userEmail,
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 14,
                        )),
                    leading: Icon(Icons.email_outlined)),
                ListTile(
                    onTap: () {},
                    title: Text("Settings",
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 14,
                        )),
                    leading: Icon(Icons.settings)),
                ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.off(WelcomeScreen());
                    },
                    title: Text("Logout"),
                    leading: Icon(Icons.logout_rounded))
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
