import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../widgets/my_order_widget/order_card.dart';

class Order {
  final String id;
  final String date;
  final String status;
  final int itemCount;
  final String price;
  final String products;

  Order({required this.id, required this.date, required this.status, required this.itemCount, required this.price, required this.products});
}

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final List<Order> orders = [
    Order(id: "#ORD001234", date: "Mar 15, 2024", status: "Processing", itemCount: 2, price: "₹201.85", products: "Paracetamol 500mg, Crocin Syrup"),
    Order(id: "#ORD001233", date: "Mar 10, 2024", status: "Completed", itemCount: 1, price: "₹125.00", products: "Band-Aid Pack"),
    Order(
      id: "#ORD001232",
      date: "Mar 5, 2024",
      status: "Pending",
      itemCount: 3,
      price: "₹399.00",
      products: "Vitamin-C Tablets, Dettol, Thermometer",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "My Orders"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text("Your order history", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: orders[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
