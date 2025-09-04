import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/controllers/register_controller.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
import '../../common/widgets/common_text_form_field.dart';
import '../../dashboard/pages/dashboard_screen.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _mobileNo = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Full Name"),
          const SizedBox(height: 5),
          CommonTextFormField(
            controller: _fullName,
            hintText: "Enter your name",
            validator: (value) => value == null || value.trim().isEmpty ? "Full name is required" : null,
          ),
          const SizedBox(height: 20),

          const Text("Mobile Number"),
          const SizedBox(height: 5),
          CommonTextFormField(
            controller: _mobileNo,
            hintText: "+91 98765 43210",
            keyboardType: TextInputType.number,
            validator: (value) => value == null || !RegExp(r'^[0-9]{10}$').hasMatch(value) ? "Enter valid 10-digit number" : null,
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
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Enter valid email";
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
            validator: (value) => value == null || value.trim().isEmpty ? "Password is required" : null,
          ),

          SizedBox(height: SConfig.sHeight * 0.050),

          Obx(() {
            return registerController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : CommonContainer(
              text: "Signup",
              onPressed: () async {
                if (_signupFormKey.currentState!.validate()) {
                  final success = await registerController.registerUser(
                    name: _fullName.text.trim(),
                    phone: _mobileNo.text.trim(),
                    email: _email.text.trim(),
                    password: _password.text.trim(),
                  );

                  if (success) {
                    Get.offAll(() => const DashboardScreen());
                  }
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
