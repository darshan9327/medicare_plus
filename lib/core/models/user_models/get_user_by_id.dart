class UserResponse {
  final bool success;
  final String message;
  final UserData? data;
  final String? timestamp;

  UserResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
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

class UserData {
  final int id;
  final String phone;
  final String name;
  final String email;
  final String address;
  final String createdAt;

  UserData({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.address,
    required this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'address': address,
      'created_at': createdAt,
    };
  }
}
