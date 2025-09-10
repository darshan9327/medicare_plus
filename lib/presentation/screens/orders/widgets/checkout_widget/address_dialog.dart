import 'package:flutter/material.dart';

class AddressDialog extends StatefulWidget {
  final Map<String, String>? initialData;

  const AddressDialog({super.key, this.initialData});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  late TextEditingController typeController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    typeController = TextEditingController(text: widget.initialData?["type"] ?? "");
    nameController = TextEditingController(text: widget.initialData?["name"] ?? "");
    addressController = TextEditingController(text: widget.initialData?["address"] ?? "");
    phoneController = TextEditingController(text: widget.initialData?["phone"] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialData == null ? "Add New Address" : "Edit Address"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: typeController, decoration: const InputDecoration(labelText: "Type (Home/Work)")),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty && addressController.text.isNotEmpty && phoneController.text.isNotEmpty) {
              Navigator.pop(context, {
                "type": typeController.text.isNotEmpty ? typeController.text : "Home",
                "name": nameController.text,
                "address": addressController.text,
                "phone": phoneController.text,
              });
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
