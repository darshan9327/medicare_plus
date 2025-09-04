import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controller/cart_controller.dart';
import '../../cart/pages/cart_screen.dart';
import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../../home_screen/page/home_screen.dart';
import '../../profile/pages/profile_screen.dart';
import '../../search/pages/search_screen.dart';
import '../../settings/pages/setting_screen.dart';
import '../../wishlist/pages/wish_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final cartController = Get.find<CartController>();

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), SearchScreen(), ShoppingCart(showOwnAppBar: false), ProfilePage()];

  final List<String> _titles = ["MediCare+", "Search Results", "Shopping Cart", "Profile"];

  late final List<List<Widget>> _actions;

  @override
  void initState() {
    super.initState();

    _actions = [
      [
        IconButton(onPressed: () => Get.to(() => WishlistPage()), icon: const Icon(Icons.favorite, color: Colors.red)),
        Stack(
          children: [
            SizedBox(
              height: SConfig.sHeight,
              child: IconButton(
                onPressed: () {
                  Get.to(() => ShoppingCart(showOwnAppBar: true));
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
              ),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Obx(() {
                final count = cartController.cartItems.length;
                return count > 0
                    ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Text(
                    "$count",
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
                    : const SizedBox();
              }),
            ),
          ],
        ),
      ],
      [const SizedBox()],
      [const SizedBox()],
      [IconButton(onPressed: () => Get.to(() => SettingsScreen()), icon: const Icon(Icons.settings))],
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: _titles[_selectedIndex], actions: _actions[_selectedIndex], leading: false),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        items: const [
          BottomNavigationBarItem(icon: Text("🏠", style: TextStyle(fontSize: 20)), label: "Home"),
          BottomNavigationBarItem(icon: Text("🔍", style: TextStyle(fontSize: 20)), label: "Search"),
          BottomNavigationBarItem(icon: Text("🛒", style: TextStyle(fontSize: 20)), label: "Cart"),
          BottomNavigationBarItem(icon: Text("👤", style: TextStyle(fontSize: 20)), label: "Profile"),
        ],
      ),
    );
  }
}
