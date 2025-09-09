class CreateUserResponse {
  final bool success;
  final String message;
  final dynamic data;
  final String? timestamp;

  CreateUserResponse({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'timestamp': timestamp,
    };
  }
}
