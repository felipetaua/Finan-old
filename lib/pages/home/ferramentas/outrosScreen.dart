import 'package:flutter/material.dart';

class OutrosScreen extends StatelessWidget {
  const OutrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outros'),
        backgroundColor: const Color(0xFF368DF7),
      ),
      body: const Center(
        child: Text(
          'Detalhes sobre Outros',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
