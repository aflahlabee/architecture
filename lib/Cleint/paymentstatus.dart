import 'package:flutter/material.dart';

class PaymentStatusPage extends StatelessWidget {
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

            // 🔹 Payment Status Header
            Text(
              "Payment | Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 🔹 Payment Table with Modern UI
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black),
                      headingTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(label: Text('Stage')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: _buildPaymentData(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

  // 🔹 Payment Data Table Rows
  List<DataRow> _buildPaymentData() {
    List<Map<String, dynamic>> paymentData = [
      {"stage": "1", "desc": "As Advance", "amount": "₹ 50,000", "status": "Paid"},
      {"stage": "2", "desc": "On finalization of design (Plan)", "amount": "₹ 100,000", "status": "Paid"},
      {"stage": "3", "desc": "On finalization of design (Plan)-Balance", "amount": "₹ 50,000", "status": "Paid"},
      {"stage": "4", "desc": "On submission of exterior portfolio", "amount": "₹ 150,000", "status": "Paid"},
      {"stage": "5", "desc": "On submission of working drawings-Civil", "amount": "₹ 100,000", "status": "Paid"},
      {"stage": "6", "desc": "On completion of ground floor slab", "amount": "₹ 150,000", "status": "Due"},
      {"stage": "7", "desc": "On completion of first floor slab", "amount": "₹ 150,000", "status": "Due"},
      {"stage": "8", "desc": "On Submission of interior portfolio", "amount": "₹ 100,000", "status": "Due"},
      {"stage": "9", "desc": "On Submission of landscape working drawings", "amount": "₹ 100,000", "status": "Due"},
      {"stage": "10", "desc": "On Completion of project", "amount": "₹ 100,000", "status": "Due"},
    ];

    return paymentData.map((data) {
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return data["status"] == "Paid" ? Colors.green[100] : Colors.orange[100];
          },
        ),
        cells: [
          DataCell(Text(data["stage"], style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text(data["desc"])),
          DataCell(Text(data["amount"], style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: data["status"] == "Paid" ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                data["status"],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
