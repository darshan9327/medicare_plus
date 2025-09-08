import 'package:get/get.dart';
import '../../../../core/models/cart_models/add_to_cart.dart';
import '../../../../core/models/cart_models/get_cart.dart';
import '../../../../core/models/cart_models/update_cart.dart';
import '../../../../core/models/cart_models/remove_from_cart.dart';
import '../../../../core/models/cart_models/clear_cart.dart';
import '../../../../data/data_source.dart';

class CartItem {
  final int id;
  final String name;
  final String company;
  final double price;
  final String image;
  final bool requiresPrescription;
  final String? prescriptionFile;
  final String? notes;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.company,
    required this.price,
    required this.image,
    this.requiresPrescription = false,
    this.prescriptionFile,
    this.notes,
    this.quantity = 1,
  });


  double get totalPrice => price * quantity;
}

class CartController extends GetxController {
  final DataSource api = DataSource();

  var cartItems = <CartItem>[].obs;
  var isLoading = false.obs;

  // =================== FetchCart =================== //
  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final GetCartModel response = await api.getCart();

      if (response.data?.items != null) {
        cartItems.assignAll(
          response.data!.items!.map((i) => CartItem(
            id: i.product?.id ?? 0,
            name: i.product?.name ?? "",
            company: "",
            price: double.tryParse(i.product?.price?.toString() ?? "0") ?? 0.0,
            image: i.product?.imageUrl ?? "",
            quantity: i.quantity ?? 1,
          )),
        );
      }
    } catch (e) {
      print("❌ Error fetching cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // =================== AddToCart =================== //
  Future<void> addToCart(CartItem item) async {
    try {
      final AddToCartModel response = await api.addToCart(
        productId: item.id,
        quantity: item.quantity,
      );
      print("✅ API AddToCart: ${response.message}");

      // Always sync cart after operation
      await fetchCart();
    } catch (e) {
      print("❌ Error adding to cart API: $e");
    }
  }

  // =================== IsInCart =================== //
  bool isInCart(int id) {
    return cartItems.any((item) => item.id == id);
  }

  // =================== RemoveFromCart =================== //
  Future<void> removeFromCart(CartItem item) async {
    try {
      final RemoveFromCartModel response = await api.removeFromCart(
        productId: item.id,
      );
      print("✅ API RemoveFromCart: ${response.message}");

      // Refresh cart
      await fetchCart();
    } catch (e) {
      print("❌ Error removing from cart API: $e");
    }
  }

  // =================== IncreaseQuantity =================== //
  Future<void> increaseQuantity(CartItem item) async {
    try {
      final UpdateCartModel response = await api.updateCart(
        productId: item.id,
        quantity: item.quantity + 1,
      );
      print("✅ API IncreaseQuantity: ${response.message}");

      await fetchCart();
    } catch (e) {
      print("❌ Error increasing quantity API: $e");
    }
  }

  // =================== DecreaseQuantity =================== //
  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      try {
        final UpdateCartModel response = await api.updateCart(
          productId: item.id,
          quantity: item.quantity - 1,
        );
        print("✅ API DecreaseQuantity: ${response.message}");

        await fetchCart();
      } catch (e) {
        print("❌ Error decreasing quantity API: $e");
      }
    } else {
      await removeFromCart(item);
    }
  }

  // =================== ClearCart =================== //
  Future<void> clearCart() async {
    try {
      final ClearCartModel response = await api.clearCart();
      print("✅ API ClearCart: ${response.message}");

      await fetchCart();
    } catch (e) {
      print("❌ Error clearing cart: $e");
    }
  }

  // =================== TotalPrice =================== //
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}
