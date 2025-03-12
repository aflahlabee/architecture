// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';
import 'pm_dashboard.dart';

class PMLoginPage extends StatefulWidget {
  @override
  _PMLoginPageState createState() => _PMLoginPageState();
}

class _PMLoginPageState extends State<PMLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool> verifyPM(String email, String mobileNo) async {
    final db = await DBHelper.instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'pm_table',
      where: "email = ? AND mobileNo = ?",
      whereArgs: [email, mobileNo],
    );
    return result.isNotEmpty;
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String mobileNo = mobileController.text.trim();

      bool isPMValid = await verifyPM(email, mobileNo);

      if (isPMValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PMDashboard(email: email),
          ),
        );
      } else {
        _showSnackbar("Invalid login credentials! Only registered PMs can log in.");
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "PM Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildEmailField(emailController),
                    _buildMobileField(mobileController),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        elevation: 4,
                      ),
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
        ),
        validator: (value) {
          if (value!.isEmpty) return "Enter Email";
          String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
          if (!RegExp(emailPattern).hasMatch(value)) return "Enter a valid email";
          return null;
        },
      ),
    );
  }

  Widget _buildMobileField(TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "Mobile No.",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
        ),
        validator: (value) {
          if (value!.isEmpty) return "Enter Mobile No.";
          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Enter a valid 10-digit number";
          return null;
        },
      ),
    );
  }
}
