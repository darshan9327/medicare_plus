import 'package:flutter/material.dart';

import '../../../../core/models/product_models/all_product.dart';
import '../../../../data/data_source.dart';


class AllMedicines extends StatefulWidget {
  const AllMedicines({super.key});

  @override
  State<AllMedicines> createState() => _AllMedicinesState();
}

class _AllMedicinesState extends State<AllMedicines> {
  final api = DataSource();
  late Future<AllProductModel> allMedicines;

  @override
  void initState() {
    super.initState();
    allMedicines = api.getAllProducts(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Medicines")),
      body: FutureBuilder<AllProductModel>(
        future: allMedicines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data == null) {
            return const Center(child: Text("No medicines available"));
          }
          final medicines = snapshot.data!.data!;
          medicines.sort((a, b) => (a.name ?? "").toLowerCase().compareTo((b.name ?? "").toLowerCase()));

          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.medical_services, color: Colors.blue),
                  title: Text(medicine.name ?? "Unknown"),
                  subtitle: Text("₹${medicine.price ?? '--'} • ${medicine.category ?? ''}"),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => MedicineDetailPage(id: medicine.id!)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
