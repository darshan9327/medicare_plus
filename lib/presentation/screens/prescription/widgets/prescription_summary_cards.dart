import 'package:flutter/material.dart';

class PrescriptionSummaryCards extends StatelessWidget {
  final int total;
  final int active;
  final int pending;

  const PrescriptionSummaryCards({super.key, required this.total, required this.active, required this.pending});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard(Icons.description, total.toString(), "Total", const Color(0xFF2563EB), const Color(0xFFEFF6FF)),
        const SizedBox(width: 15),
        _buildCard(Icons.check_circle, active.toString(), "Active", const Color(0xFF16A34A), const Color(0xFFDCFCE7)),
        const SizedBox(width: 15),
        _buildCard(Icons.schedule, pending.toString(), "Pending", const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      ],
    );
  }

  Widget _buildCard(IconData icon, String value, String label, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withValues(alpha: 0.3))),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
