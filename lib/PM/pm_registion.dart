import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'PMListPage.dart';

class PMRegistrationPage extends StatefulWidget {
  @override
  _PMRegistrationPageState createState() => _PMRegistrationPageState();
}

class _PMRegistrationPageState extends State<PMRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  

  Future<void> _registerPM() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> pmData = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "mobileNo": mobileController.text.trim(),
        "qualification": qualificationController.text.trim(),
        "post": postController.text.trim(),
      };

      await DBHelper.instance.insertPM(pmData);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PMListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Register PM"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(firstNameController, "First Name", Icons.person),
                  _buildTextField(lastNameController, "Last Name", Icons.person_outline),
                  _buildEmailField(emailController),
                  _buildMobileField(mobileController),
                  _buildTextField(qualificationController, "Qualification", Icons.school),
                  _buildTextField(postController, "Post", Icons.work),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _registerPM,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      elevation: 4,
                    ),
                    child: Text("Register PM"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
        ),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
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
