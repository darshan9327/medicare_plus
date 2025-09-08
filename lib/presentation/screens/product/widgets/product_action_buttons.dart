import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/product_models/product_by_id.dart';
import '../../cart/controller/cart_controller.dart';
import '../../common/widgets/common_container.dart';
import '../../upload_prescription/page/upload_prescription_screen.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class ProductActionButtons extends StatelessWidget {
  final Data product;
  final bool isInWishlist;
  final bool isInCart;
  final Function(bool) onWishlistToggle;
  final Function(bool) onCartToggle;

  const ProductActionButtons({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.isInCart,
    required this.onWishlistToggle,
    required this.onCartToggle,
  });

  @override
  Widget build(BuildContext context) {

    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Row(
      children: [
        CommonContainer(
          color: Colors.white,
          color1: Colors.blue,
          text: isInWishlist ? "Remove Wishlist" : "Add to Wishlist",
          onPressed: () {
            if (isInWishlist) {
              wishlistController.removeFromWishlist(product.id!);
              onWishlistToggle(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} removed from wishlist")),
              );
            } else {
              wishlistController.addToWishlist(product);
              onWishlistToggle(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} added to wishlist")),
              );
            }
          },
        ),
        const Spacer(),
        CommonContainer(
          text: isInCart ? "Remove from Cart" : "Add to Cart",
          onPressed: () {
            if (isInCart) {
              // cartController.removeFromCart();
              onCartToggle(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} removed from cart")),
              );
            } else {
              if (product.requiresPrescription == true) {
                Get.to(() => UploadPrescription(
                ));
              } else {
                cartController.addToCart(
                  CartItem(
                    id: product.id ?? 0,
                    name: product.name ?? "",
                    price: double.tryParse(product.price ?? "0") ?? 0.0,
                    image: product.imageUrl ?? "",
                    requiresPrescription: product.requiresPrescription ?? false,
                    company: product.category ?? "",
                  ),
                );
                onCartToggle(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.name} added to cart")),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
