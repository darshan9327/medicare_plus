import 'package:flutter/material.dart';

import '../../../../core/session_manager.dart';
import '../../../../data/data_source.dart';
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
  final _dataSource = DataSource();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedBloodGroup = 'O+';

  bool _isEditing = false;
  bool _loading = true;

  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() => _loading = true);
    try {
      final id = await SessionManager.getUserId();
      if (id == null) throw Exception("User not logged in");
      userId = id;
      await _fetchUser();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error loading user: $e"),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() => _loading = false);
    }
  }

  bool _dataFetched = false;

  Future<void> _fetchUser() async {
    if (userId == null) return;
    try {
      final response = await _dataSource.getUser(userId!);
      if (response.success && response.data != null) {
        final user = response.data!;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        _addressController.text = user.address;
        _dobController.text = "13/09/2003";
        _dataFetched = true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error fetching user: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (userId == null) return;

    try {
      final result = await _dataSource.updateUser(
        id: userId!,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
      );

      if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ));
        setState(() => _isEditing = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result.message),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error updating profile: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Personal Information",
        actions: [
          TextButton(
            onPressed: _isEditing ? _saveProfile : () => setState(() => _isEditing = true),
            child: Text(
              _isEditing ? 'Save' : 'Edit',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
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

              ProfileFormField(
                label: "Full Name",
                controller: _nameController,
                icon: Icons.person_outline,
                readOnly: !_isEditing,
              ),
              ProfileFormField(
                label: "Phone Number",
                controller: _phoneController,
                icon: Icons.phone_outlined,
                readOnly: !_isEditing,
              ),
              ProfileFormField(
                label: "Email Address",
                controller: _emailController,
                icon: Icons.email_outlined,
                readOnly: !_isEditing,
              ),
              ProfileFormField(
                label: "Date of Birth",
                controller: _dobController,
                icon: Icons.calendar_today_outlined,
                readOnly: true,
              ),

              ProfileDropdown(
                label: "Gender",
                icon: Icons.wc_outlined,
                value: _selectedGender,
                items: const ['Male', 'Female', 'Other'],
                onChanged: _isEditing ? (val) => setState(() => _selectedGender = val!) : null,
              ),
              ProfileDropdown(
                label: "Blood Group",
                icon: Icons.bloodtype_outlined,
                value: _selectedBloodGroup,
                items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                onChanged: _isEditing ? (val) => setState(() => _selectedBloodGroup = val!) : null,
              ),

              const EmergencyContactCard(),
            ],
          ),
        ),
      ),
    );
  }
}

