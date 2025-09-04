import 'package:flutter/material.dart';

import '../../../../core/models/product_models/all_product.dart';
import '../../../../data/data_source.dart';
import '../../product/pages/product_details_screen.dart';
import 'medicine_list.dart';


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
          return MedicineList(
            medicines: medicines,
            onTap: (medicine) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(productId: medicine.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
