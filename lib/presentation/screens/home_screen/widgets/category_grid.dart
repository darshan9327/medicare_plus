import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/product_models/categories.dart';
import 'category_medicine_screen.dart';

class CategoryGrid extends StatelessWidget {
  final List<Data> categories;
  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text("No categories available"));
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 6 : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return InkWell(
          onTap: () {
            Get.to(() => CategoryMedicinesScreen(category: category.category ?? ""));
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.category ?? "Unknown",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                if (category.count != null)
                  Text(
                    "${category.count} products",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
