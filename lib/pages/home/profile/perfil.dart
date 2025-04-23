import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String? currentAvatar;
  const ProfilePage({super.key, this.currentAvatar});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final dataNascController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = prefs.getString('nome') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      senhaController.text = prefs.getString('senha') ?? '';
      dataNascController.text = prefs.getString('dataNascimento') ?? '';
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nomeController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('senha', senhaController.text);
    await prefs.setString('dataNascimento', dataNascController.text);
  }

  void _toggleEditing() {
    setState(() {
      if (isEditing) _saveProfileData();
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF368DF7),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit),
                onPressed: _toggleEditing,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Seu nome:',
                icon: Icons.person,
                controller: nomeController,
                enabled: isEditing,
              ),
              InputField(
                label: 'Email:',
                icon: Icons.email,
                controller: emailController,
                enabled: isEditing,
              ),
              InputField(
                label: 'Senha:',
                icon: Icons.lock,
                controller: senhaController,
                obscureText: true,
                enabled: isEditing,
              ),
              InputField(
                label: 'Data de nascimento:',
                icon: Icons.calendar_today,
                controller: dataNascController,
                enabled: isEditing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool enabled;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.enabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: label,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
