import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taqeem/home_page.dart';

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
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 50.0),
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
