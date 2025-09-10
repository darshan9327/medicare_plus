import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../cart/pages/cart_screen.dart';
import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';

class UploadPrescription extends StatefulWidget {
  const UploadPrescription({super.key});

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  String? uploadedFile;
  final TextEditingController notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> pickFile(String type) async {
    if (type == "Camera") {
      final picked = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picked != null) {
        setState(() => uploadedFile = picked.path);
      }
    } else if (type == "Gallery") {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => uploadedFile = picked.path);
      }
    } else if (type == "PDF") {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null && result.files.single.path != null) {
        setState(() => uploadedFile = result.files.single.path!);
      }
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      String message = "✅ Uploaded: ${uploadedFile!.split('/').last}";

      if (notesController.text.trim().isNotEmpty) {
        message += "\n📝 Notes: ${notesController.text.trim()}";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: Duration(seconds: 1), backgroundColor: Colors.green));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Upload Prescription - "),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    boxShadow: [BoxShadow(color: Colors.orange, offset: Offset(-4, 0))],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "⚠️ This medicine requires a valid prescription. "
                        "Please upload a clear image of your prescription.",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 20),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: Colors.grey,
                  strokeWidth: 2,
                  dashPattern: const [6, 3],
                  child: Container(
                    width: SConfig.sWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text("📄", style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 10),
                        const Text("Upload Prescription", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Text("Tap to upload from Camera, Gallery or PDF", style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [_fileButton("Camera", "📷"), _fileButton("Gallery", "🖼️"), _fileButton("PDF", "📄")],
                        ),
                        if (uploadedFile == null)
                          const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text("⚠️ Please upload a prescription", style: TextStyle(color: Colors.red, fontSize: 13)),
                          ),
                        if (uploadedFile != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            "✅ Uploaded: ${uploadedFile!.split('/').last}",
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Notes (Optional)",
                    hintText: "Any additional instructions...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 30),
                CommonContainer(
                  text: "Upload & Add to Cart",
                  onPressed: () {
                    if (uploadedFile == null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text("❌ Please upload a prescription"), backgroundColor: Colors.red));
                      return;
                    }

                    // final cartController = Get.find<CartController>();
                    // cartController.addToCart(
                    //   CartItem(
                    //     name: widget.product.name,
                    //     company: widget.product.company,
                    //     price: widget.product.price,
                    //     image: widget.product.image,
                    //     requiresPrescription: widget.product.prescriptionRequired,
                    //     prescriptionFile: uploadedFile,
                    //     notes: notesController.text,
                    //   ),
                    // );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("${""} added to cart ✅"), duration: Duration(seconds: 1)));

                    Get.off(() => ShoppingCart(showOwnAppBar: true));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fileButton(String label, String text) {
    return OutlinedButton(
      onPressed: () => pickFile(label),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(fontSize: 22)),
          Text(label, style: const TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
