import 'package:flutter/material.dart';


class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<int> years = List.generate(12, (index) => 2014 + index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Name")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: years.length + 1,
          itemBuilder: (context, index) {
            if (index == years.length) {
              return _buildAddNewFolderButton();
            }
            return _buildYearTile(years[index]);
          },
        ),
      ),
    );
  }

  Widget _buildYearTile(int year) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProjectsYearPage(year: year)),
        );
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text("$year")),
      ),
    );
  }

  Widget _buildAddNewFolderButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          years.add(years.last + 1);
        });
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ProjectsYearPage extends StatefulWidget {
  final int year;
  ProjectsYearPage({required this.year});

  @override
  _ProjectsYearPageState createState() => _ProjectsYearPageState();
}

class _ProjectsYearPageState extends State<ProjectsYearPage> {
  List<String> projects = List.generate(10, (index) => "Project ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Projects | ${widget.year}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: projects.length + 1,
          itemBuilder: (context, index) {
            if (index == projects.length) {
              return _buildAddNewProjectButton();
            }
            return _buildProjectTile(projects[index]);
          },
        ),
      ),
    );
  }

  Widget _buildProjectTile(String projectName) {
    return Container(
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text(projectName)),
    );
  }

  Widget _buildAddNewProjectButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          projects.add("Project ${projects.length + 1}");
        });
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
