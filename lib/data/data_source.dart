import 'package:dio/dio.dart';


import '../core/api_constants.dart';
import '../core/models/authentication_models/login.dart';
import '../core/models/authentication_models/register.dart';
import '../core/models/authentication_models/send_otp.dart';
import '../core/models/authentication_models/verify_otp.dart';
import '../core/models/product_models/all_product.dart';
import '../core/models/product_models/categories.dart';
import '../core/models/product_models/product_by_id.dart';
import '../core/models/product_models/search_product.dart';



class DataSource {
  late final Dio dio;

  DataSource() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseurl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  // ===================== LOGIN ===================== //

  login({required String phone, required String password}) async {
    try {
      final response = await dio.post('/api/v1/auth/login', data: {'phone': phone, 'password': password});

      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to login: ${e.response?.data ?? e.message}");
    }
  }

  // ===================== REGISTER ===================== //

  Future<RegisterModel> register({required String name, required String phone, required String email, required String password}) async {
    try {
      final response = await dio.post('/api/v1/auth/register', data: {'name': name, 'phone': phone, 'email': email, 'password': password});

      return RegisterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to register: ${e.response?.data ?? e.message}");
    }
  }

  //===================== Send Otp =====================//

  Future<SendOtpModel> sendOtp({required String phone}) async {
    try {
      final response = await dio.post('/api/v1/auth/send-otp', data: {'phone': phone});

      return SendOtpModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // ===================== Verify Otp =====================//

  Future<VerifyOtpModel> verifyOtp({required String phone, required String otp}) async {
    try {
      final response = await dio.post('/api/v1/auth/verify-otp', data: {'phone': phone, 'otp': otp});

      return VerifyOtpModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // ===================== All Product =====================//

  Future<AllProductModel> getAllProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await dio.get('/api/v1/products', queryParameters: {'page': page, 'limit': limit, 'category': '', 'sort': 'name'});
      return AllProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  //===================== Fetch Product By Category =====================//

  Future<AllProductModel> getProductsByCategory({required String category, int page = 1, int limit = 20}) async {
    try {
      final response = await dio.get('/api/v1/products', queryParameters: {'category': category, 'page': page, 'limit': limit, 'sort': 'name'});
      return AllProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load products by category: $e');
    }
  }

  //===================== Product By Id =====================//

  Future<ProductByIdModel> getProductById({required int id}) async {
    try {
      final response = await dio.get('/api/v1/products/$id');

      return ProductByIdModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product by ID: $e');
    }
  }

  //===================== Search Product =====================//

  Future<SearchProductModel> searchProducts({required String query}) async {
    try {
      final response = await dio.get('/api/v1/products/search', queryParameters: {'q': query, 'limit': 10});

      return SearchProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  //===================== Categories =====================//

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await dio.get('/api/v1/products/categories');

      // Convert JSON to CategoriesModel
      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
