import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectTypeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  List<Map<String, dynamic>> clientList = [];
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedClients = prefs.getStringList('clientList') ?? [];
    setState(() {
      clientList = storedClients
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _registerOrUpdateClient() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      Map<String, dynamic> clientData = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": email,
        "mobileNo": mobileController.text.trim(),
        "projectName": projectNameController.text.trim(),
        "projectType": projectTypeController.text.trim(),
      };

      if (editingIndex != null) {
        clientList[editingIndex!] = clientData;
      } else {
        bool emailExists = clientList.any((client) => client['email'] == email);
        if (emailExists) {
          _showSnackbar(
              "Email is already registered. Please use another email.");
          return;
        }
        clientList.add(clientData);
        await storage.write(key: email, value: password);
      }

      prefs.setStringList(
          'clientList', clientList.map((e) => jsonEncode(e)).toList());
      _showSnackbar(editingIndex != null
          ? "Client updated successfully!"
          : "Client registered successfully!");
      _clearFields();
      _loadClients();
    }
  }

  void _editClient(int index) {
    Map<String, dynamic> client = clientList[index];
    firstNameController.text = client["firstName"];
    lastNameController.text = client["lastName"];
    emailController.text = client["email"];
    mobileController.text = client["mobileNo"];
    projectNameController.text = client["projectName"];
    projectTypeController.text = client["projectType"];
    setState(() {
      editingIndex = index;
    });
  }

  Future<void> _deleteClient(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = clientList[index]['email'];
    clientList.removeAt(index);
    prefs.setStringList(
        'clientList', clientList.map((e) => jsonEncode(e)).toList());
    await storage.delete(key: email);
    _showSnackbar("Client deleted successfully!");
    _loadClients();
  }

  void _clearFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    projectNameController.clear();
    projectTypeController.clear();
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
                image: AssetImage(
                    "images/background.jpg"), // Change this to your actual background image
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
                        Text("Client Registration",
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
                                  projectNameController, "Project Name"),
                              _buildTextField(
                                  projectTypeController, "Project Type"),
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
                                onPressed: _registerOrUpdateClient,
                                child: Text(
                                    editingIndex != null
                                        ? "Update Client"
                                        : "Register Client",
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
                Text("Registered Clients",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: clientList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                            "${clientList[index]['firstName']} ${clientList[index]['lastName']}"),
                        subtitle: Text(
                            "${clientList[index]['projectType']} - ${clientList[index]['email']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editClient(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteClient(index),
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
    TextEditingController controller, String label, bool isVisible, VoidCallback toggleVisibility) {
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
      validator: (value) => value!.isEmpty ? "Enter $label" : null,
    ),
  );
}

}
