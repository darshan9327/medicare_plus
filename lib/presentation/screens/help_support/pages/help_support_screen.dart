import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../../live_chat/page/live_chat_screen.dart';
import '../widgets/app_info.dart';
import '../widgets/contact_info.dart';
import '../widgets/faq_list.dart';
import '../widgets/quick_actions.dart';



class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  final List<Map<String, dynamic>> faqItems = [
    {'question': 'How to upload a prescription?', 'answer': 'Go to any prescription medicine and tap "Upload Prescription".'},
    {'question': 'What is the delivery time?', 'answer': 'Standard delivery 2-4 hours. Express: 30-60 mins.'},
    {'question': 'How to cancel an order?', 'answer': 'Cancel within 10 minutes from "My Orders".'},
    {'question': 'What payment methods?', 'answer': 'UPI, Cards, Net Banking, COD.'},
    {'question': 'How to track my order?', 'answer': 'Check "My Orders" or SMS tracking link.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CommonAppBar(title: 'Help & Support'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuickActions(
              onLiveChat: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveChatScreen()));
              },
            ),
            const SizedBox(height: 30),
            FaqList(faqItems: faqItems),
            const SizedBox(height: 30),
            const ContactInfo(),
            const SizedBox(height: 30),
            const AppInfo(),
          ],
        ),
      ),
    );
  }
}
