import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;
  final Function(String id) onDelete;
  final Function(String id) onSetDefault;

  const AddressCard({super.key, required this.address, required this.onDelete, required this.onSetDefault});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [const BoxShadow(blurRadius: 4, color: Colors.black12)],
        border: address['isDefault'] ? Border.all(color: const Color(0xFF2563EB), width: 2) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(address['icon'], style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(address['type'], style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2563EB))),
                if (address['isDefault']) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(12)),
                    child: const Text('Default', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF166534))),
                  ),
                ],
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'delete') {
                      onDelete(address['id']);
                    } else if (value == 'default') {
                      onSetDefault(address['id']);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        if (!address['isDefault'])
                          const PopupMenuItem<String>(
                            value: 'default',
                            child: Row(children: [Icon(Icons.star, size: 18, color: Color(0xFF6B7280)), SizedBox(width: 8), Text('Set as Default')]),
                          ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                  child: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(address['name'], style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            const SizedBox(height: 5),
            Text(address['address'], style: const TextStyle(color: Color(0xFF6B7280), height: 1.4)),
            const SizedBox(height: 5),
            Text(address['phone'], style: const TextStyle(color: Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }
}
