import 'package:flutter/material.dart';
import 'package:project1/screens/login_screen.dart';
import 'package:project1/screens/home_dashboard_screen.dart';
import 'package:project1/screens/income_screen.dart';
import 'package:project1/screens/expense_screen.dart';
import 'package:project1/screens/savings_goal_screen.dart';
import 'package:project1/screens/report_screen.dart';

// Define a Map of routes
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LoginScreen(),                  // Default route (Login Screen)
  '/dashboard': (context) => HomeDashboard(),       // Home Dashboard
  '/income': (context) => IncomeScreen(),           // Income Screen
  '/expenses': (context) => ExpenseScreen(),        // Expense Screen
  '/savings': (context) => SavingsGoalScreen(),     // Savings Goal Screen
  '/reports': (context) => ReportScreen(),           // Report Screen
};

// Function to generate routes for the app
Route<dynamic> generateRoute(RouteSettings settings) {
  final WidgetBuilder builder = appRoutes[settings.name];
  if (builder != null) {
    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }

  // Fallback to default if route is not found
  return MaterialPageRoute(
    builder: (context) => LoginScreen(),
  );
}