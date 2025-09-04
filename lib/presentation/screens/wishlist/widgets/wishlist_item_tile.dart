import 'package:flutter/material.dart';

class WishlistItemTile extends StatelessWidget {


  const WishlistItemTile({super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(3)),
         ],
      ),
    );
  }
}
