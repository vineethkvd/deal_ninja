import 'package:deal_ninja/views/cart-ui/cart-screen.dart';
import 'package:deal_ninja/views/catalog-ui/catalog.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentSelectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }
  static List<Widget> _pages = <Widget>[
    CatalogProducts(),
    CartScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
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
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
