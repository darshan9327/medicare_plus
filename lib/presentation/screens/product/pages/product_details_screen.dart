import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/product_models/product_by_id.dart';
import '../../../../data/data_source.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/pages/cart_screen.dart';
import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../wishlist/pages/wish_list_screen.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_image.dart';
import '../widgets/product_price_section.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Data? product;
  bool isLoading = true;
  late bool isInCart;
  late bool isInWishlist;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  final cartController = Get.put(CartController());
  final wishlistController = Get.put(WishlistController());

  void fetchProduct() async {
    final api = DataSource();
    final fetchedProductModel = await api.getProductById(id: widget.productId);

    setState(() {
      product = fetchedProductModel.data;
      isInCart = Get.find<CartController>().isInCart(product!.id!);
      isInWishlist = Get.find<WishlistController>().isInWishlist(product!.id!);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: product!.name ?? "Product Detail",
        actions: [
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(image: product!.imageUrl ?? ""),
            const SizedBox(height: 16),
            Text(product!.name ?? "", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product!.category ?? "", style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 16),
            ProductPriceSection(price: product!.price ?? "0", prescriptionRequired: product!.requiresPrescription ?? false),
            const SizedBox(height: 20),
            ProductActionButtons(
              product: product!,
              isInCart: isInCart,
              isInWishlist: isInWishlist,
              onCartToggle: (val) => setState(() => isInCart = val),
              onWishlistToggle: (val) => setState(() => isInWishlist = val),
            ),
            const SizedBox(height: 30),
            const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product!.description ?? "No description available."),
          ],
        ),
      ),
    );
  }
}
