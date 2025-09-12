class CreateOrderResponse {
  final bool success;
  final String message;
  final OrderData? data;
  final String? timestamp;

  CreateOrderResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'timestamp': timestamp,
    };
  }
}

class OrderData {
  final Order order;
  final int deliveryCharge;
  final String message;

  OrderData({
    required this.order,
    required this.deliveryCharge,
    required this.message,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: Order.fromJson(json['order'] ?? {}),
      deliveryCharge: json['deliveryCharge'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order.toJson(),
      'deliveryCharge': deliveryCharge,
      'message': message,
    };
  }
}

class Order {
  final int id;
  final int userId;
  final String total;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryAddress;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final List<OrderItem> items;
  final String phoneNumber;
  final String prescriptionUrl;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryAddress,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.phoneNumber,
    required this.prescriptionUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      total: json['total'] ?? '0',
      status: json['status'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      notes: json['notes'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      phoneNumber: json['phone_number'] ?? '',
      prescriptionUrl: json['prescription_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total': total,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'delivery_address': deliveryAddress,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'items': items.map((e) => e.toJson()).toList(),
      'phone_number': phoneNumber,
      'prescription_url': prescriptionUrl,
    };
  }
}

class OrderItem {
  final int price;
  final int quantity;
  final int productId;

  OrderItem({
    required this.price,
    required this.quantity,
    required this.productId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      productId: json['productId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'quantity': quantity,
      'productId': productId,
    };
  }
}
