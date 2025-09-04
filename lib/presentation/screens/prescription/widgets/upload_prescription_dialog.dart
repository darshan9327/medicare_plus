import 'package:flutter/material.dart';

void showUploadPrescriptionDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder:
        (context) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Text("Upload Prescription", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: _optionBox(context, Icons.camera_alt, "Camera", "Camera opened")),
                  const SizedBox(width: 15),
                  Expanded(child: _optionBox(context, Icons.photo_library, "Gallery", "Gallery opened")),
                  const SizedBox(width: 15),
                  Expanded(child: _optionBox(context, Icons.insert_drive_file, "PDF", "File picker opened")),
                ],
              ),
            ],
          ),
        ),
  );
}

Widget _optionBox(BuildContext context, IconData icon, String label, String snackMessage) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackMessage)));
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [Icon(icon, size: 28, color: Colors.black87), const SizedBox(height: 8), Text(label)]),
    ),
  );
}
