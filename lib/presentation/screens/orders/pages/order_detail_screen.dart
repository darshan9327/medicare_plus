import 'package:flutter/material.dart';

import '../../../../data/models/order_models/get_order_by_id.dart';
import '../../../../data/data_source.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<OrdersListResponse> _orderFuture;
  late DataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = DataSource();
    _orderFuture = _dataSource.getOrderById(widget.orderId);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: FutureBuilder<OrdersListResponse>(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text("No order details found"));
          }

          final order = snapshot.data!.data.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Order Summary"),
                        Text("Order ID: ${order.id}"),
                        Text("Placed on: ${order.createdAt}"),
                        Text(
                          "Status: ${order.status}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: order.status.toLowerCase() == "pending"
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Payment"),
                        Text("Method: ${order.paymentMethod}"),
                        Text("Status: ${order.paymentStatus}"),
                        const SizedBox(height: 8),
                        Text(
                          "Total: ₹${order.total}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (order.customerName != null || order.customerPhone != null)
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(order.customerName ?? "Unknown Customer"),
                      subtitle: Text(order.customerPhone ?? ""),
                    ),
                  ),

                const SizedBox(height: 16),

                _buildSectionTitle("Items"),
                ...order.items.map((item) => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text("Product ID: ${item.productId}"),
                    subtitle: Text("Qty: ${item.quantity}"),
                    trailing: Text("₹${item.price}"),
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
