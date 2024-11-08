import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Inventory Page",
        style: TextStyle(fontSize: 24, fontFamily: "NexaBold"),
      ),
    );
  }
}
