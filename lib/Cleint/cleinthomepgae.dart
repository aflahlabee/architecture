import 'package:architecture_app/Cleint/checklist_page.dart';
import 'package:architecture_app/Cleint/design_page.dart';
import 'package:architecture_app/Cleint/paymnet.dart';
import 'package:architecture_app/Cleint/teams.dart';
import 'package:flutter/material.dart';

class ClientHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🟢 Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "images/DALL·E 2025-03-06 13.11.06 - A premium and elegant background image for a modern client home page. The design should feature a luxurious and professional aesthetic with a subtle g.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🟢 Content with Blur Effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2)
                ],
              ),
            ),
          ),

          // 🟢 Main Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟢 App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Client Home Page",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      IconButton(
                        icon: Icon(Icons.logout, color: Colors.white),
                        onPressed: () {
                          // Logout functionality here
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // 🟢 Project Overview Card
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Project Details",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(height: 10),
                          _buildDetailRow("Project Name", "Modern Villa"),
                          _buildDetailRow("Client Name", "John Doe"),
                          _buildDetailRow("Project Type", "Residential"),
                          _buildDetailRow("Area", "2500 sq.ft."),
                          _buildDetailRow("Budget", "\$500,000"),
                          _buildDetailRow("Location", "New York, USA"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // 🟢 Features Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChecklistPage()),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blueAccent.withOpacity(0.2),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.checklist,
                                    size: 40, color: Colors.blueAccent),
                                SizedBox(height: 8),
                                Text("Checklists",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DesignPage()),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blueAccent.withOpacity(0.2),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.design_services,
                                    size: 40, color: Colors.blueAccent),
                                SizedBox(height: 8),
                                Text("Designs",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        //  _buildFeatureTile(Icons.checklist, "Checklists"),
                        //_buildFeatureTile(Icons.design_services, "Designs"),
                        _buildFeatureTile(Icons.draw, "Drawings"),
                        _buildFeatureTile(
                            Icons.meeting_room, "Meeting Minutes"),
                             InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamPage()),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blueAccent.withOpacity(0.2),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.group,
                                    size: 40, color: Colors.blueAccent),
                                SizedBox(height: 8),
                                Text( "Team Details",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPage()),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blueAccent.withOpacity(0.2),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payment,
                                    size: 40, color: Colors.blueAccent),
                                SizedBox(height: 8),
                                Text( "Payments",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        
                       
                        _buildFeatureTile(Icons.schedule, "Work Schedules"),
                        _buildFeatureTile(
                            Icons.insert_chart, "Monthly Reports"),
                        _buildFeatureTile(Icons.report_problem, "Complaints"),
                        _buildFeatureTile(Icons.location_on, "Site Visits"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🟢 Helper Method: Project Detail Row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }

  // 🟢 Helper Method: Feature Tile with Ripple Effect
  Widget _buildFeatureTile(IconData icon, String title) {
    return InkWell(
      onTap: () {
        // 🟢 Navigate to the respective feature page (To be implemented)
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.blueAccent.withOpacity(0.2),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
