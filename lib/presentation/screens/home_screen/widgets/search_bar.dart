import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Padding(padding: EdgeInsets.all(10), child: Text("🔍", style: TextStyle(fontSize: 20))),
        hintText: "Search medicines, brands",
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.grey.shade200, width: 2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
      ),
    );
  }
}
