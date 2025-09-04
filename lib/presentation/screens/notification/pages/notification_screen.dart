import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../widgets/notification_tile.dart';

class NotificationModel {
  final String title;
  final String message;
  final String time;

  NotificationModel({required this.title, required this.message, required this.time});
}

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "🎉 Order Delivered Successfully",
      message: "Your order #ORD001233 has been delivered. Thank you for choosing MediCare+!",
      time: "2 hours ago",
    ),
    NotificationModel(
      title: "💳 Payment Successful",
      message: "Your payment of ₹201.85 for order #ORD001234 has been processed successfully.",
      time: "1 day ago",
    ),
    NotificationModel(
      title: "📋 Prescription Approved",
      message: "Your prescription for Crocin Syrup has been verified and approved by our pharmacist.",
      time: "2 days ago",
    ),
    NotificationModel(
      title: "🚚 Order Processing",
      message: "Your order #ORD001235 is being processed. We’ll notify you once it’s shipped.",
      time: "3 days ago",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonAppBar(title: "Notifications"),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationTile(notification: notifications[index]);
        },
      ),
    );
  }
}
