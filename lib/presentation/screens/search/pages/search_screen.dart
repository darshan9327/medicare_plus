import 'package:flutter/material.dart';

import '../widgets/filter_button.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_result_tile.dart';

class Medicine {
  final String name;
  final String company;
  final double price;
  final bool prescriptionRequired;
  final String emoji;
  final String description;

  Medicine({
    required this.name,
    required this.company,
    required this.price,
    required this.prescriptionRequired,
    required this.emoji,
    required this.description,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Medicine> medicines = [
    Medicine(
      name: "Paracetamol 500mg",
      company: "Cipla Ltd.",
      price: 45.00,
      emoji: '💊',
      description: 'Used for fever and mild pain relief',
      prescriptionRequired: false,
    ),
    Medicine(
      name: "Dolo 650mg",
      company: "Micro Labs",
      price: 32.50,
      emoji: '💊',
      description: 'Stronger dose for fever and pain.',
      prescriptionRequired: true,
    ),
    Medicine(
      name: "Cal-pol 500mg",
      company: "GSK",
      price: 28.00,
      emoji: '💊',
      description: 'Relieves fever, headache, mild pain such as body pain, toothache, cramps.',
      prescriptionRequired: false,
    ),
    Medicine(
      name: "Azithromycin 250mg",
      company: "Sun Pharma",
      price: 120.00,
      emoji: '💊',
      description: 'Antibiotic used to treat bacterial infections like respiratory infections.',
      prescriptionRequired: true,
    ),
  ];

  String searchQuery = "";
  String filter = "All";

  @override
  Widget build(BuildContext context) {
    List<Medicine> filteredList =
    medicines.where((med) {
      final matchesSearch = med.name.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesFilter =
      filter == "All"
          ? true
          : filter == "OTC"
          ? !med.prescriptionRequired
          : med.prescriptionRequired;

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
              SearchBarWidget(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 12),
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
              Text("${filteredList.length} results found", style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final med = filteredList[index];
                    return SearchResultTile(medicine: med);
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
