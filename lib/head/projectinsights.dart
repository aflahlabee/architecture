import 'package:flutter/material.dart';



class ProjectDashboard extends StatefulWidget {
  @override
  _ProjectDashboardState createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name'),
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.business, color: Colors.blue), // Logo Icon
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue), // Profile Icon
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Project Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Center(child: _buildProjectChart()),
            SizedBox(height: 20),
            Expanded(child: _buildProjectList()),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectChart() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 5),
      ),
      child: Center(
        child: Text("Total Projects", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProjectList() {
    List<Map<String, String>> projects = [
      {"name": "Project A", "location": "Location", "status": "On Going", "color": "0xFF4CAF50"},
      {"name": "Project B", "location": "Location", "status": "Completed", "color": "0xFFFFC107"},
      {"name": "Project C", "location": "Location", "status": "On Hold", "color": "0xFF9E9E9E"},
      {"name": "Project D", "location": "Location", "status": "Dropped", "color": "0xFFF44336"},
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(projects[index]);
      },
    );
  }

  Widget _buildProjectCard(Map<String, String> project) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(project['location']!),
            Spacer(),
            Text(
              project['status']!,
              style: TextStyle(color: Color(int.parse(project['color']!)), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
