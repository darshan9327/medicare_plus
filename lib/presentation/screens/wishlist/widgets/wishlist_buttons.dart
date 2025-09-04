import 'package:flutter/material.dart';

import '../../common/widgets/common_container.dart';

class WishlistButtons extends StatelessWidget {

  const WishlistButtons({super.key,});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        CommonContainer(text: "Remove", color: Colors.white, color1: Colors.blue,
            onPressed: () {}),
        const SizedBox(width: 10),
        CommonContainer(
          text: "Add to Cart",
          onPressed: () {
          },
        ),
      ],
    );
  }
}
