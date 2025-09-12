# 📱 Flutter API Integration Guide

**Date**: August 29, 2025  
**Backend Status**: Production Ready  
**API URL**: <https://pharmacy-backend-production-53ef.up.railway.app>

## 🔑 Step 1: Get API Key

### Option A: Via Setup Endpoint (One-time)

```bash
curl "https://pharmacy-backend-production-53ef.up.railway.app/init-setup?key=pharmacy_2025_init"
```

This will return:

```json
{
  "flutter_config": {
    "api_key": "pk_xxxxx...",
    "base_url": "https://pharmacy-backend-production-53ef.up.railway.app"
  }
}
```

### Option B: Use Existing Key (if already generated)

```dart
// Check with backend developer for the key
const String API_KEY = 'pk_xxxxxxxxx';
```

## 📋 Step 2: Flutter Configuration

### Create API Config File

```dart
// lib/config/api_config.dart

class ApiConfig {
  static const String baseUrl = 'https://pharmacy-backend-production-53ef.up.railway.app';
  static const String apiKey = 'YOUR_API_KEY_HERE'; // Replace with actual key
  
  // Headers for all API calls
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'x-publishable-api-key': apiKey,
  };
  
  // Test credentials
  static const String testPhone = '+919999999999';
  static const String testOtp = '123456';
}
```

### Setup Dio Client

```dart
// lib/services/api_service.dart

import 'package:dio/dio.dart';
import '../config/api_config.dart';

class ApiService {
  late Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: ApiConfig.headers,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ));
    
    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      request: true,
      response: true,
      error: true,
    ));
  }
  
  Dio get client => _dio;
}
```

## 🔐 Step 3: Authentication Implementation

### Send OTP

```dart
Future<void> sendOTP(String phoneNumber) async {
  try {
    final response = await apiService.client.post(
      '/store/custom/auth/send-otp',
      data: {'phone_number': phoneNumber},
    );
    
    if (response.data['success']) {
      print('OTP sent successfully');
      // In development, OTP is returned: response.data['otp']
    }
  } catch (e) {
    print('Error sending OTP: $e');
  }
}
```

### Verify OTP

```dart
Future<String?> verifyOTP(String phoneNumber, String otp) async {
  try {
    final response = await apiService.client.post(
      '/store/custom/auth/verify-otp',
      data: {
        'phone_number': phoneNumber,
        'otp_code': otp,
      },
    );
    
    if (response.data['success']) {
      String token = response.data['token'];
      // Save token for authenticated requests
      await saveToken(token);
      return token;
    }
  } catch (e) {
    print('Error verifying OTP: $e');
  }
  return null;
}
```

## 💊 Step 4: Product APIs

### List Products

```dart
Future<List<Product>> getProducts({int limit = 20, int offset = 0}) async {
  try {
    final response = await apiService.client.get(
      '/store/products',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    
    List products = response.data['products'];
    return products.map((p) => Product.fromJson(p)).toList();
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}
```

### Search Products

```dart
Future<List<Product>> searchProducts(String query) async {
  try {
    final response = await apiService.client.get(
      '/store/products',
      queryParameters: {'q': query},
    );
    
    return (response.data['products'] as List)
      .map((p) => Product.fromJson(p))
      .toList();
  } catch (e) {
    return [];
  }
}
```

## 🛒 Step 5: Cart Management

### Create Cart

```dart
Future<String?> createCart() async {
  try {
    final response = await apiService.client.post(
      '/store/carts',
      data: {
        'region_id': 'reg_01K3F0X16BFF3AD7AX9MQ8QRRF', // India region
      },
    );
    
    return response.data['cart']['id'];
  } catch (e) {
    print('Error creating cart: $e');
    return null;
  }
}
```

### Add Item to Cart

```dart
Future<void> addToCart(String cartId, String variantId, int quantity) async {
  try {
    await apiService.client.post(
      '/store/carts/$cartId/line-items',
      data: {
        'variant_id': variantId,
        'quantity': quantity,
      },
    );
    print('Item added to cart');
  } catch (e) {
    print('Error adding to cart: $e');
  }
}
```

## 📄 Step 6: Prescription Upload

### Upload Prescription (Multipart)

```dart
Future<String?> uploadPrescription(File prescriptionFile) async {
  try {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        prescriptionFile.path,
        filename: 'prescription.jpg',
      ),
      'customer_id': currentUserId,
      'doctor_name': 'Dr. Smith',
      'patient_name': 'John Doe',
      'patient_age': '30',
      'prescription_date': DateTime.now().toIso8601String(),
    });
    
    final response = await apiService.client.post(
      '/store/custom/prescriptions/upload',
      data: formData,
    );
    
    return response.data['prescription']['id'];
  } catch (e) {
    print('Error uploading prescription: $e');
    return null;
  }
}
```

