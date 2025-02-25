import 'package:flutter/material.dart';



class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Map<String, String>> clients = [
    {
      'name': 'John Doe',
      'project': 'Building Design',
      'location': 'New York',
      'contact': '123-456-7890',
    },
    {
      'name': 'Jane Smith',
      'project': 'Interior Design',
      'location': 'Los Angeles',
      'contact': '987-654-3210',
    },
  ];

  void _addClient(Map<String, String> newClient) {
    setState(() {
      clients.add(newClient);
    });
  }

  void _navigateToAddClientPage() async {
    final newClient = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddClientPage()),
    );

    if (newClient != null) {
      _addClient(newClient);
    }
  }

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
            child: Icon(Icons.business, color: Colors.blue),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clients',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: clients.isEmpty
                  ? Center(child: Text("No Clients Added Yet"))
                  : ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        return ClientCard(client: clients[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _navigateToAddClientPage,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  final Map<String, String> client;

  ClientCard({required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client Name: ${client['name']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Project Name: ${client['project']}'),
                  Text('Location: ${client['location']}'),
                  Text('Contact No: ${client['contact']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Client Page
class AddClientPage extends StatefulWidget {
  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  void _saveClient() {
    if (nameController.text.isEmpty ||
        projectController.text.isEmpty ||
        locationController.text.isEmpty ||
        contactController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      Map<String, String> newClient = {
        'name': nameController.text,
        'project': projectController.text,
        'location': locationController.text,
        'contact': contactController.text,
      };
      Navigator.pop(context, newClient);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Client Name'),
            ),
            TextField(
              controller: projectController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact No'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveClient,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save Client', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
