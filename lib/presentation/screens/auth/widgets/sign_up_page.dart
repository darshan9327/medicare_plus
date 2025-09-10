import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/user_models/create_user.dart';
import '../../../../data/data_source.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
import '../../common/widgets/common_text_form_field.dart';
import '../../dashboard/pages/dashboard_screen.dart';

class SignupForm extends StatefulWidget {
  final String? phone;

  const SignupForm({super.key, this.phone});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _mobileNo = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _password = TextEditingController();

  final DataSource api = DataSource();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.phone != null) {
      _mobileNo.text = widget.phone!;
    }
  }

  Future<void> _signupUser() async {
    if (!_signupFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final CreateUserResponse response = await api.createUser(
        phone: _mobileNo.text.trim(),
        name: _fullName.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        password: _password.text.trim(),
      );

      if (!mounted) return;

      if (response.success == true) {
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
      key: _signupFormKey,
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
              value == null || value.trim().isEmpty
                  ? "Full name is required"
                  : null,
            ),
            const SizedBox(height: 20),

            const Text("Mobile Number"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _mobileNo,
              hintText: "+91 98765 43210",
              readonly: widget.phone != null,
              keyboardType: TextInputType.number,
              validator: (value) => value == null ||
                  !RegExp(r'^[0-9]{10}$').hasMatch(value)
                  ? "Enter valid 10-digit number"
                  : null,
            ),
            const SizedBox(height: 20),

            const Text("Email"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _email,
              hintText: "Enter your Email Id",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Email is required";
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Address is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text("Password"),
            const SizedBox(height: 5),
            CommonTextFormField(
              controller: _password,
              hintText: "Enter your password",
              obscureText: true,
              validator: (value) =>
              value == null || value.trim().isEmpty
                  ? "Password is required"
                  : null,
            ),

            SizedBox(height: SConfig.sHeight * 0.050),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CommonContainer(
              text: "Signup",
              onPressed: _signupUser,
            ),
          ],
        ),
      ),
    );
  }
}
