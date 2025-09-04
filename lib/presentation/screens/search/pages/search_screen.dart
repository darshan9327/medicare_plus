import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/product_models/search_product.dart';
import '../../../../data/data_source.dart';
import '../../product/pages/product_details_screen.dart';
import '../widgets/filter_button.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DataSource _api = DataSource();

  String searchQuery = "";
  String filter = "All";

  List<Data> _results = [];
  bool _isLoading = false;
  String _error = "";

  Future<void> _searchProducts(String query) async {
    if (query.isEmpty || query.length < 2) {
      setState(() {
        _results = [];
        _error = "";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      final response = await _api.searchProducts(query: query);
      setState(() {
        _results = response.data ?? [];
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load products: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _results.where((med) {
      final matchesSearch = med.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
      final matchesFilter = filter == "All"
          ? true
          : filter == "OTC"
          ? !(med.category?.toLowerCase().contains("prescription") ?? false)
          : (med.category?.toLowerCase().contains("prescription") ?? false);
      return matchesSearch && matchesFilter;
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search Input
              SearchBarWidget(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                  _searchProducts(value); // live search
                },
              ),
              const SizedBox(height: 12),

              // 🏷 Filter Buttons
              Row(
                children: [
                  FilterButton(label: "All", selected: filter == "All", onTap: () => setState(() => filter = "All")),
                  const SizedBox(width: 8),
                  FilterButton(label: "OTC", selected: filter == "OTC", onTap: () => setState(() => filter = "OTC")),
                  const SizedBox(width: 8),
                  FilterButton(label: "Prescription", selected: filter == "Prescription", onTap: () => setState(() => filter = "Prescription")),
                ],
              ),
              const SizedBox(height: 12),

              // Result Count
              if (!_isLoading && _results.isNotEmpty)
                Text("${filteredList.length} results found", style: const TextStyle(color: Colors.grey)),

              const SizedBox(height: 12),

              // 📋 Results / Loading / Error
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _error.isNotEmpty
                    ? Center(child: Text(_error, style: const TextStyle(color: Colors.red)))
                    : filteredList.isEmpty
                    ? const Center(child: Text("No products found"))
                    : ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final product = filteredList[index];
                    return SearchResultTile(
                      medicine: product,
                      onTap: () {
                        if (product.id != null) {
                          Get.to(() => ProductDetailPage(productId: product.id!));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
