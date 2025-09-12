class RemoveFromCartModel {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  RemoveFromCartModel({this.success, this.message, this.data, this.timestamp});

  RemoveFromCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }
}

class Data {
  List<CartItem>? items;
  int? total;

  Data({this.items, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add(CartItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (items != null) {
      map['items'] = items!.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }
}

class CartItem {
  int? productId;
  int? quantity;
  String? price;

  CartItem({this.productId, this.quantity, this.price});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['productId'] = productId;
    map['quantity'] = quantity;
    map['price'] = price;
    return map;
  }
}
