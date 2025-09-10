class VerifyOtpResponse {
  final bool success;
  final String? message;
  final User? user;
  final String? token;
  final String? timestamp;

  VerifyOtpResponse({
    required this.success,
    this.message,
    this.user,
    this.token,
    this.timestamp,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      success: json['success'] ?? false,
      message: json['message'],
      user: json['data'] != null && json['data']['user'] != null
          ? User.fromJson(json['data']['user'])
          : null,
      token: json['data'] != null ? json['data']['token'] : null,
      timestamp: json['timestamp'],
    );
  }
}

class User {
  final int id;
  final String phone;
  final String? name;
  final String? email;

  User({
    required this.id,
    required this.phone,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
    );
  }
}
