import 'package:architecture_app/Cleint/Payment%20Receipt%20Page.dart';
import 'package:architecture_app/Cleint/paymentstatus.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
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

            // 🟢 Title: Payment
            Text(
              "Payment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 🟢 Payment Options Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [GestureDetector(
      onTap: () {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>PaymentStatusPage ()),
  );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Container(
          width: 90,
          height: 90,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 40, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text("Status", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    ),GestureDetector(
      onTap: () {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>PaymentReceiptPage ()),
  );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Container(
          width: 90,
          height: 90,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon( Icons.receipt_long, size: 40, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text("Receipt", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    ),
             
         
              ],
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

  // 🟢 Helper Method for Payment Options
  Widget _buildPaymentCard(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title clicked")));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Container(
          width: 90,
          height: 90,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
