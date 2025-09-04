import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/pages/cart_screen.dart';
import '../../common/utils/common_appbar.dart';
import '../controllers/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  final WishlistController wishlistController = Get.put(WishlistController());

  WishlistPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "My Wishlist",
        actions: [IconButton(onPressed: () => Get.to(() => ShoppingCart(showOwnAppBar: true)), icon: Icon(Icons.shopping_cart, color: Colors.white))],
      ),
      body: Obx(() {
        if (wishlistController.wishlist.isEmpty) {
          return const Center(child: Text("No items in wishlist"));
        }
        return ListView.builder(
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
          },
        );
      }),
    );
  }
}
