import 'package:flutter/material.dart';

class ProductPriceSection extends StatelessWidget {
  final String price;
  final bool prescriptionRequired;

  const ProductPriceSection({
    super.key,
    required this.price,
    required this.prescriptionRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "₹$price",
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        if (prescriptionRequired)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "Prescription Required",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
