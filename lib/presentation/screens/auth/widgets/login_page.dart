import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/session_manager.dart';
import '../../../../data/data_source.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
import '../../common/widgets/common_text_form_field.dart';
import '../../dashboard/pages/dashboard_screen.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback? onGoToSignup;
  const LoginForm({super.key, this.onGoToSignup});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final DataSource api = DataSource();

  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!otpSent) ...[
              const Text("Mobile Number"),
              SizedBox(height: SConfig.sHeight * 0.015),
              CommonTextFormField(
                hintText: "+91 98765 43210",
                keyboardType: TextInputType.number,
                controller: _mobileNo,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter mobile number";
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Enter valid 10-digit phone number";
                  }
                  return null;
                },
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(
                text: "Send OTP",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    );
                    try {
                      final response =
                      await api.sendOtp(phone: _mobileNo.text.trim());
                      Navigator.pop(context);
                      if (response.success == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                          Text(response.message ?? "OTP sent successfully"),
                          duration: const Duration(seconds: 1),
                        ));
                        setState(() {
                          otpSent = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              response.message ?? "Failed to send OTP"),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error: $e"),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  }
                },
              ),
            ],
            if (otpSent) ...[
              const Text("OTP"),
              SizedBox(height: SConfig.sHeight * 0.010),
              CommonTextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                hintText: "Enter 6-digit OTP",
                controller: _otp,
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(
                text: "Verify & Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    );
                    try {
                      final response = await api.verifyOtp(
                        phone: _mobileNo.text.trim(),
                        otp: _otp.text.trim(),
                      );

                      if (!mounted) return;
                      Navigator.pop(context);

                      if (response.success) {
                        if (response.user == null) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("User not found, please try again")),
                          );
                          return;
                        }
                        await SessionManager.saveSessionId(response.token ?? "");
                        await SessionManager.saveUserId(response.user!.id);

                        if ((response.user?.name ?? "").isEmpty) {
                          widget.onGoToSignup?.call();
                        } else {
                          await SessionManager.setLoggedIn(true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(response.message ?? "Login successful"),
                                duration: const Duration(seconds: 1)),
                          );
                          Get.offAll(() => const DashboardScreen());
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  response.message ?? "Failed to login"),
                              duration: const Duration(seconds: 1)),
                        );
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error: $e"),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  }
                },
              ),
            ],
            if (!otpSent) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    "OR",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
              ),
              CommonContainer(
                  text: "Continue with Google",
                  color: Colors.white,
                  color1: const Color(0xff478ef8),
                  onPressed: () {}),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(
                  text: "Continue with Facebook",
                  color: Colors.white,
                  color1: const Color(0xff478ef8),
                  onPressed: () {}),
            ],
          ],
        ),
      ),
    );
  }
}
