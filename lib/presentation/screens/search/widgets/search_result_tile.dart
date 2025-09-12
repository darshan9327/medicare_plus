import 'package:flutter/material.dart';
import '../../../../data/models/product_models/search_product.dart';
import '../../common/utils/size_config.dart';

class SearchResultTile extends StatelessWidget {
  final Data medicine;
  final VoidCallback onTap;

  const SearchResultTile({
    super.key,
    required this.medicine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = SConfig.sWidth > 800 ? 70 : 50;

    return InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.grey.shade500,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Center(
              child: medicine.imageUrl != null && medicine.imageUrl!.isNotEmpty
                  ? Image.network(
                medicine.imageUrl!,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              )
                  : const Text("💊", style: TextStyle(fontSize: 28)),
            ),
          ),
          title: Text(
            medicine.name ?? "Unknown",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medicine.category != null)
                Text(medicine.category!, style: const TextStyle(color: Colors.grey)),
              Text(
                "₹${medicine.price ?? "--"}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
