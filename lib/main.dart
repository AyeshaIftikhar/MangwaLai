import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../LoginPages/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangwa Lai',
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF900c3f),
          accentColor: Color(0xFF900c3f),
          // primarySwatch: Colors.red[900],
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          )),
    );
  }
}
