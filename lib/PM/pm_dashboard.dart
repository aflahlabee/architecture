
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path_provider/path_provider.dart';

// class PMDashboard extends StatefulWidget {
//    final String email;
//   PMDashboard({required this.email});
  

//   @override
//   _PMDashboardState createState() => _PMDashboardState();
// }

// class _PMDashboardState extends State<PMDashboard> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(

//         backgroundColor: Colors.blueAccent,
//       ),
//       drawer: _buildDrawer(context), // Navigation Drawer
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           children: [
//             _buildDashboardCard(Icons.people, 'Manage Staff', Colors.orange, () {}),
//             _buildDashboardCard(Icons.work, 'Projects', Colors.green, () {}),
//             _buildDashboardCard(Icons.schedule, 'Appointments', Colors.blue, () {}),
//             _buildDashboardCard(Icons.report, 'Reports', Colors.red, () {}),
//             _buildDashboardCard(Icons.person, 'Profile Management', Colors.purple, () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileManagementPage()),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(IconData icon, String title, Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 5,
//         color: color.withOpacity(0.2),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 50, color: color),
//             SizedBox(height: 10),
//             Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(color: Colors.blueAccent),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Icons.account_circle, size: 60, color: Colors.white),
//                 SizedBox(height: 10),
//                 Text('Project Manager', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//           _buildDrawerItem(Icons.home, 'Dashboard', () {}),
//           _buildDrawerItem(Icons.people, 'Manage Staff', () {}),
//           _buildDrawerItem(Icons.work, 'Projects', () {}),
//           _buildDrawerItem(Icons.schedule, 'Appointments', () {}),
//           _buildDrawerItem(Icons.report, 'Reports', () {}),
//           _buildDrawerItem(Icons.person, 'Profile Management', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ProfileManagementPage()),
//             );
//           }),
//           Divider(),
//           _buildDrawerItem(Icons.logout, 'Logout', () {
//             Navigator.pop(context); // Close Drawer
//             Navigator.pop(context); // Navigate back to Login
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blueAccent),
//       title: Text(title, style: TextStyle(fontSize: 16)),
//       onTap: onTap,
//     );
//   }
// }




// class ProfileManagementPage extends StatefulWidget {
//   @override
//   _ProfileManagementPageState createState() => _ProfileManagementPageState();
// }

// class _ProfileManagementPageState extends State<ProfileManagementPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   File? _profileImage;

//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//   }

//   // Load saved data
//   Future<void> _loadProfileData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _nameController.text = prefs.getString('name') ?? '';
//       _emailController.text = prefs.getString('email') ?? '';
//       _mobileController.text = prefs.getString('mobile') ?? '';
//       String? imagePath = prefs.getString('profileImage');
//       if (imagePath != null && File(imagePath).existsSync()) {
//         _profileImage = File(imagePath);
//       }
//     });
//   }

//   // Save profile data
//   Future<void> _saveProfileData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('name', _nameController.text);
//     await prefs.setString('email', _emailController.text);
//     await prefs.setString('mobile', _mobileController.text);
//     if (_profileImage != null) {
//       await prefs.setString('profileImage', _profileImage!.path);
//     }
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Saved Successfully!")));
//   }

//   // Pick profile image
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final directory = await getApplicationDocumentsDirectory();
//       final savedImage = File('${directory.path}/profile.jpg');
//       await File(pickedFile.path).copy(savedImage.path);
//       setState(() {
//         _profileImage = savedImage;
//       });
//       await _saveProfileData(); // Save image path
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile Management'), backgroundColor: Colors.blueAccent),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Center(
//               child: GestureDetector(
//                 onTap: _pickImage,
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey.shade300,
//                       backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
//                       child: _profileImage == null
//                           ? Icon(Icons.person, size: 50, color: Colors.white)
//                           : null,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.blueAccent,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     _buildTextField(Icons.person, 'Name', _nameController),
//                     SizedBox(height: 10),
//                     _buildTextField(Icons.email, 'Email', _emailController),
//                     SizedBox(height: 10),
//                     _buildTextField(Icons.phone, 'Mobile Number', _mobileController, keyboardType: TextInputType.phone),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _saveProfileData,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                       ),
//                       child: Text('Save Changes', style: TextStyle(fontSize: 16, color: Colors.white)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(IconData icon, String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.blueAccent),
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PMDashboard extends StatelessWidget {
  final String email;

  const PMDashboard({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(child: Text("Welcome, $email")),
    );
  }
}

