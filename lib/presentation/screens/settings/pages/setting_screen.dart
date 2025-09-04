import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../../help_support/pages/help_support_screen.dart';
import '../../profile_information/page/profile_information_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _orderUpdates = true;
  bool _promotionalNotifications = false;
  bool _reminderNotifications = true;
  bool _darkMode = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'INR (₹)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: CommonAppBar(title: "Settings"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsSection('Account Settings', [
              _buildSettingsItem(
                '👤',
                'Edit Profile',
                'Update your personal information',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileInformation())),
              ),
              _buildSettingsItem('🔒', 'Change Password', 'Update your account password'),
              _buildSettingsItem('📱', 'Two-Factor Authentication', 'Secure your account'),
              _buildSettingsItem('🔗', 'Connected Accounts', 'Google, Facebook'),
            ]),
            _buildSettingsSection('Notifications', [
              _buildSwitchItem(
                '🔔',
                'Push Notifications',
                'Enable/disable all notifications',
                _notificationsEnabled,
                    (v) => setState(() => _notificationsEnabled = v),
              ),
              _buildSwitchItem('📦', 'Order Updates', 'Get notified about order status', _orderUpdates, (v) => setState(() => _orderUpdates = v)),
              _buildSwitchItem(
                '🎉',
                'Promotional Offers',
                'Receive offers and discounts',
                _promotionalNotifications,
                    (v) => setState(() => _promotionalNotifications = v),
              ),
              _buildSwitchItem(
                '⏰',
                'Medicine Reminders',
                'Medication reminder alerts',
                _reminderNotifications,
                    (v) => setState(() => _reminderNotifications = v),
              ),
            ]),
            _buildSettingsSection('App Preferences', [
              _buildSwitchItem('🌙', 'Dark Mode', 'Switch to dark theme', _darkMode, (v) => setState(() => _darkMode = v)),
              _buildDropdownItem('🌐', 'Language', _selectedLanguage, [
                'English',
                'Hindi',
                'Gujarati',
              ], (v) => setState(() => _selectedLanguage = v!)),
              _buildDropdownItem('💰', 'Currency', _selectedCurrency, [
                'INR (₹)',
                'USD (\$)',
                'EUR (€)',
              ], (v) => setState(() => _selectedCurrency = v!)),
              _buildSettingsItem('📍', 'Location Services', 'Allow location access for delivery'),
            ]),
            _buildSettingsSection('Privacy & Security', [
              _buildSettingsItem('🛡️', 'Privacy Settings', 'Manage your data privacy'),
              _buildSettingsItem('📊', 'Data Usage', 'View your data consumption'),
              _buildSettingsItem('🗑️', 'Clear Cache', 'Free up storage space'),
              _buildSettingsItem('⬇️', 'Download My Data', 'Export your account data'),
            ]),
            _buildSettingsSection('Support', [
              _buildSettingsItem(
                '❓',
                'Help Center',
                'FAQs and support articles',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen())),
              ),
              _buildSettingsItem('💬', 'Contact Support', 'Get help from our team'),
              _buildSettingsItem('⭐', 'Rate App', 'Rate us on app store'),
              _buildSettingsItem('📤', 'Share App', 'Share with friends'),
            ]),
            _buildSettingsSection('About', [
              _buildSettingsItem('ℹ️', 'App Version', 'v2.1.0'),
              _buildSettingsItem('📜', 'Terms of Service', 'Read our terms'),
              _buildSettingsItem('🔒', 'Privacy Policy', 'Read our privacy policy'),
              _buildSettingsItem('📄', 'Licenses', 'Open source licenses'),
            ]),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
            ),
            child: Column(
              children:
              items.asMap().entries.map((entry) {
                int index = entry.key;
                Widget item = entry.value;
                bool isLast = index == items.length - 1;

                return Column(children: [item, if (!isLast) Divider(height: 1, color: Color(0xFFF3F4F6))]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String emoji, String title, String subtitle, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text(emoji, style: TextStyle(fontSize: 18))),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                  Text(subtitle, style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String emoji, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 18))),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                Text(subtitle, style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(String emoji, String title, String currentValue, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 18))),
          ),
          SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827)))),
          DropdownButton<String>(
            value: currentValue,
            underline: SizedBox(),
            items:
            options.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
