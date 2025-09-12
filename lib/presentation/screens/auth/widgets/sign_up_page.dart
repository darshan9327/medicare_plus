import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/session_manager.dart';
import '../../../../data/data_source.dart';
import '../../common/widgets/common_container.dart';
import '../../common/widgets/common_text_form_field.dart';
import '../../dashboard/pages/dashboard_screen.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _mobileNo = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final DataSource api = DataSource();

  bool _isLoading = false;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final userId = await SessionManager.getUserId();
    final phone = await SessionManager.getUserPhone();
    setState(() {
      _userId = userId;
      _mobileNo.text = phone ?? "";
    });
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (_userId == null) return;

    setState(() => _isLoading = true);

    try {
      final response = await api.updateUser(
        id: _userId!,
        phone: _mobileNo.text.trim(),
        name: _fullName.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
      );

      if (!mounted) return;

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        Get.offAll(() => const DashboardScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Full Name"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _fullName,
              hintText: "Enter your name",
              validator: (value) =>
              value == null || value.trim().isEmpty ? "Full name is required" : null,
            ),
            const SizedBox(height: 20),

            const Text("Mobile Number"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _mobileNo,
              hintText: "+91 98765 43210",
              readonly: true,
            ),
            const SizedBox(height: 20),

            const Text("Email"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _email,
              hintText: "Enter your Email Id",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Email is required";
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return "Enter valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text("Address"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _address,
              hintText: "Enter your full address",
              keyboardType: TextInputType.multiline,
              validator: (value) =>
              value == null || value.trim().isEmpty ? "Address is required" : null,
            ),
            const SizedBox(height: 30),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CommonContainer(
              text: "Update Details",
              onPressed: _updateUser,
            ),
          ],
        ),
      ),
    );
  }
}
