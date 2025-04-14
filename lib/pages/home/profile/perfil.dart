import 'package:finan/pages/home/profile/avatarSelector.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String? currentAvatar;
  const ProfilePage({super.key, this.currentAvatar});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? selectedAvatar;

  @override
  void initState() {
    super.initState();
    _loadAvatar(); // Carrega o avatar ao abrir a tela
  }

  // Carregar o avatar salvo em SharedPreferences
  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAvatar = prefs.getString('avatarPath');
    });
  }

  // Abrir a página de seleção de avatar
  Future<void> _showAvatarSelector() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AvatarSelectorPage(currentAvatar: selectedAvatar),
      ),
    );

    // Atualizar o avatar selecionado
    if (result != null && result is String?) {
      setState(() {
        selectedAvatar = result;
      });
    }
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
              onPressed:
                  () => Navigator.pop(context), // Voltar para a tela anterior
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed:
                    _showAvatarSelector, // Abrir a página de seleção de avatar
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
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    selectedAvatar != null
                        ? AssetImage(selectedAvatar!) // Avatar selecionado
                        : const AssetImage(
                          'assets/images/avatar.png',
                        ), // Avatar padrão
              ),
              const SizedBox(height: 20),
              const InputField(
                label: 'Seu nome:',
                icon: Icons.person,
                hintText: 'Bruno do Morro do Grau',
              ),
              const InputField(
                label: 'Email:',
                icon: Icons.email,
                hintText: 'brunograu@gmail.com',
              ),
              const InputField(
                label: 'Senha:',
                icon: Icons.lock,
                hintText: '**********',
                obscureText: true,
                suffixIcon: Icons.visibility_off,
              ),
              const InputField(
                label: 'Data de nascimento:',
                icon: Icons.calendar_today,
                hintText: '  /  /',
              ),
              const SizedBox(height: 20),
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
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
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
