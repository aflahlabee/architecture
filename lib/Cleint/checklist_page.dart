import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<Map<String, dynamic>> checklistItems = [
    {"title": "Site Inspection", "isChecked": false},
    {"title": "Foundation Completed", "isChecked": false},
    {"title": "Structural Design Approved", "isChecked": false},
    {"title": "Electrical Work Done", "isChecked": false},
    {"title": "Plumbing Installation", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Checklist"),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: checklistItems.length,
          itemBuilder: (context, index) {
            return _buildChecklistItem(index);
          },
        ),
      ),
    );
  }

  // 🟢 Helper Method: Checklist Item
  Widget _buildChecklistItem(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: checklistItems[index]["isChecked"] ? Colors.green : Colors.grey[300],
          ),
          padding: EdgeInsets.all(6),
          child: Icon(
            checklistItems[index]["isChecked"] ? Icons.check : Icons.circle,
            color: checklistItems[index]["isChecked"] ? Colors.white : Colors.grey[600],
          ),
        ),
        title: Text(
          checklistItems[index]["title"],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: checklistItems[index]["isChecked"] ? Colors.green : Colors.black87,
            decoration: checklistItems[index]["isChecked"] ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: Colors.green,
          value: checklistItems[index]["isChecked"],
          onChanged: (bool? value) {
            setState(() {
              checklistItems[index]["isChecked"] = value!;
            });
          },
        ),
        onTap: () {
          setState(() {
            checklistItems[index]["isChecked"] = !checklistItems[index]["isChecked"];
          });
        },
      ),
    );
  }
}
