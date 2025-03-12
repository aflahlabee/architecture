import 'package:flutter/material.dart';

class PaymentReceiptPage extends StatelessWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Project Details Card
            _buildProjectDetails(),

            SizedBox(height: 20),

            // 🔹 Payment Receipt Header
            Text(
              "Payment | Receipt",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 🔹 Receipt Image Preview
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _showReceiptDialog(context);
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Tap to View Receipt",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 🔹 Project Details UI
  Widget _buildProjectDetails() {
    return Card(
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
                  _buildProjectDetail("Project Name", "Naseer Residence"),
                  _buildProjectDetail("Client Name", "85 NRC"),
                  _buildProjectDetail("Project Type", "Residential"),
                  _buildProjectDetail("Area", "2500 Sq.Ft"),
                  _buildProjectDetail("Budget", "₹ 1,100,000"),
                  _buildProjectDetail("Location", "Calicut, India"),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Styled Project Detail Row
  Widget _buildProjectDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(text: "$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // 🔹 Receipt Dialog for Viewing Full Image
  void _showReceiptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Receipt Preview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("Receipt Image", style: TextStyle(fontSize: 16, color: Colors.black54)),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close", style: TextStyle(fontSize: 16, color: Colors.blue)),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black54,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Projects"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Awards"),
      ],
    );
  }
}
