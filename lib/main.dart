import 'package:social_pay/screens/Drawer_Screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'package:social_pay/admin/Admin_Screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        'welcome': (context) => WelcomeScreen(),
        'admin' : (context) => AdminPage(),
        'screen': (context) => DrawerPage(),
      },
    );
  }
}