## 💳 Step 7: Payment Integration

### Create Payment Order

```dart
Future<Map<String, dynamic>?> createPaymentOrder(int amount, String cartId) async {
  try {
    final response = await apiService.client.post(
      '/store/custom/payment/create-order',
      data: {
        'amount': amount, // Amount in paise
        'currency': 'INR',
        'receipt': 'receipt_${DateTime.now().millisecondsSinceEpoch}',
        'cart_id': cartId,
      },
    );
    
    return response.data['order'];
  } catch (e) {
    print('Error creating payment order: $e');
    return null;
  }
}
```

### Verify Payment

```dart
Future<bool> verifyPayment(String orderId, String paymentId, String signature) async {
  try {
    final response = await apiService.client.post(
      '/store/custom/payment/verify',
      data: {
        'razorpay_order_id': orderId,
        'razorpay_payment_id': paymentId,
        'razorpay_signature': signature,
      },
    );
    
    return response.data['success'] == true;
  } catch (e) {
    print('Error verifying payment: $e');
    return false;
  }
}
```

## 📦 Step 8: Order Management

### Get Orders

```dart
Future<List<Order>> getMyOrders() async {
  try {
    final response = await apiService.client.get(
      '/store/custom/orders',
      queryParameters: {
        'customer_id': currentUserId,
        'limit': 10,
      },
    );
    
    return (response.data['orders'] as List)
      .map((o) => Order.fromJson(o))
      .toList();
  } catch (e) {
    return [];
  }
}
```

### Track Order

```dart
Future<OrderTracking?> trackOrder(String orderId) async {
  try {
    final response = await apiService.client.get(
      '/store/custom/orders/$orderId/track',
    );
    
    return OrderTracking.fromJson(response.data['tracking']);
  } catch (e) {
    return null;
  }
}
```

## 🧪 Testing Checklist

### 1. Basic Health Check

```dart
// Test if server is running
final response = await Dio().get('$baseUrl/health');
print(response.data); // Should return {"status": "healthy"}
```

### 2. Test Authentication Flow

```dart
// 1. Send OTP
await sendOTP('+919999999999');

// 2. Verify with test OTP
String? token = await verifyOTP('+919999999999', '123456');
assert(token != null);
```

### 3. Test Product Listing

```dart
// Should return products
List<Product> products = await getProducts();
assert(products.isNotEmpty);
```

### 4. Complete Order Flow Test

```dart
// 1. Create cart
String cartId = await createCart();

// 2. Add products
await addToCart(cartId, 'variant_id', 1);

// 3. Upload prescription (if required)
String prescriptionId = await uploadPrescription(file);

// 4. Create payment order
var paymentOrder = await createPaymentOrder(10000, cartId);

// 5. After Razorpay payment
bool verified = await verifyPayment(orderId, paymentId, signature);
```

## ⚠️ Important Notes

### Error Handling

```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
}

// In API calls
try {
  // API call
} on DioError catch (e) {
  if (e.response?.statusCode == 400) {
    throw ApiException(e.response?.data['message'] ?? 'Bad request', 400);
  }
  // Handle other errors
}
```

### Token Management

```dart
// Save token after login
await SharedPreferences.getInstance().then((prefs) {
  prefs.setString('auth_token', token);
});

// Add token to authenticated requests
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) async {
    final token = await getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  },
));
```

### Schedule X Drug Blocking

```dart
// These products will return error if added to cart
if (product.metadata['schedule_type'] == 'X') {
  showError('Schedule X drugs cannot be sold online');
  return;
}
```

## 📞 Support

### Backend Issues

- Check server status: <https://pharmacy-backend-production-53ef.up.railway.app/health>
- Contact backend developer for API key or issues

### Test Data

- Phone: +919999999999
- OTP: 123456
- Test products available in `/store/products` endpoint

### Common Issues & Solutions

1. **"Publishable API key required" error**
   - Make sure `x-publishable-api-key` header is set
   - Verify API key is correct

2. **"Prescription required" error**
   - Upload prescription first using `/store/custom/prescriptions/upload`
   - Apply prescription to cart before checkout

3. **Connection timeout**
   - Check internet connection
   - Verify server is running: `/health` endpoint

---

**Last Updated**: August 29, 2025  
**Backend Version**: v1.3  
**API Endpoints**: 30+  
**Status**: Production Ready 🚀
