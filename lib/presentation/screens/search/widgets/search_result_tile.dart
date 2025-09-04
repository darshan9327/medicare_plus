import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/utils/size_config.dart';
import '../pages/search_screen.dart';

class SearchResultTile extends StatelessWidget {
  final Medicine medicine;

  const SearchResultTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    double containerSize = SConfig.sWidth > 800 ? 70 : 50;
    return InkWell(
      onTap: () {
        Get.to((){}
        );
      },
      child: Card(
        shadowColor: Colors.grey.shade500,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
            child: Center(child: Text("💊", style: TextStyle(fontSize: MediaQuery.of(context).size.width > 800 ? 30 : 30))),
          ),
          title: Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(medicine.company),
              Text("₹${medicine.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
              if (medicine.prescriptionRequired)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(6)),
                  child: const Text("Prescription Required", style: TextStyle(fontSize: 12, color: Colors.orange)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
