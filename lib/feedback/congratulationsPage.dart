// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RegisterExpensePage extends StatefulWidget {
  const RegisterExpensePage({super.key});

  @override
  _RegisterExpensePageState createState() => _RegisterExpensePageState();
}

class _RegisterExpensePageState extends State<RegisterExpensePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateRegisterExpense();
  }

  Future<void> _simulateRegisterExpense() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _isLoading ? _buildLoading() : _buildSuccess(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      key: ValueKey('loading'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Colors.green),
        SizedBox(height: 20),
        Text('Registrando gasto...', style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildSuccess() {
    return Column(
      key: ValueKey('success'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedScale(
          scale: 1,
          duration: Duration(milliseconds: 500),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(24),
            child: Icon(Icons.check, color: Colors.white, size: 64),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Ação efetuada com sucesso!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: Text('Concluído', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
