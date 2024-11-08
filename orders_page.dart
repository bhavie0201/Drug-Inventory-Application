import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Orders Page",
        style: TextStyle(fontSize: 24, fontFamily: "NexaBold"),
      ),
    );
  }
}
