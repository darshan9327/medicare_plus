import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../widgets/prescription_list_item.dart';
import '../widgets/prescription_summary_cards.dart';
import '../widgets/upload_prescription_dialog.dart';

class MyPrescriptionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> prescriptions = [
    {
      'id': '1',
      'doctorName': 'Dr. Rajesh Kumar',
      'date': '15 Mar 2024',
      'medicines': ['Paracetamol 500mg', 'Crocin Syrup'],
      'status': 'Approved',
      'validUntil': '15 Jun 2024',
      'image': '📋',
    },
    {
      'id': '2',
      'doctorName': 'Dr. Priya Sharma',
      'date': '10 Mar 2024',
      'medicines': ['Vitamin D3', 'Calcium Tablets'],
      'status': 'Expired',
      'validUntil': '10 Mar 2024',
      'image': '📋',
    },
    {
      'id': '3',
      'doctorName': 'Dr. Amit Patel',
      'date': '05 Mar 2024',
      'medicines': ['Omega 3', 'Iron Tablets'],
      'status': 'Under Review',
      'validUntil': '05 Jun 2024',
      'image': '📋',
    },
  ];

  MyPrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CommonAppBar(
        title: "My Prescriptions",
        actions: [IconButton(onPressed: () => showUploadPrescriptionDialog(context), icon: const Icon(Icons.upload_file))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrescriptionSummaryCards(total: prescriptions.length, active: 1, pending: 1),
            const SizedBox(height: 20),
            const Text('Recent Prescriptions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: prescriptions.length,
                itemBuilder: (context, index) {
                  return PrescriptionListItem(prescription: prescriptions[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showUploadPrescriptionDialog(context),
        backgroundColor: const Color(0xFF2563EB),
        label: const Text('Upload Prescription'),
        icon: const Icon(Icons.upload_file),
      ),
    );
  }
}
