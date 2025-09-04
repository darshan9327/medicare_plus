import 'package:flutter/material.dart';

class FaqList extends StatelessWidget {
  final List<Map<String, dynamic>> faqItems;
  const FaqList({super.key, required this.faqItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Frequently Asked Questions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
          ),
          child: Column(
            children:
                faqItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var faq = entry.value;
                  bool isLast = index == faqItems.length - 1;
                  return ExpansionTile(
                    title: Text(faq['question'], style: const TextStyle(fontWeight: FontWeight.w600)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: index == 0 ? const Radius.circular(15) : Radius.zero,
                        bottom: isLast ? const Radius.circular(15) : Radius.zero,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(faq['answer'], style: const TextStyle(color: Color(0xFF6B7280))),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
