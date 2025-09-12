import 'package:flutter/material.dart';
import 'package:medicare_plus/presentation/screens/common/widgets/common_container.dart';
import '../../../../../data/models/user_models/get_user_orders.dart';
import 'order_action_button.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.status.toLowerCase()) {
      case "processing":
        statusColor = Colors.blue;
        break;
      case "pending":
        statusColor = Colors.orange;
        break;
      case "completed":
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    String productList = order.items.map((item) => "Product ID: ${item.productId}").join(", ");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("#ORD${order.id}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(order.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              order.status.toLowerCase() == "completed" ? "Delivered on ${order.createdAt}" : "Placed on ${order.createdAt}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${order.items.length} items", style: const TextStyle(fontWeight: FontWeight.w500)),
                Text("₹${order.total}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 5),
            Text(productList, style: const TextStyle(color: Colors.black87)),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: CommonContainer(
                        text: "View Details",
                        color1: Colors.blue,
                        color: Colors.white,
                        onPressed: (){}
                    )
                ),
                if (order.status.toLowerCase() == "completed") const SizedBox(width: 10),
                if (order.status.toLowerCase() == "completed")
                  Expanded(
                      child: CommonContainer(
                          text: "Reorder",
                          color1: Colors.blue,
                          color: Colors.white,
                          onPressed: (){}
                      )
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
