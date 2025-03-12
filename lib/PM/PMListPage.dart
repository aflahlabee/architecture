import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'pm_registion.dart';

class PMListPage extends StatefulWidget {
  @override
  _PMListPageState createState() => _PMListPageState();
}

class _PMListPageState extends State<PMListPage> {
  List<Map<String, dynamic>> pmList = [];

  @override
  void initState() {
    super.initState();
    _loadPMList();
  }

  Future<void> _loadPMList() async {
    List<Map<String, dynamic>> data = await DBHelper.instance.getPMs();
    setState(() {
      pmList = data;
    });
  }

  Future<void> _navigateToAddPM() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PMRegistrationPage()),
    );
    if (result == true) {
      _loadPMList();
    }
  }

  Future<void> _deletePM(int id) async {
    await DBHelper.instance.deletePM(id);
    _loadPMList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registered PMs"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: pmList.isEmpty
          ? Center(
              child: Text(
                "No Project Managers Registered Yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: pmList.length,
              itemBuilder: (context, index) {
                final pm = pmList[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        pm['firstName'][0].toUpperCase(),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      "${pm['firstName']} ${pm['lastName']}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("📧 ${pm['email']}", style: TextStyle(color: Colors.grey[700])),
                        Text("📞 ${pm['mobileNo']}", style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Implement Edit Feature
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deletePM(pm['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPM,
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
        elevation: 6,
      ),
    );
  }
}