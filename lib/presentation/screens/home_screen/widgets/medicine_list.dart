import 'package:flutter/material.dart';
import '../../../../data/models/product_models/all_product.dart';

class MedicineList extends StatelessWidget {
  final List<Data> medicines;
  final void Function(Data)? onTap;

  const MedicineList({super.key, required this.medicines, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "No medicines available",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: medicines.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return ListTile(
          onTap: () => onTap?.call(medicine),
          leading: const Icon(Icons.medical_services, color: Colors.blue),
          title: Text(medicine.name ?? "Unknown"),
          subtitle: Text("₹${medicine.price ?? '--'}"),
          trailing: medicine.stock != null
              ? Text(
            "Stock: ${medicine.stock}",
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          )
              : null,
        );
      },
    );
  }
}
