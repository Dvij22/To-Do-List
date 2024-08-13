import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCn2NL8thHOsibmS7dU65xtHzSoeUr-n2A",
          appId: "1:950985436411:android:1e7713aa2fbff2fd35d45e",
          messagingSenderId: "950985436411",
          projectId: "crud-app-cf7b9"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}
