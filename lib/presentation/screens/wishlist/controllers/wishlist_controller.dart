import 'package:get/get.dart';

import '../../../../data/models/product_models/product_by_id.dart';

class WishlistController extends GetxController {
  var wishlist = <Data>[].obs;

  void addToWishlist(Data product) {
    wishlist.add(product);
  }

  void removeFromWishlist(int id) {
    wishlist.removeWhere((item) => item.id == id);
  }

  bool isInWishlist(int id) {
    return wishlist.any((item) => item.id == id);
  }
}
