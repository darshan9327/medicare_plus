class GetCartModel {
  final bool? success;
  final String? message;
  final CartData? data;

  GetCartModel({this.success, this.message, this.data});

  factory GetCartModel.fromJson(Map<String, dynamic> json) {
    return GetCartModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }
}

class CartData {
  final List<CartItemData>? items;
  final int? total;

  CartData({this.items, this.total});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      items: json['items'] != null
          ? (json['items'] as List).map((e) => CartItemData.fromJson(e)).toList()
          : [],
      total: json['total'],
    );
  }
}

class CartItemData {
  final int? productId;
  final int? quantity;
  final double? price;
  final Product? product;

  CartItemData({this.productId, this.quantity, this.price, this.product});

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      productId: json['productId'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()),
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class Product {
  final int? id;
  final String? name;
  final String? price;
  final String? imageUrl;

  Product({this.id, this.name, this.price, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
    );
  }
}
