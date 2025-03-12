import 'package:architecture_app/Cleint/floor_plans.dart';
import 'package:flutter/material.dart';

class DesignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      appBar: AppBar(
        title: Text("Designs"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Section Title
            Text(
              "Explore Designs",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 15),

            // 🟢 Design Categories
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildDesignTile(
                    context,
                    title: "Floor Plans",
                    icon: Icons.architecture,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FloorPlansPage()),
                      );
                    },
                  ),
                  _buildDesignTile(
                    context,
                    title: "Exterior Designs",
                    icon: Icons.house_siding,
                    onTap: () {
                      Navigator.pushNamed(context, "/exteriorDesigns");
                    },
                  ),
                  _buildDesignTile(
                    context,
                    title: "Interior Design",
                    icon: Icons.chair,
                    onTap: () {
                      Navigator.pushNamed(context, "/interiorDesign");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 🟢 Helper Method: Design Category Tile with Animated Effect
  Widget _buildDesignTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        shadowColor: Colors.black26,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      elevation: 10,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: "Projects"),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Awards"),
      ],
      onTap: (index) {
        if (index == 0) Navigator.pushNamed(context, "/clientHome");
        if (index == 1) Navigator.pushNamed(context, "/projects");
        if (index == 2) Navigator.pushNamed(context, "/awards");
      },
    );
  }
}
