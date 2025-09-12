class OrdersResponse {
  final bool success;
  final String message;
  final OrdersData? data;
  final String? timestamp;

  OrdersResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OrdersData.fromJson(json['data']) : null,
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

class OrdersData {
  final List<Order> orders;
  final Pagination pagination;

  OrdersData({
    required this.orders,
    required this.pagination,
  });

  factory OrdersData.fromJson(Map<String, dynamic> json) {
    return OrdersData(
      orders: (json['orders'] as List<dynamic>? ?? [])
          .map((e) => Order.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class Order {
  final int id;
  final String total;
  final String status;
  final List<OrderItem> items;
  final String? prescriptionUrl;
  final String createdAt;

  Order({
    required this.id,
    required this.total,
    required this.status,
    required this.items,
    this.prescriptionUrl,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      total: json['total'] ?? '0',
      status: json['status'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      prescriptionUrl: json['prescription_url'],
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'status': status,
      'items': items.map((e) => e.toJson()).toList(),
      'prescription_url': prescriptionUrl,
      'created_at': createdAt,
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

class Pagination {
  final int page;
  final int limit;
  final int total;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
    };
  }
}
