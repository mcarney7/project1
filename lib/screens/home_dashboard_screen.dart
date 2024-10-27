import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  double balance = 0.0;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  // Fetch total income from the database
  Future<void> loadBalance() async {
    double totalIncome = 0.0;
    List<Map<String, dynamic>> allIncome = await dbHelper.queryAllIncome();

    // Sum up all income
    for (var income in allIncome) {
      totalIncome += income['amount'];
    }

    setState(() {
      balance = totalIncome;
    });
  }

  // Method to handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/income').then((_) => loadBalance());
        break;
      case 2:
        Navigator.pushNamed(context, '/expenses').then((_) => loadBalance());
        break;
      case 3:
        Navigator.pushNamed(context, '/savings');
        break;
      case 4:
        Navigator.pushNamed(context, '/reports');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GirlFunds Dashboard"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the balance with an appealing card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.pink[100],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$${balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Manage Your Finances",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Grid of dashboard cards for navigation
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  title: "Income",
                  icon: Icons.attach_money,
                  color: Colors.green[300]!,
                  route: '/income',
                ),
                _buildDashboardCard(
                  title: "Expenses",
                  icon: Icons.money_off,
                  color: Colors.red[300]!,
                  route: '/expenses',
                ),
                _buildDashboardCard(
                  title: "Savings Goals",
                  icon: Icons.savings,
                  color: Colors.blue[300]!,
                  route: '/savings',
                ),
                _buildDashboardCard(
                  title: "Girl Math Calculator",
                  icon: Icons.calculate,
                  color: Colors.purple[300]!,
                  route: '/girl_math_calculator',
                ),
                _buildDashboardCard(
                  title: "Reports",
                  icon: Icons.pie_chart,
                  color: Colors.orange[300]!,
                  route: '/reports',
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Savings Visualization",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Example of savings progress bar
            _buildSavingsGoalProgress(
              goalName: "Vacation Fund",
              progress: 0.4, // Example: 40% progress
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            _buildSavingsGoalProgress(
              goalName: "New Bag",
              progress: 0.75, // Example: 75% progress
              color: Colors.purple,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: 'Savings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  // Widget to create a dashboard card
  Widget _buildDashboardCard({required String title, required IconData icon, required Color color, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route).then((_) {
          // Reload the balance if income or expenses have been updated
          if (route == '/income' || route == '/expenses') {
            loadBalance();
          }
        });
      },
      child: Card(
        elevation: 4,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to create a savings goal progress bar
  Widget _buildSavingsGoalProgress({required String goalName, required double progress, required Color color}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goalName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
            SizedBox(height: 5),
            Text("${(progress * 100).toStringAsFixed(1)}% completed"),
          ],
        ),
      ),
    );
  }
}
