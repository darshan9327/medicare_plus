# 📚 Pharmacy Backend API - Comprehensive Documentation

**Version**: 2.0.0  
**Last Updated**: September 3, 2025  
**Status**: ✅ **PRODUCTION READY**

## 🌐 API Endpoints

### Production (Render) ⭐

```
Base URL: https://pharmacy-api-va75.onrender.com
Health Check: https://pharmacy-api-va75.onrender.com/health
```

### Development (Local)

```
Base URL: http://localhost:9001
Health Check: http://localhost:9001/health
```

### Deprecated

```
Railway: https://pharmacyapp-production.up.railway.app (DO NOT USE)
```

## 🔑 Authentication System

### OTP-Based Authentication

#### 1. Send OTP

```http
POST /api/v1/auth/send-otp
Content-Type: application/json

{
  "phone": "9999999999"
}

Response:
{
  "success": true,
  "data": {
    "message": "OTP sent successfully",
    "expiresIn": 600,  // 10 minutes
    "otp": "123456",    // Visible in TEST_MODE
    "testMode": true
  }
}
```

#### 2. Verify OTP

```http
POST /api/v1/auth/verify-otp
Content-Type: application/json

{
  "phone": "9999999999",
  "otp": "123456"  // Universal test OTP in production
}

Response:
{
  "success": true,
  "data": {
    "user": {
      "id": 1,
      "phone": "9999999999",
      "name": "Demo User"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR..."  // JWT valid for 7 days
  }
}
```

### Password-Based Authentication

#### Register

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "phone": "9876543210",
  "name": "New User",
  "email": "user@example.com",
  "password": "password123"
}
```

#### Login

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "phone": "9876543210",
  "password": "password123"
}
```

## 💊 Products API

### Get All Products

```http
GET /api/v1/products?page=1&limit=20&category=&sort=name

Response:
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Paracetamol 500mg",
      "description": "Fever and pain relief",
      "price": 25.00,
      "stock": 100,
      "category": "Pain Relief",
      "image_url": "https://...",
      "requires_prescription": false
    }
    // ... 79 more products
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 80,
    "totalPages": 4
  }
}
```

### Get Product by ID

```http
GET /api/v1/products/1

Response:
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Paracetamol 500mg",
    "description": "Fever and pain relief",
    "price": 25.00,
    "stock": 100,
    "category": "Pain Relief"
  }
}
```

### Search Products

```http
GET /api/v1/products/search?q=vitamin&limit=10

Response:
{
  "success": true,
  "data": [
    // Products matching "vitamin"
  ]
}
```

### Get Categories

```http
GET /api/v1/products/categories

Response:
{
  "success": true,
  "data": [
    {
      "category": "Pain Relief",
      "count": 10
    },
    {
      "category": "Antibiotics",
      "count": 10
    },
    {
      "category": "Vitamins",
      "count": 10
    }
    // ... 6 more categories
  ]
}
```

## 🛒 Cart Management

### Session-Based Cart System

All cart operations require session header:

```
x-session-id: unique-session-id
```

#### Get Cart

```http
GET /api/v1/cart
x-session-id: test-session-123

Response:
{
  "success": true,
  "data": {
    "items": [
      {
        "cartId": 1,
        "productId": 1,
        "productName": "Paracetamol",
        "price": 25.00,
        "quantity": 2,
        "subtotal": 50.00
      }
    ],
    "total": 50.00,
    "itemCount": 1
  }
}
```

#### Add to Cart

```http
POST /api/v1/cart/add
x-session-id: test-session-123
Content-Type: application/json

{
  "productId": 1,
  "quantity": 2
}
```

#### Update Cart Item

```http
PUT /api/v1/cart/update/1
x-session-id: test-session-123
Content-Type: application/json

{
  "quantity": 3
}
```

#### Remove from Cart

```http
DELETE /api/v1/cart/remove/1
x-session-id: test-session-123
```

#### Clear Cart

```http
DELETE /api/v1/cart/clear
x-session-id: test-session-123
```

#### Get Cart Summary

```http
GET /api/v1/cart/summary
x-session-id: test-session-123

Response:
{
  "success": true,
  "data": {
    "itemCount": 3,
    "totalQuantity": 7,
    "total": 250.00
  }
}
```

## 📦 Orders API

### Create Order

```http
POST /api/v1/orders
Content-Type: application/json

{
  "userId": 1,
  "items": [
    {
      "productId": 1,
      "quantity": 2,
      "price": 25.00
    }
  ],
  "deliveryAddress": "123 Main St, City, 400001",
  "phoneNumber": "9999999999",
  "prescriptionUrl": "",
  "paymentMethod": "COD",
  "notes": "Deliver between 10 AM - 6 PM"
}

Response:
{
  "success": true,
  "data": {
    "id": 1,
    "orderNumber": "ORD-20250903-001",
    "status": "pending",
    "total": 50.00,
    "createdAt": "2025-09-03T08:00:00.000Z"
  }
}
```

### Get Order by ID

```http
GET /api/v1/orders/1

Response:
{
  "success": true,
  "data": {
    "id": 1,
    "orderNumber": "ORD-20250903-001",
    "userId": 1,
    "items": [...],
    "total": 50.00,
    "status": "pending",
    "deliveryAddress": "123 Main St, City",
    "paymentMethod": "COD"
  }
}
```

### Get All Orders (Admin)

