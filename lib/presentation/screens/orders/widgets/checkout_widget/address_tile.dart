import 'package:flutter/material.dart';

import '../../../common/utils/size_config.dart';
import 'address_dailog.dart';

class AddressTile extends StatelessWidget {
  final Map<String, String> address;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function(Map<String, String>) onEdit;
  final VoidCallback onDelete;

  const AddressTile({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: SConfig.sWidth,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("🏠 ${address["type"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    final updated = await showDialog<Map<String, String>>(
                      context: context,
                      builder: (context) => AddressDialog(initialData: address),
                    );
                    if (updated != null) onEdit(updated);
                  },
                  child: const Icon(Icons.edit, size: 20),
                ),

                SizedBox(width: SConfig.sWidth * 0.010),
                InkWell(onTap: onDelete, child: const Icon(Icons.delete_forever_outlined, size: 20)),
              ],
            ),
            Text(address["name"] ?? ""),
            Text(address["address"] ?? ""),
            Text(address["phone"] ?? ""),
          ],
        ),
      ),
    );
  }
}
