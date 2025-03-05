

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:architecture_app/WelcomePage.dart';



void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  
  // 🟢 Register Hive Adapters (Ensure StaffAdapter is registered before opening the box)
  

  await Hive.openBox('userBox'); 

   await Hive.openBox('userBox'); 

  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