```http
GET /api/v1/orders?page=1&limit=20&status=pending
Authorization: Bearer {admin_token}
```

### Update Order Status (Admin)

```http
PUT /api/v1/orders/1/status
Authorization: Bearer {admin_token}
Content-Type: application/json

{
  "status": "confirmed"
}

Status Options:
- pending
- confirmed
- processing
- shipped
- delivered
- cancelled
```

### Upload Prescription

```http
POST /api/v1/orders/1/prescription
Content-Type: application/json

{
  "prescriptionUrl": "https://example.com/prescription.jpg"
}
```

## 👤 User Management

### Get User by ID

```http
GET /api/v1/users/1

Response:
{
  "success": true,
  "data": {
    "id": 1,
    "phone": "9999999999",
    "name": "Demo User",
    "email": "demo@pharmacy.com",
    "address": "123 Main St",
    "createdAt": "2025-08-25T10:00:00.000Z"
  }
}
```

### Create User

```http
POST /api/v1/users
Content-Type: application/json

{
  "phone": "9876543211",
  "name": "New User",
  "email": "new@example.com",
  "address": "456 Street, City",
  "password": "password123"
}
```

### Update User

```http
PUT /api/v1/users/1
Content-Type: application/json

{
  "name": "Updated Name",
  "email": "updated@example.com",
  "address": "New Address, City"
}
```

### Get User Orders

```http
GET /api/v1/users/1/orders?page=1&limit=10

Response:
{
  "success": true,
  "data": [
    // User's order history
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 5
  }
}
```

## 🧪 Test Data

### Test Users

| Phone | Password | Name | Role |
|-------|----------|------|------|
| 9999999999 | - | Demo User | Customer |
| 9876543210 | password123 | Test User | Customer |

### Test OTP

```
Universal Test OTP: 123456
Works for any phone number when TEST_MODE=true
```

### Sample Product IDs

| ID | Name | Category | Price |
|----|------|----------|-------|
| 1 | Paracetamol 500mg | Pain Relief | ₹25 |
| 2 | Amoxicillin 250mg | Antibiotics | ₹120 |
| 3 | Vitamin C 500mg | Vitamins | ₹35 |
| 11 | Cough Syrup | Cold & Flu | ₹85 |
| 21 | Blood Glucose Meter | Devices | ₹1200 |

## 📊 Response Format

### Success Response

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {
    // Response data
  },
  "timestamp": "2025-09-03T08:00:00.000Z"
}
```

### Error Response

```json
{
  "success": false,
  "message": "Error description",
  "errors": {
    "field": ["validation error"]
  },
  "timestamp": "2025-09-03T08:00:00.000Z"
}
```

### HTTP Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 404 | Not Found |
| 409 | Conflict |
| 500 | Server Error |

## 🚀 Quick Start

### 1. Import Postman Collection

- Import: `2025-09-03_pharmacy_backend_postman_collection.json`
- Import: `2025-09-03_pharmacy_backend_environments.json`
- Select: "Production (Render)" environment

### 2. Test Authentication

```bash
# Send OTP
curl -X POST https://pharmacy-api-va75.onrender.com/api/v1/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone":"9999999999"}'

# Verify OTP
curl -X POST https://pharmacy-api-va75.onrender.com/api/v1/auth/verify-otp \
  -H "Content-Type: application/json" \
  -d '{"phone":"9999999999","otp":"123456"}'
```

### 3. Get Products

```bash
curl https://pharmacy-api-va75.onrender.com/api/v1/products
```

## 🔧 Environment Variables

### Production

```env
NODE_ENV=production
PORT=9001
DATABASE_URL=postgresql://...
TEST_MODE=true
JWT_SECRET=pharmacy-secret-key
JWT_EXPIRES_IN=7d
```

### Development

```env
NODE_ENV=development
PORT=9001
DATABASE_URL=postgresql://localhost:5432/pharmacy
TEST_MODE=true
```

## 📈 Performance Metrics

| Endpoint | Average Response Time | Status |
|----------|----------------------|--------|
| Health Check | < 100ms | ✅ |
| Products List | < 300ms | ✅ |
| Product Search | < 250ms | ✅ |
| Authentication | < 400ms | ✅ |
| Cart Operations | < 300ms | ✅ |
| Order Creation | < 500ms | ✅ |

## 🔄 Recent Updates

### September 3, 2025

- ✅ OTP expiry increased to 10 minutes
- ✅ Test OTP works without sending first
- ✅ Migrated from Railway to Render
- ✅ Added comprehensive test scripts

### September 1, 2025

- ✅ Backend v2 deployed successfully
- ✅ 80 products loaded in database
- ✅ All 26 endpoints functional

## 📞 Support

For API issues:

1. Check health endpoint: <https://pharmacy-api-va75.onrender.com/health>
2. Verify TEST_MODE is enabled for testing
3. Use test credentials provided above
4. Check Postman collection for examples

## 🎯 Summary

- **Total Endpoints**: 26
- **Products Available**: 80
- **Categories**: 9
- **Authentication**: OTP-based with test mode
- **Database**: PostgreSQL (Neon)
- **Platform**: Render.com
- **Region**: Singapore
- **Status**: PRODUCTION READY ✅

---

**Documentation Version**: 2.0.0  
**API Version**: 2.0.0  
**Backend**: Express (backend_v2)  
**Production URL**: <https://pharmacy-api-va75.onrender.com>
