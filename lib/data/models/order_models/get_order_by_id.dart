class OrdersListResponse {
  final bool success;
  final List<Order> data;
  final Pagination pagination;
  final String timestamp;

  OrdersListResponse({
    required this.success,
    required this.data,
    required this.pagination,
    required this.timestamp,
  });

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    List<Order> parsedOrders = [];

    if (rawData is List) {
      parsedOrders = rawData.map((e) => Order.fromJson(e)).toList();
    } else if (rawData is Map<String, dynamic>) {
      parsedOrders = [Order.fromJson(rawData)];
    }

    return OrdersListResponse(
      success: json['success'] ?? false,
      data: parsedOrders,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : Pagination(
        page: 0,
        limit: 0,
        total: 0,
        totalPages: 0,
        hasNext: false,
        hasPrev: false,
      ),
      timestamp: json['timestamp'] ?? '',
    );
  }

}

class Order {
  final int id;
  final int? userId;
  final String total;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String? deliveryAddress;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final List<OrderItem> items;
  final String phoneNumber;
  final String? prescriptionUrl;
  final String? customerName;
  final String? customerPhone;

  Order({
    required this.id,
    this.userId,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    this.deliveryAddress,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.phoneNumber,
    this.prescriptionUrl,
    this.customerName,
    this.customerPhone,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'],
      total: json['total'] ?? '0',
      status: json['status'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      deliveryAddress: json['delivery_address'],
      notes: json['notes'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      phoneNumber: json['phone_number'] ?? '',
      prescriptionUrl: json['prescription_url'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
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
      'customer_name': customerName,
      'customer_phone': customerPhone,
    };
  }
}

class OrderItem {
  final String price;
  final int quantity;
  final int productId;

  OrderItem({
    required this.price,
    required this.quantity,
    required this.productId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      price: json['price'].toString(),
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
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasNext: json['hasNext'] ?? false,
      hasPrev: json['hasPrev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
      'hasNext': hasNext,
      'hasPrev': hasPrev,
    };
  }
}
