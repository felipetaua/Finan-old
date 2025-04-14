import 'package:finan/pages/login/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool temaEscuro = false;
  bool notificacoesAtivadas = true;
  bool modoCompacto = false;
  bool biometria = true;
  bool pinAtivado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Preferências'),

            _buildCard(
              title: 'Tema',
              subtitle: temaEscuro ? 'Escuro' : 'Claro',
              icon: Icons.color_lens,
              trailing: Switch(
                value: temaEscuro,
                onChanged: (value) {
                  setState(() {
                    temaEscuro = value;
                  });
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),

            _buildCard(
              title: 'Idioma',
              subtitle: 'Português (Brasil)',
              icon: Icons.language,
              trailing: Icon(Icons.chevron_right),
            ),

            _buildCard(
              title: 'Notificações',
              subtitle: notificacoesAtivadas ? 'Ativadas' : 'Desativadas',
              icon: Icons.notifications,
              trailing: Switch(
                value: notificacoesAtivadas,
                onChanged: (value) {
                  setState(() {
                    notificacoesAtivadas = value;
                  });
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Layout'),

            _buildCard(
              title: 'Modo Compacto',
              subtitle: modoCompacto ? 'Ativado' : 'Desativado',
              icon: Icons.view_comfy,
              trailing: Switch(
                value: modoCompacto,
                onChanged: (value) {
                  setState(() {
                    modoCompacto = value;
                  });
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Privacidade'),

            _buildCard(
              title: 'Termos de Uso',
              subtitle: 'Direitos e deveres do usuário',
              icon: Icons.description,
              trailing: Icon(Icons.chevron_right),
            ),

            _buildCard(
              title: 'Política de Privacidade',
              subtitle: 'Como seus dados são tratados',
              icon: Icons.privacy_tip,
              trailing: Icon(Icons.chevron_right),
            ),

            _buildCard(
              title: 'Informações Legais',
              subtitle: 'Conformidade e regulamentações',
              icon: Icons.gavel,
              trailing: Icon(Icons.chevron_right),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Segurança'),

            _buildCard(
              title: 'Autenticação Biométrica',
              subtitle: biometria ? 'Ativada' : 'Desativada',
              icon: Icons.fingerprint,
              trailing: Switch(
                value: biometria,
                onChanged: (value) {
                  setState(() {
                    biometria = value;
                  });
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),

            _buildCard(
              title: 'PIN de Segurança',
              subtitle: pinAtivado ? 'PIN Ativo' : 'PIN Inativo',
              icon: Icons.lock,
              trailing: Switch(
                value: pinAtivado,
                onChanged: (value) {
                  setState(() {
                    pinAtivado = value;
                  });
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Conta'),

            _buildCard(
              title: 'Editar Perfil',
              subtitle: 'Nome, e-mail, avatar',
              icon: Icons.person,
              trailing: Icon(Icons.chevron_right),
            ),

            _buildCard(
              title: 'Sair da Conta',
              subtitle: 'Encerrar sessão atual',
              icon: Icons.logout,
              trailing: Icon(Icons.exit_to_app),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: ValueKey(title + subtitle),
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border:
              title ==
                      'Sair da Conta' // Verifica se o título é "Sair da Conta"
                  ? Border.all(
                    color: const Color.fromARGB(255, 255, 95, 84),
                    width: 2,
                  )
                  : title == 'Editar Perfil'
                  ? Border.all(color: Colors.grey, width: 2) // Borda vermelha
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

// Exibir o diálogo de logout
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Deseja sair?'),
          content: const Text('Você tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Fecha o diálogo
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Limpa os dados do usuário

                Navigator.pop(context); // Fecha o diálogo
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                  (route) => false, // Remove todas as telas anteriores
                );
              },
              child: const Text('Sair'),
            ),
          ],
        ),
  );
}
