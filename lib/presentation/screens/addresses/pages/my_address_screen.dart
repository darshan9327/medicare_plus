import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../widgets/add_address_bottom_sheet.dart';
import '../widgets/address_list.dart';


class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  List<Map<String, dynamic>> addresses = [
    {
      'id': '1',
      'type': 'Home',
      'icon': '🏠',
      'name': 'John Doe',
      'address': '123 Main Street, Apartment 4B\nAhmedabad, Gujarat 380001',
      'phone': '+91 98765 43210',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'Office',
      'icon': '🏢',
      'name': 'John Doe',
      'address': '456 Business Park, Floor 7\nAhmedabad, Gujarat 380015',
      'phone': '+91 98765 43210',
      'isDefault': false,
    },
    {
      'id': '3',
      'type': 'Other',
      'icon': '📍',
      'name': 'Jane Doe',
      'address': '789 Residential Area\nAhmedabad, Gujarat 380009',
      'phone': '+91 87654 32109',
      'isDefault': false,
    },
  ];

  void _addAddress(Map<String, dynamic> newAddress) {
    setState(() {
      addresses.add(newAddress);
    });
  }

  void _deleteAddress(String id) {
    setState(() {
      addresses.removeWhere((address) => address['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Address deleted successfully!')));
  }

  void _setDefaultAddress(String id) {
    setState(() {
      for (var address in addresses) {
        address['isDefault'] = address['id'] == id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Default address updated!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CommonAppBar(
        title: 'My Addresses',
        actions: [IconButton(onPressed: () => showAddAddressBottomSheet(context, onSave: _addAddress), icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: AddressList(addresses: addresses, onDelete: _deleteAddress, onSetDefault: _setDefaultAddress),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddAddressBottomSheet(context, onSave: _addAddress),
        backgroundColor: const Color(0xFF2563EB),
        label: const Text('Add Address'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
