class CreateUserResponse {
  final bool success;
  final String message;
  final dynamic data;
  final DateTime timestamp;

  CreateUserResponse({
    required this.success,
    required this.message,
    this.data,
    required this.timestamp,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
