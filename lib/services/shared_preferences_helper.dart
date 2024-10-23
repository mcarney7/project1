import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save user login credentials
  static Future<void> saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  // Get user login credentials
  static Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'email': email, 'password': password};
  }

  // Save balance (for example, for the Home Dashboard)
  static Future<void> saveBalance(double balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('balance', balance);
  }

  // Get balance
  static Future<double> getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('balance') ?? 0.0;
  }

  // Clear all shared preferences (for logout or app reset)
  static Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
