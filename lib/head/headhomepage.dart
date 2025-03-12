import 'package:architecture_app/head/cleintregistrion.dart';
import 'package:architecture_app/head/staffregistrion.dart';
import 'package:architecture_app/loginandsignup/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeadArchitectPage(),
    );
  }
}

class HeadArchitectPage extends StatefulWidget {
  @override
  _HeadArchitectPageState createState() => _HeadArchitectPageState();
}

class _HeadArchitectPageState extends State<HeadArchitectPage> {
  final Box userBox = Hive.box('userBox');

  Future<void> _logout() async {
    await userBox.delete('loggedInUser'); // Clear login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _registerUser(BuildContext context, String role) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController usernameController = TextEditingController();
        TextEditingController passwordController = TextEditingController();

        return AlertDialog(
          title: Text("Register $role"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();

                if (username.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill in all fields")),
                  );
                  return;
                }

                String key = "${role}_$username";

                if (userBox.containsKey(key)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Username already exists!")),
                  );
                } else {
                  await userBox.put(key, password);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$role registered successfully!")),
                  );
                }
              },
              child: Text("Register"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "images/download.jfif",
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)), // Dark overlay

          Column(
            children: [
              SizedBox(height: 50),
              // Lottie Animation
              Center(
                child: Lottie.asset(
                  "images/welcom.json",
                  width: 200,
                  height: 200,
                ),
              ),
              Text(
                'Welcome to Head Architect',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: GridView.count(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       children: [
              //         _buildMenuCard(Icons.people, "Add Client", "Client"),
              //         _buildMenuCard(Icons.group, "Add Staff", "Staff"),
              //       ],
              //     ),
              //   ),
              // ),
InkWell(
      onTap: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>ClientRegistrationPage ()),
  );},
      child: Row(
        children: [SizedBox(width: 50,),
          SizedBox(height: 150,width: 150,
            child: Card(
              color: Colors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group, size: 50, color: Colors.blue),
                  SizedBox(height: 10),
                  Text(
                    "Add Client",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),SizedBox(width: 20,)
,          InkWell(
      onTap: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>StaffRegistrationPage ()),
  );},
  
      child: SizedBox(height: 150,width: 150,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.group, size: 50, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                "Add Staff",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
        ],
      ),
    ),
           
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _logout,
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text("Logout", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}
