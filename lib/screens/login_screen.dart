import 'package:flutter/material.dart';
import 'package:project1/services/shared_preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
    // Retrieve saved credentials from SharedPreferences
    Map<String, String> credentials = await SharedPreferencesHelper.getUserCredentials();
    String savedEmail = credentials['email'] ?? '';
    String savedPassword = credentials['password'] ?? '';

    // Check if the email and password fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    // Validate credentials
    if (emailController.text == savedEmail && passwordController.text == savedPassword) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      setState(() {
        errorMessage = 'Login failed. Incorrect email or password.';
      });
    }
  }

  Future<void> signup() async {
    // Check if the email and password fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    // Save credentials to SharedPreferences
    await SharedPreferencesHelper.saveUserCredentials(emailController.text, passwordController.text);
    Navigator.pushNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: signup,
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
