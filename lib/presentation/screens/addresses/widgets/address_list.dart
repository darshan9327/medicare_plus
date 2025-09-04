import 'package:flutter/material.dart';

import 'address_card.dart';

class AddressList extends StatelessWidget {
  final List<Map<String, dynamic>> addresses;
  final Function(String id) onDelete;
  final Function(String id) onSetDefault;

  const AddressList({super.key, required this.addresses, required this.onDelete, required this.onSetDefault});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${addresses.length} saved addresses', style: const TextStyle(color: Color(0xFF6B7280))),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return AddressCard(address: address, onDelete: onDelete, onSetDefault: onSetDefault);
            },
          ),
        ),
      ],
    );
  }
}
