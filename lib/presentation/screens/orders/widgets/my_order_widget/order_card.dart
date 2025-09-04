import 'package:flutter/material.dart';

import '../../pages/my_orders_screen.dart';
import 'order_action_button.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.status) {
      case "Processing":
        statusColor = Colors.blue;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.15), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(order.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(order.status == "Completed" ? "Delivered on ${order.date}" : "Placed on ${order.date}", style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${order.itemCount} items", style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(order.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 5),
            Text(order.products, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: OrderActionButton(text: "View Details", color: Colors.blue, isOutlined: true)),
                if (order.status == "Completed") const SizedBox(width: 10),
                if (order.status == "Completed") Expanded(child: OrderActionButton(text: "Reorder", color: Colors.blue, isOutlined: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
