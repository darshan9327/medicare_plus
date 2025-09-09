import 'package:dio/dio.dart';

import '../core/api_constants.dart';
import '../core/models/cart_models/clear_cart.dart';
import '../core/models/user_models/get_user_by_id.dart';
import '../core/models/user_models/get_user_orders.dart';
import '../core/models/user_models/update_user.dart';
import '../core/session_manager.dart';
import '../core/models/authentication_models/login.dart';
import '../core/models/authentication_models/register.dart';
import '../core/models/authentication_models/send_otp.dart';
import '../core/models/authentication_models/verify_otp.dart';
import '../core/models/cart_models/get_cart.dart';
import '../core/models/cart_models/update_cart.dart';
import '../core/models/cart_models/add_to_cart.dart';
import '../core/models/cart_models/remove_from_cart.dart';
import '../core/models/product_models/categories.dart';
import '../core/models/product_models/all_product.dart';
import '../core/models/product_models/product_by_id.dart';
import '../core/models/product_models/search_product.dart';

class DataSource {
  late final Dio dio;

  DataSource() {
    dio = Dio(
        BaseOptions(
        baseUrl: ApiConstants.baseurl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20)
        )
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sessionId = await SessionManager.getSessionId();
          if (sessionId != null) {
            options.headers["x-session-id"] = sessionId;
          }
          return handler.next(options);
        },
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
    if (query.isEmpty) {
      throw Exception("Search query cannot be empty");
    }
    try {
      final response = await dio.get(
        '/api/v1/products/search',
        queryParameters: {'q': query, 'limit': 10},
      );
      return SearchProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  //===================== Categories =====================//

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await dio.get('/api/v1/products/categories');
      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  //===================== GetCart =====================//

  Future<GetCartModel> getCart() async {
    try {
      final sessionId = await SessionManager.getSessionId();

      final response = await dio.get(
        "/api/v1/cart",
        options: Options(
          headers: {
            "x-session-id": sessionId ?? "",
          },
        ),
      );
      return GetCartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to fetch cart: ${e.response?.data ?? e.message}");
    }
  }

  // ===================== AddToCart =====================//

  Future<AddToCartModel> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await dio.post(
        "/api/v1/cart/add",
        data: {
          "productId": productId,
          "quantity": quantity,
        },
        options: Options(
          headers: {
            "x-session-id": await SessionManager.getSessionId() ?? "",
          },
        ),
      );
      final sessionId = response.headers.value("x-session-id");
      if (sessionId != null && sessionId.isNotEmpty) {
        await SessionManager.saveSessionId(sessionId);
      }

      return AddToCartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to add to cart: ${e.response?.data ?? e.message}");
    }
  }

  // ===================== UpdateCart =====================//

  Future<UpdateCartModel> updateCart({
    required int productId,
    required int quantity,
  }) async {
    final sessionId = await SessionManager.getSessionId();
    final response = await dio.put(
      "/api/v1/cart/update/$productId",
      data: {
        "quantity": quantity,
      },
      options: Options(
        headers: {
          "x-session-id": sessionId ?? "",
        },
      ),
    );
    return UpdateCartModel.fromJson(response.data);
  }

  // ===================== RemoveFromCart =====================//

  Future<RemoveFromCartModel> removeFromCart({required int productId}) async {
    try {
      final sessionId = await SessionManager.getSessionId();

      final response = await dio.delete(
        "/api/v1/cart/remove/$productId",
        options: Options(
          headers: {
            if (sessionId != null) "x-session-id": sessionId,
          },
        ),
      );

      return RemoveFromCartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to remove from cart: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }


  // ===================== RemoveFromCart =====================//

  Future<ClearCartModel> clearCart() async {
    try {
      final sessionId = await SessionManager.getSessionId();

      final response = await dio.delete(
        "/api/v1/cart/clear",
        options: Options(
          headers: {
            "x-session-id": sessionId ?? "",
          },
        ),
      );

      return ClearCartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to clear cart: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ===================== RemoveFromCart =====================//

  Future<UserResponse> getUser(int userId) async {
    try {
      final response = await dio.get("/api/v1/users/$userId");
      return UserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  // ===================== RemoveFromCart =====================//

  Future<UpdateUserResponse> updateUser({
    required int id,
    String? phone,
    String? name,
    String? email,
    String? address,
  }) async {
    try {
      final response = await dio.put(
        "/api/v1/users/$id",
        data: {
          "phone": phone,
          "name": name,
          "email": email,
          "address": address,
        },
      );

      return UpdateUserResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }

  // ===================== RemoveFromCart =====================//

  Future<OrdersResponse> getOrders({int page = 1, int limit = 10}) async {
    try {
      final response = await dio.get('/api/v1/users/', queryParameters: {
        "page": page,
        "limit": limit,
      });

      return OrdersResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  /// Get single order by ID
  Future<Order> getOrderById(int orderId) async {
    try {
      final response = await dio.get('/api/v1/users/$orderId');
      final ordersResponse = OrdersResponse.fromJson(response.data);
      if (ordersResponse.success && ordersResponse.data != null) {
        return ordersResponse.data!.orders.firstWhere((o) => o.id == orderId);
      } else {
        throw Exception("Order not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch order: $e");
    }
  }
}

