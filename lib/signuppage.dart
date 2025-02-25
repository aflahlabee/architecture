import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  void _signUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String phone = _phoneController.text.trim();

    if (email.isEmpty || password.isEmpty || phone.isEmpty) {
      _showPopup("Please fill all fields");
      return;
    }

    if (!_isValidEmail(email)) {
      _showPopup("Invalid email format");
      return;
    }

    if (!_isValidPassword(password)) {
      _showPopup("Password must be at least 8 characters long and include a mix of letters, numbers, and symbols");
      return;
    }

    if (!_isValidPhone(phone)) {
      _showPopup("Phone number must be 10 digits");
      return;
    }

    _showPopup("Successfully created your account");
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'(?=.*[A-Z])').hasMatch(password) &&
        RegExp(r'(?=.*[a-z])').hasMatch(password) &&
        RegExp(r'(?=.*\d)').hasMatch(password) &&
        RegExp(r'(?=.*[@\$!%*?&])').hasMatch(password);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}\$').hasMatch(phone);
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Signup Status"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
              SizedBox(height: 20),
              _buildTextField(_emailController, "Email", Icons.email, false),
              SizedBox(height: 15),
              _buildTextField(_passwordController, "Password", Icons.lock, true),
              SizedBox(height: 15),
              _buildPhoneField(),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: _signUp,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone Number",
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text("+91", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      maxLength: 10,
    );
  }
}
