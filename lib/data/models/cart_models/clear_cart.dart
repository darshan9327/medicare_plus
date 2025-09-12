class ClearCartModel {
  final bool success;
  final String message;
  final ClearCartData data;
  final String timestamp;

  ClearCartModel({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory ClearCartModel.fromJson(Map<String, dynamic> json) {
    return ClearCartModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: ClearCartData.fromJson(json['data'] ?? {}),
      timestamp: json['timestamp'] ?? "",
    );
  }
}

class ClearCartData {
  final List<dynamic> items;
  final num total;

  ClearCartData({
    required this.items,
    required this.total,
  });

  factory ClearCartData.fromJson(Map<String, dynamic> json) {
    return ClearCartData(
      items: json['items'] ?? [],
      total: json['total'] ?? 0,
    );
  }
}
