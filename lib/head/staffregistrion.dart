import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffRegistrationPage extends StatefulWidget {
  @override
  _StaffRegistrationPageState createState() => _StaffRegistrationPageState();
}

class _StaffRegistrationPageState extends State<StaffRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  List<Map<String, dynamic>> staffList = [];
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    _loadStaff();
  }

  Future<void> _loadStaff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedStaff = prefs.getStringList('staffList') ?? [];
    setState(() {
      staffList = storedStaff
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _registerOrUpdateStaff() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      Map<String, dynamic> staffData = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": email,
        "mobileNo": mobileController.text.trim(),
        "qualification": qualificationController.text.trim(),
        "post": postController.text.trim(),
      };

      if (editingIndex != null) {
        staffList[editingIndex!] = staffData;
      } else {
        bool emailExists = staffList.any((staff) => staff['email'] == email);
        if (emailExists) {
          _showSnackbar(
              "Email is already registered. Please use another email.");
          return;
        }
        staffList.add(staffData);
        await storage.write(key: email, value: password);
      }

      prefs.setStringList(
          'staffList', staffList.map((e) => jsonEncode(e)).toList());
      _showSnackbar(editingIndex != null
          ? "Staff updated successfully!"
          : "Staff registered successfully!");
      _clearFields();
      _loadStaff();
    }
  }

  void _editStaff(int index) {
    Map<String, dynamic> staff = staffList[index];
    firstNameController.text = staff["firstName"];
    lastNameController.text = staff["lastName"];
    emailController.text = staff["email"];
    mobileController.text = staff["mobileNo"];
    qualificationController.text = staff["qualification"];
    postController.text = staff["post"];
    setState(() {
      editingIndex = index;
    });
  }

  Future<void> _deleteStaff(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = staffList[index]['email'];
    staffList.removeAt(index);
    prefs.setStringList(
        'staffList', staffList.map((e) => jsonEncode(e)).toList());
    await storage.delete(key: email);
    _showSnackbar("Staff deleted successfully!");
    _loadStaff();
  }

  void _clearFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    qualificationController.clear();
    postController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      editingIndex = null;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/download.jfif"), // Add your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Staff Registration",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildTextField(
                                  firstNameController, "First Name"),
                              _buildTextField(lastNameController, "Last Name"),
                              _buildTextField(emailController, "Email",
                                  enabled: editingIndex == null),
                              _buildTextField(mobileController, "Mobile No.",
                                  isNumber: true),
                              _buildTextField(
                                  qualificationController, "Qualification"),
                              _buildTextField(postController, "Post"),
                              if (editingIndex == null) ...[
                                _buildPasswordField(passwordController,
                                    "Password", _isPasswordVisible, () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                }),
                                _buildPasswordField(
                                    confirmPasswordController,
                                    "Confirm Password",
                                    _isConfirmPasswordVisible, () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                }),
                              ],
                              SizedBox(height: 15),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.pinkAccent,
                                ),
                                onPressed: _registerOrUpdateStaff,
                                child: Text(
                                    editingIndex != null
                                        ? "Update Staff"
                                        : "Register Staff",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Registered Staff",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: staffList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                            "${staffList[index]['firstName']} ${staffList[index]['lastName']}"),
                        subtitle: Text(
                            "${staffList[index]['post']} - ${staffList[index]['email']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editStaff(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteStaff(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false, bool enabled = true}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String label,
    bool isVisible,
    VoidCallback toggleVisibility,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter $label";
          } else if (value.length < 6) {
            return "$label must be at least 6 characters";
          }
          return null;
        },
      ),
    );
  }
}
