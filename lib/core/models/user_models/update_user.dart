class UpdateUserResponse {
  final bool success;
  final String message;
  final UserData? data;
  final String? timestamp;

  UpdateUserResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
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
  final String updatedAt;

  UserData({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.address,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'address': address,
      'updated_at': updatedAt,
    };
  }
}
