class SendOtpModel {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  SendOtpModel({this.success, this.message, this.data, this.timestamp});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class Data {
  String? message;
  int? expiresIn;
  String? otp;
  bool? testMode;

  Data({this.message, this.expiresIn, this.otp, this.testMode});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    expiresIn = json['expiresIn'];
    otp = json['otp'];
    testMode = json['testMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['expiresIn'] = expiresIn;
    data['otp'] = otp;
    data['testMode'] = testMode;
    return data;
  }
}
