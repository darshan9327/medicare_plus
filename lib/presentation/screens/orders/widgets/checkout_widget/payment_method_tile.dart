import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final Map<String, String> method;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentMethodTile({super.key, required this.method, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300, width: isSelected ? 2 : 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(method["emoji"]!, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text(method["name"]!, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
