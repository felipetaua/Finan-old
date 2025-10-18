import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simples: navega para home
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
