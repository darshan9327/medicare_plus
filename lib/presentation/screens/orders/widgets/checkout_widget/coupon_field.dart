import 'package:flutter/material.dart';

import '../../../common/utils/size_config.dart';
import '../../../common/widgets/common_container.dart';
import '../../../common/widgets/common_text_form_field.dart';

class CouponField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;

  const CouponField({super.key, required this.controller, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: SConfig.sWidth * 0.700, child: CommonTextFormField(controller: controller, hintText: "Enter coupon code")),
        const SizedBox(width: 10),
        CommonContainer(text: "Apply", color: Colors.white, color1: Colors.blue, onPressed: onApply),
      ],
    );
  }
}
