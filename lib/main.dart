import 'package:flutter/material.dart';
import 'package:project1/routes.dart'; // Import the routes configuration

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Girl Math Finance App', // App title
      theme: ThemeData(
        primarySwatch: Colors.pink, // Set a primary color for the app
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white, // Background color for all screens
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pinkAccent, // Consistent AppBar color
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink, // General button color
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink, width: 2.0),
          ),
          labelStyle: TextStyle(
            color: Colors.pink,
          ),
        ),
      ),
      initialRoute: '/', // Set the initial route to the login screen
      routes: appRoutes, // Use the predefined routes map from routes.dart
      onGenerateRoute: generateRoute, // Use the route generator for undefined routes
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

