import 'package:flutter/material.dart';

class PrescriptionListItem extends StatelessWidget {
  final Map<String, dynamic> prescription;

  const PrescriptionListItem({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    Color statusColor =
        prescription['status'] == 'Approved'
            ? const Color(0xFF16A34A)
            : prescription['status'] == 'Under Review'
            ? const Color(0xFFD97706)
            : const Color(0xFFEF4444);

    Color bgColor =
        prescription['status'] == 'Approved'
            ? const Color(0xFFDCFCE7)
            : prescription['status'] == 'Under Review'
            ? const Color(0xFFFEF3C7)
            : const Color(0xFFFEE2E2);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(prescription['image'], style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prescription['doctorName'], style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                    const SizedBox(height: 2),
                    Text(prescription['date'], style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
                child: Text(prescription['status'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor)),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Medicines
          const Text("Medicines:", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
          const SizedBox(height: 5),
          Text(prescription['medicines'].join(', '), style: const TextStyle(color: Color(0xFF6B7280))),

          const SizedBox(height: 10),

          /// Validity + Button
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 5),
              Text("Valid until: ${prescription['validUntil']}", style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("View Details", style: TextStyle(color: Color(0xFF2563EB)))),
            ],
          ),
        ],
      ),
    );
  }
}
