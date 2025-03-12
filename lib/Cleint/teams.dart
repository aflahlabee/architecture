import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {"name": "Sadir", "role": "Jr. Architect", "contact": "9876543213"},
    {"name": "Name", "role": "Post", "contact": "Contact No."},
    {"name": "Name", "role": "Post", "contact": "Contact No."},
    {"name": "Name", "role": "Post", "contact": "Contact No."},
    {"name": "Name", "role": "Post", "contact": "Contact No."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "App Name",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text("Logo", style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Project Details
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProjectDetail("Project Name", "xxxxxxxxxx"),
                          _buildProjectDetail("Client Name", "xxxxxxxxxx"),
                          _buildProjectDetail("Project Type", "xxxxxx"),
                          _buildProjectDetail("Area", "xxxxx Sq.Ft"),
                          _buildProjectDetail("Budget", "xxxxx"),
                          _buildProjectDetail("Location", "xxxxxxxxxx"),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      child: Text("Client Dp", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // 🟢 Title: Team
            Text(
              "Team",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 🟢 Team Grid
            Expanded(
              child: GridView.builder(
                itemCount: teamMembers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person, size: 30, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                          Text(teamMembers[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(teamMembers[index]["role"]!, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                          Text(teamMembers[index]["contact"]!, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 🟢 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Awards"),
        ],
      ),
    );
  }

  // 🟢 Helper Method for Project Details
  Widget _buildProjectDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(text: "$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
