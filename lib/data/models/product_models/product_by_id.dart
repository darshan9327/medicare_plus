class ProductByIdModel {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  ProductByIdModel({this.success, this.message, this.data, this.timestamp});

  ProductByIdModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? description;
  String? price;
  int? stock;
  String? category;
  Null imageUrl;
  bool? requiresPrescription;
  bool? active;
  String? company;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.imageUrl,
    this.requiresPrescription,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    category = json['category'];
    imageUrl = json['image_url'];
    requiresPrescription = json['requires_prescription'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    data['category'] = category;
    data['image_url'] = imageUrl;
    data['requires_prescription'] = requiresPrescription;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
