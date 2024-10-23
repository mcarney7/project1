import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Keys for shared preferences
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';
  static const String _keyBalance = 'balance';

  // Save user login credentials (email and password)
  static Future<void> saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyEmail, email);
    prefs.setString(_keyPassword, password);
  }

  // Retrieve user login credentials
  static Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(_keyEmail) ?? '';
    String password = prefs.getString(_keyPassword) ?? '';
    return {
      'email': email,
      'password': password,
    };
  }

  // Save the user's balance (for the dashboard or finance tracking)
  static Future<void> saveBalance(double balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(_keyBalance, balance);
  }

  // Retrieve the user's balance
  static Future<double> getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyBalance) ?? 0.0;
  }

  // Clear all shared preferences (useful for logout)
  static Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Additional helper methods for preferences can be added here
  // Example: Dark mode setting, notifications setting, etc.
}
