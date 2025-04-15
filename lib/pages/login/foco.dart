import 'package:finan/pages/home/main/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FocoPage extends StatelessWidget {
  const FocoPage({super.key});

  void navegarPara(BuildContext context, String focoEscolhido) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('foco', focoEscolhido);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GastosPage(nomeUsuario: 'Usuário'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          child: AppBar(
            title: Text('Finan', style: GoogleFonts.getFont('Aoboshi One')),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Qual seu foco\nno app?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF368DF7),
                ),
              ),
              const SizedBox(height: 32),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: [
                    _buildCard(
                      context,
                      title: 'Poupar',
                      description:
                          'Foco em guardar dinheiro para algum objetivo.',
                      icon: Icons.pie_chart_outline,
                      color: const Color(0xFFA3D59C),
                      rota: '/poupar',
                    ),
                    _buildCard(
                      context,
                      title: 'Investimentos',
                      description:
                          'Administre seus investimentos, ações, FIIS, crypto e ETFs.',
                      icon: Icons.bar_chart,
                      color: const Color(0xFF99D3E4),
                      rota: '/investimentos',
                    ),
                    _buildCard(
                      context,
                      title: 'Economia\nDoméstica',
                      description: 'Aprenda e aplique dentro da sua casa.',
                      icon: Icons.sentiment_satisfied_alt_outlined,
                      color: const Color(0xFFF2D388),
                      rota: '/economia-domestica',
                    ),
                    _buildCard(
                      context,
                      title: 'Gastos',
                      description:
                          'Mapeie seus gastos, consumos e veja o que pode melhorar.',
                      icon: Icons.attach_money,
                      color: const Color(0xFFE4928E),
                      rota: '/gastos',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String rota,
  }) {
    return GestureDetector(
      onTap: () => navegarPara(context, title),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
