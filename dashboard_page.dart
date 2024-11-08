import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth / 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Inventory Record",
            style: TextStyle(
              fontSize: screenWidth / 16,
              fontFamily: "NexaBold",
            ),
          ),
          SizedBox(height: screenHeight / 40),
          Expanded(
            child: ListView(
              children: [
                // Replace with your actual inventory record data
                inventoryCard("Item 1", "20 in stock", screenWidth),
                inventoryCard("Item 2", "5 in stock", screenWidth),
                inventoryCard("Item 3", "Out of stock", screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inventoryCard(String itemName, String status, double screenWidth) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: TextStyle(
              fontFamily: "NexaBold",
              fontSize: screenWidth / 24,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: screenWidth / 28,
              color: status == "Out of stock" ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
