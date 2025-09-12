import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_orders_screen.dart';
import 'secure_payment_screen.dart';
import '../widgets/checkout_widget/address_dialog.dart';
import '../widgets/checkout_widget/address_tile.dart';
import '../widgets/checkout_widget/coupon_field.dart';
import '../widgets/checkout_widget/order_summary.dart';
import '../widgets/checkout_widget/payment_method_tile.dart';
import '../../cart/controller/cart_controller.dart';
import '../../common/widgets/common_container.dart';
import '../../common/utils/common_appbar.dart';
import '../../../../data/data_source.dart';
import '../../../../core/session_manager.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final DataSource api = DataSource();
  final TextEditingController couponController = TextEditingController();
  final cartController = Get.find<CartController>();
  double? finalAmount;
  int selectedPaymentIndex = 0;
  int selectedAddressIndex = 0;

  List<Map<String, String>> addresses = [
    {
      "type": "Home",
      "name": "John Doe",
      "address": "123 Main Street, Apartment 4B Ahmedabad, Gujarat 380001",
      "phone": "+91 98765 43210"
    },
  ];

  List<Map<String, String>> paymentMethods = [
    {"name": "UPI", "emoji": "💳"},
    {"name": "Card", "emoji": "💰"},
    {"name": "Net Banking", "emoji": "🏦"},
    {"name": "COD", "emoji": "💵"},
  ];

  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    finalAmount = widget.totalAmount;
  }

  Future<void> _placeOrder() async {
    if (_isPlacingOrder) return;
    setState(() => _isPlacingOrder = true);

    try {
      final userId = await SessionManager.getUserId() ?? 0;
      final sessionId = await SessionManager.getSessionId() ?? "";

      print("👤 Current User ID placing order: $userId");
      print("🔑 Current Session ID: $sessionId");

      final cartItems = cartController.cartItems.map((item) => {
        "productId": item.id,
        "quantity": item.quantity,
        "price": item.price,
        "prescription_url": item.prescriptionFile ?? "",
        "notes": item.notes ?? "",
      }).toList();

      final payload = {
        "total": finalAmount!.toStringAsFixed(2),
        "status": "Confirmed",
        "payment_method": paymentMethods[selectedPaymentIndex]['name'],
        "payment_status": "Paid",
        "delivery_address": addresses[selectedAddressIndex]['address'],
        "phone_number": addresses[selectedAddressIndex]['phone'],
        "items": cartItems,
      };

      print("🛒 Creating order with payload: $payload");

      final response = await api.createOrder(payload);

      print("✅ API Response: ${response.toJson()}");

      if (response.success && response.data != null) {
        final createdOrder = response.data!.order;

        print("🎉 Created Order ID: ${createdOrder.id}");
        print("🕒 Created At: ${createdOrder.createdAt}");
        print("📦 Items: ${createdOrder.items.map((e) => e.toJson()).toList()}");
        print("✅ Order created successfully for user $userId with session $sessionId");

        Get.offAll(() => SecurePayment(
          order: createdOrder,
          totalAmount: finalAmount!,
          onPaymentComplete: () {
            Get.offAll(() => MyOrders(newOrder: createdOrder));
          },
        ));
      } else {
        print("❌ Order failed: ${response.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order failed: ${response.message}")),
        );
      }
    } catch (e) {
      print("🔥 Exception while creating order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order failed: $e")),
      );
    } finally {
      setState(() => _isPlacingOrder = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 6;
    } else if (screenWidth > 800) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 2;
    }

    return Scaffold(
      appBar: CommonAppBar(title: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Delivery Address",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              ...List.generate(addresses.length, (index) {
                return AddressTile(
                  address: addresses[index],
                  isSelected: selectedAddressIndex == index,
                  onSelect: () {
                    setState(() => selectedAddressIndex = index);
                  },
                  onEdit: (updated) {
                    setState(() => addresses[index] = updated);
                  },
                  onDelete: () {
                    setState(() {
                      addresses.removeAt(index);
                      if (selectedAddressIndex >= addresses.length) {
                        selectedAddressIndex =
                        addresses.isEmpty ? 0 : addresses.length - 1;
                      }
                    });
                  },
                );
              }),
              CommonContainer(
                text: "Add New Address",
                color: Colors.white,
                color1: Colors.blue,
                onPressed: () async {
                  final newAddress = await showDialog<Map<String, String>>(
                    context: context,
                    builder: (context) => const AddressDialog(),
                  );
                  if (newAddress != null) {
                    setState(() {
                      addresses.add(newAddress);
                      selectedAddressIndex = addresses.length - 1;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text("Payment Method",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentMethods.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.9,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: crossAxisCount,
                ),
                itemBuilder: (context, index) {
                  return PaymentMethodTile(
                    method: paymentMethods[index],
                    isSelected: selectedPaymentIndex == index,
                    onSelect: () =>
                        setState(() => selectedPaymentIndex = index),
                  );
                },
              ),
              const SizedBox(height: 20),
              CouponField(
                controller: couponController,
                onApply: () {
                  if (couponController.text.trim().toUpperCase() ==
                      "DISCOUNT10") {
                    setState(() {
                      finalAmount = widget.totalAmount * 0.9;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("10% Discount Applied")));
                  }
                },
              ),
              const SizedBox(height: 20),
              OrderSummary(
                finalAmount: finalAmount ?? widget.totalAmount,
                onPlaceOrder: _placeOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
