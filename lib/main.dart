import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';
import 'Screens/IntroAuthScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? const IntroAuthScreen() : const HomePage(),
    );
  }
}
