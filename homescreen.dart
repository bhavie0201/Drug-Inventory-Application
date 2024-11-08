import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'inventory_page.dart';
import 'reports_page.dart';
import 'orders_page.dart';
import 'settings_page.dart';
import 'profilescreen.dart';
import 'action_page.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Color primary = const Color(0xffeef444c);

  // Sample Data (Replace with actual data from your database)
  int totalTransactions = 12;
  int medicinesSold = 75;
  double totalRevenue = 5400.0;

  // List of pages for bottom navigation
  final List<Widget> _pages = [
    const DashboardPage(),
    const InventoryPage(),
    const ReportsPage(),
    const OrdersPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Fetch Current Date and Time
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());
    String currentTime = DateFormat.jm().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: Text(
          "InventoryApp",
          style: TextStyle(
            fontFamily: "NexaBold",
            fontSize: screenWidth / 18,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle Notification button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      // Home page will show the updated Dashboard with today's stats
      body: _selectedIndex == 0
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Current Date and Time
            Text(
              "Date: $currentDate",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Time: $currentTime",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Section Title
            const Text(
              "Today's Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // Today's Stats Tiles
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildStatTile(
                    "Transactions",
                    "$totalTransactions",
                    Icons.shopping_cart_checkout,
                    Colors.blueAccent,
                  ),
                  _buildStatTile(
                    "Medicines Sold",
                    "$medicinesSold",
                    Icons.medical_services,
                    Colors.purple,
                  ),
                  _buildStatTile(
                    "Total Revenue",
                    "\$$totalRevenue",
                    Icons.monetization_on,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : _pages[_selectedIndex], // Display other pages

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ActionPage(),
            ),
          );
        },
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to create a stat tile
  Widget _buildStatTile(String title, String data, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              data,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
