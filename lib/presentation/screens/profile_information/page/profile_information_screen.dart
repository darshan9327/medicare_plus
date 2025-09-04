import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../widgets/emergency_contact_card.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_dropdown.dart';
import '../widgets/profile_form_field.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _dobController = TextEditingController(text: '15/06/1990');

  String _selectedGender = 'Male';
  String _selectedBloodGroup = 'O+';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Personal Information",
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green));
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileAvatar(initials: "JD"),
              const SizedBox(height: 30),

              ProfileFormField(label: "Full Name", controller: _nameController, icon: Icons.person_outline),
              ProfileFormField(label: "Phone Number", controller: _phoneController, icon: Icons.phone_outlined),
              ProfileFormField(label: "Email Address", controller: _emailController, icon: Icons.email_outlined),
              ProfileFormField(label: "Date of Birth", controller: _dobController, icon: Icons.calendar_today_outlined, readOnly: true),

              ProfileDropdown(
                label: "Gender",
                icon: Icons.wc_outlined,
                value: _selectedGender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
              ProfileDropdown(
                label: "Blood Group",
                icon: Icons.bloodtype_outlined,
                value: _selectedBloodGroup,
                items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                onChanged: (val) => setState(() => _selectedBloodGroup = val!),
              ),

              const EmergencyContactCard(),
            ],
          ),
        ),
      ),
    );
  }
}
