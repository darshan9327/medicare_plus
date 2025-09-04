import 'package:flutter/material.dart';

import '../../../../core/models/product_models/all_product.dart';
import '../../../../data/data_source.dart';
import '../../common/utils/common_appbar.dart';
import '../../product/pages/product_details_screen.dart';
import 'medicine_list.dart';

class CategoryMedicinesScreen extends StatelessWidget {
  final String category;
  const CategoryMedicinesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final api = DataSource();

    return Scaffold(
      appBar: CommonAppBar(title: category),
      body: FutureBuilder<AllProductModel>(
        future: api.getProductsByCategory(category: category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
            return const Center(child: Text("No products found in this category"));
          }

          final productsByCategory = snapshot.data!.data!;
          return MedicineList(
            medicines: productsByCategory,
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
