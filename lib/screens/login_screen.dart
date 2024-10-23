import 'package:flutter/material.dart';
import 'package:project1/services/shared_preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    Map<String, String> credentials = await SharedPreferencesHelper.getUserCredentials();
    if (emailController.text == credentials['email'] && passwordController.text == credentials['password']) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      print('Login failed');
    }
  }

  Future<void> signup() async {
    SharedPreferencesHelper.saveUserCredentials(emailController.text, passwordController.text);
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
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
            ElevatedButton(onPressed: signup, child: Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
