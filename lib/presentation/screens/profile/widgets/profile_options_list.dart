import 'package:flutter/material.dart';

import 'profile_option_tile.dart';

class ProfileOptionsList extends StatelessWidget {
  final VoidCallback onPersonalInfo;
  final VoidCallback onAddresses;
  final VoidCallback onOrders;
  final VoidCallback onPrescriptions;
  final VoidCallback onNotifications;
  final VoidCallback onHelpSupport;

  const ProfileOptionsList({
    super.key,
    required this.onPersonalInfo,
    required this.onAddresses,
    required this.onOrders,
    required this.onPrescriptions,
    required this.onNotifications,
    required this.onHelpSupport,
  });

  Widget _divider() => Divider(color: Colors.grey[100], height: 7, thickness: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          ProfileOptionTile(iconEmoji: '👤', title: "Personal Information", subtitle: "Name, Email, Phone", onTap: onPersonalInfo),
          _divider(),
          ProfileOptionTile(iconEmoji: '📍', title: "My Addresses", subtitle: "Manage delivery addresses", onTap: onAddresses),
          _divider(),
          ProfileOptionTile(iconEmoji: '📋', title: "My Orders", subtitle: "Manage Order Status", onTap: onOrders),
          _divider(),
          ProfileOptionTile(iconEmoji: '📋', title: "My Prescriptions", subtitle: "Uploaded prescriptions", onTap: onPrescriptions),
          _divider(),
          ProfileOptionTile(iconEmoji: '🔔', title: "Notifications", subtitle: "Manage preferences", onTap: onNotifications),
          _divider(),
          ProfileOptionTile(iconEmoji: '❓', title: "Help & Support", subtitle: "FAQs, Contact us", onTap: onHelpSupport),
        ],
      ),
    );
  }
}
