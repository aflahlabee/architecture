import 'package:flutter/material.dart';

class FloorPlansPage extends StatelessWidget {
  final List<String> pdfFiles = ["PDF 1", "PDF 2", "PDF 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue, // Highlight color
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Awards"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black,
                    child: Text("Logo", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  Text(
                    "App Name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    child: Text("Client\nDp", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Section Title
              Text(
                "Designs | Floor Plans",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 15),

              // PDF Grid
              Expanded(
                child: GridView.builder(
                  itemCount: pdfFiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${pdfFiles[index]} Clicked")),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf, size: 40, color: Colors.redAccent),
                            SizedBox(height: 8),
                            Text(
                              pdfFiles[index],
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
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
      ),
    );
  }
}
