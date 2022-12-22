import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDokQpb2UDMHnB-XDhKnYXjRJMgvPHH49k",
          appId: "1:264089181284:web:dae0b8071605d378069371",
          messagingSenderId: "264089181284",
          projectId: "taqeem-bcdb2"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: LoginPage(),
      );
}
