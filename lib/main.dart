import 'package:finan/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const FinanApp());
}

class FinanApp extends StatelessWidget {
  const FinanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finan')),
      body: const Center(child: Text('Firebase initialized — app default')),
    );
  }
}
