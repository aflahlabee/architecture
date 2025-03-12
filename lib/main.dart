import 'package:architecture_app/Cleint/cleinthomepgae.dart';
import 'package:architecture_app/Cleint/cleintloginpage.dart';
import 'package:architecture_app/Staff/staffhomepage.dart';
import 'package:architecture_app/Staff/staffloginpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:architecture_app/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // 🟢 Register Hive Adapters (Ensure StaffAdapter is registered before opening the box)
  await Hive.openBox('userBox');

  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/SplashScreen', // Default route
    routes: {
      // 🟢 Staff Routes
      '/staffLogin': (context) => StaffLoginPage(),
      '/staffHome': (context) => StaffHomePage(),

      // 🟢 Client Routes
      '/clientLogin': (context) => ClientLoginPage(),
      '/clientHome': (context) => ClientHomePage(),
    },
  ));
}
