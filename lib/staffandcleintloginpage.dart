import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffLoginPage extends StatefulWidget {
  @override
  _StaffLoginPageState createState() => _StaffLoginPageState();
}

class _StaffLoginPageState extends State<StaffLoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<void> _login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackbar("Please enter both username and password.");
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> staffList = prefs.getStringList('staffList') ?? [];

    // Check if staff exists in the list
    bool staffExists = false;
    for (String staffJson in staffList) {
      Map<String, dynamic> staffData = jsonDecode(staffJson);
      if (staffData['username'] == username) {
        staffExists = true;
        String? storedPassword = await storage.read(key: username);
        
        if (storedPassword == password) {
          // Successful login
          prefs.setString('loggedInStaff', username);
          _showSnackbar("Login Successful!");
          Navigator.pushReplacementNamed(context, '/dashboard'); // Navigate to dashboard
        } else {
          _showSnackbar("Incorrect password.");
        }
        break;
      }
    }

    if (!staffExists) {
      _showSnackbar("Username not found. Contact Head Architect.");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Staff Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
