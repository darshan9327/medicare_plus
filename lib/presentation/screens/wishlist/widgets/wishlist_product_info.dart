import 'package:flutter/material.dart';

import '../../common/utils/size_config.dart';

class WishlistProductInfo extends StatelessWidget {


  const WishlistProductInfo({super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SConfig.sHeight * 0.010),
        SizedBox(height: SConfig.sHeight * 0.010),
      ],
    );
  }
}
