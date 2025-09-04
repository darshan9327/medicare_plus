import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/product_models/all_product.dart';
import '../../../../core/models/product_models/categories.dart';
import '../../../../data/data_source.dart';
import '../../search/widgets/search_bar.dart';
import '../widgets/all_medicines.dart';
import '../widgets/category_grid.dart';
import '../widgets/medicine_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = DataSource();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                SearchBarWidget(),
                const SizedBox(height: 20),
                const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                FutureBuilder<CategoriesModel>(
                  future: api.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                      return const Center(child: Text("No categories found"));
                    }

                    final categories = snapshot.data!.data!;
                    return CategoryGrid(categories: categories);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Popular Medicines", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => const AllMedicines());
                      },
                      child: const Text("See All >>", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FutureBuilder<AllProductModel>(
                  future: api.getAllProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                      return const Center(child: Text("No products found"));
                    }

                    final products = snapshot.data!.data!;
                    return MedicineList(medicines: products);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
