import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/utils/size_config.dart';
import '../controller/cart_controller.dart';


class CartItemTile extends StatelessWidget {
  final CartItem item;
  final cartController = Get.find<CartController>();

  CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item.image, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(item.company, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      Text("₹${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      if (item.requiresPrescription)
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(6)),
                          child: const Text("📄 Prescription Uploaded", style: TextStyle(fontSize: 10, color: Colors.orange)),
                        ),
                    ],
                  ),
                ),
                InkWell(onTap: () => cartController.removeFromCart(item), child: const Icon(Icons.delete_forever_outlined)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => cartController.decreaseQuantity(item),
                  icon: Container(
                    height: SConfig.sHeight * 0.030,
                    width: SConfig.sWidth * 0.065,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade300),
                    child: const Icon(Icons.remove, size: 18),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text("${item.quantity}", style: const TextStyle(fontSize: 16))),
                IconButton(
                  onPressed: () => cartController.increaseQuantity(item),
                  icon: Container(
                    height: SConfig.sHeight * 0.030,
                    width: SConfig.sWidth * 0.065,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade300),
                    child: const Icon(Icons.add, size: 18),
                  ),
                ),
                const Spacer(),
                Text("₹${item.totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
