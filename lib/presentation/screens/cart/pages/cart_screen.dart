import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
import '../../orders/pages/checkout_screen.dart';
import '../controller/cart_controller.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary_card.dart';

class ShoppingCart extends StatefulWidget {
  final bool? showOwnAppBar;
  const ShoppingCart({super.key, this.showOwnAppBar});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final cartController = Get.find<CartController>();

  final double deliveryFee = 25.0;
  final double taxPercent = 0.115;

  double get subtotal =>
      cartController.cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * taxPercent;
  double get total => subtotal + deliveryFee + tax;

  @override
  void initState() {
    super.initState();
    cartController.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showOwnAppBar == true
          ? const CommonAppBar(title: "Shopping Cart")
          : null,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
                () {
              if (cartController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cartController.cartItems.length} items in cart",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: cartController.cartItems.isEmpty
                        ? const Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                        : ListView.builder(
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return CartItemTile(item: item);
                      },
                    ),
                  ),

                  CartSummaryCard(
                    subtotal: subtotal,
                    deliveryFee: deliveryFee,
                    tax: tax,
                    total: total,
                  ),
                  SizedBox(height: SConfig.sHeight * 0.030),

                  CommonContainer(
                    text: "Proceed to Checkout",
                    onPressed: () {
                      if (cartController.cartItems.isEmpty) {
                        Get.snackbar(
                          "Cart Empty",
                          "Please add items to cart before proceeding",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent.shade100,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 8,
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        Get.to(CheckoutScreen(totalAmount: total));
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
