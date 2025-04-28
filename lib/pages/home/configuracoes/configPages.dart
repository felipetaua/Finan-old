import 'package:finan/pages/home/configuracoes/informacoesLegais.dart';
import 'package:finan/pages/home/configuracoes/termosDePrivacidade.dart';
import 'package:finan/pages/home/configuracoes/termosDeUso.dart';
import 'package:finan/pages/login/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  final bool temaEscuro;
  final ValueChanged<bool> onTemaAlterado;

  const ConfiguracoesPage({
    super.key,
    required this.temaEscuro,
    required this.onTemaAlterado,
  });

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool notificacoesAtivadas = true;
  bool modoCompacto = false;
  bool biometria = true;
  bool pinAtivado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Configurações')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Preferências'),
            _buildCard(
              title: 'Tema',
              subtitle: widget.temaEscuro ? 'Escuro' : 'Claro',
              icon: Icons.color_lens,
              trailing: Switch(
                value: widget.temaEscuro,
                onChanged: (bool value) {
                  widget.onTemaAlterado(
                    value,
                  ); // Chama a função passada para alterar o tema
                },
                activeTrackColor: const Color(0xFF368DF7),
              ),
            ),
            _buildCard(
              title: 'Idioma',
              subtitle: 'Português (Brasil)',
              icon: Icons.language,
              trailing: const Icon(Icons.chevron_right),
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
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermosDeUsoPage()),
                );
              },
            ),
            _buildCard(
              title: 'Política de Privacidade',
              subtitle: 'Como seus dados são tratados',
              icon: Icons.privacy_tip,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PoliticaDePrivacidadePage(),
                  ),
                );
              },
            ),
            _buildCard(
              title: 'Informações Legais',
              subtitle: 'Conformidade e regulamentações',
              icon: Icons.gavel,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformacoesLegaisPage(),
                  ),
                );
              },
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
              trailing: const Icon(Icons.chevron_right),
            ),
            _buildCard(
              title: 'Sair da Conta',
              subtitle: 'Encerrar sessão atual',
              icon: Icons.logout,
              trailing: const Icon(Icons.exit_to_app),
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
          color: Theme.of(context).textTheme.bodyMedium?.color,
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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  // Exibir o diálogo de logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Deseja sair?'),
            content: const Text(
              'Você tem certeza que deseja sair da sua conta?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Sair'),
              ),
            ],
          ),
    );
  }
}
