import 'package:get/get.dart';

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
  var cartItems = <CartItem>[].obs;

  void addToCart(CartItem item) {
    int index = cartItems.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
  }

  bool isInCart(int id) {
    return cartItems.any((item) => item.id == id);
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
  }

  void removeFromCartByName(String name) {
    cartItems.removeWhere((item) => item.name == name);
    update();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
    }
    cartItems.refresh();
  }
}
