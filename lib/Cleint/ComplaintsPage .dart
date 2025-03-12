// import 'package:flutter/material.dart';
// import 'dart:io';

// class ComplaintsPage extends StatefulWidget {
//   @override
//   _ComplaintsPageState createState() => _ComplaintsPageState();
// }

// class _ComplaintsPageState extends State<ComplaintsPage> {
//   final TextEditingController _complaintController = TextEditingController();
//   File? _image;

//   // Function to pick an image
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: Text("App Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         centerTitle: false,
//         leading: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.black,
//             child: Text("Logo", style: TextStyle(color: Colors.white, fontSize: 12)),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProjectDetails(),
//             SizedBox(height: 20),
//             Text("Complaints", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             _buildComplaintInput(),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _submitComplaint,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(),
//     );
//   }

//   Widget _buildProjectDetails() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildProjectDetail("Project Name", "xxxxxxxx"),
//                   _buildProjectDetail("Client Name", "xxxxxxxx"),
//                   _buildProjectDetail("Project Type", "xxxxx"),
//                   _buildProjectDetail("Area", "xxxxx Sq.Ft"),
//                   _buildProjectDetail("Budget", "xxxxx"),
//                   _buildProjectDetail("Location", "xxxxxxxxxxxx"),
//                 ],
//               ),
//             ),
//             CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.grey[300],
//               child: Icon(Icons.person, color: Colors.black, size: 30),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProjectDetail(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 6),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(color: Colors.black, fontSize: 14),
//           children: [
//             TextSpan(text: "$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
//             TextSpan(text: value, style: TextStyle(fontSize: 14)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildComplaintInput() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _complaintController,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Text your Complaints here",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//               ),
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 width: double.infinity,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: _image == null
//                     ? Center(child: Text("+ Upload Image", style: TextStyle(fontSize: 16, color: Colors.black54)))
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.file(_image!, width: double.infinity, height: 150, fit: BoxFit.cover),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitComplaint() {
//     String complaintText = _complaintController.text;
//     if (complaintText.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a complaint")));
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Complaint submitted successfully!")));
//     setState(() {
//       _complaintController.clear();
//       _image = null;
//     });
//   }

//   Widget _buildBottomNavBar() {
//     return BottomNavigationBar(
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.black54,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//         BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Projects"),
//         BottomNavigationBarItem(icon: Icon(Icons.star), label: "Awards"),
//       ],
//     );
//   }
// }
