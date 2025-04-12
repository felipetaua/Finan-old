import 'package:finan/pages/home/ferramentas/calculadora.dart';
import 'package:finan/pages/home/ferramentas/conversorMoeda.dart';
import 'package:finan/pages/home/ferramentas/porcentagem.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF368DF7),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Kit Financeiro',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              const Text(
                'Ferramentas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Ferramentas
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 colunas
                    mainAxisSpacing: 16, // Espaçamento vertical entre os cards
                    crossAxisSpacing: 16,
                  ),
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: ToolCard(
                        title: 'Porcentagem',
                        iconPath: 'assets/images/percent.png',
                        background: const LinearGradient(
                          colors: [Colors.orange, Colors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const PorcentagemCalculadoraPage(), // Página do conversor
                            ),
                          );
                        },
                      ),
                    ),
                    // Card de Conversor (1x1)
                    ToolCard(
                      title: 'Conversor',
                      iconPath: 'assets/images/conversor.png',
                      background: const LinearGradient(
                        colors: [Colors.orange, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const ConversorMoedasPage(), // Página do conversor
                          ),
                        );
                      },
                    ),
                    ToolCard(
                      title: 'Calculadora',
                      iconPath: 'assets/images/calculadora.png',
                      background: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const CalculadoraPage(), // Página da calculadora
                          ),
                        );
                      },
                    ),
                    ToolCard(
                      title: 'Add',
                      iconPath: 'assets/images/calculadora.png',
                      background: const LinearGradient(
                        colors: [Colors.blue, Colors.deepPurpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AddPage(), // Página de exemplo
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Conhecimento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Explore Crypto com PageView
              SizedBox(
                height: 150,
                child: PageView(
                  children: [
                    CryptoCard(
                      title: 'Explore o mundo das Cryptos!',
                      description: 'Descubra as melhores moedas digitais.',
                      imagePath: 'assets/images/rocket_crypto.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CryptoDetailsPage(),
                          ),
                        );
                      },
                    ),
                    CryptoCard(
                      title: 'Invista em Bitcoin!',
                      description: 'A moeda digital mais popular do mundo.',
                      imagePath: 'assets/images/Bitcoin.png.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CryptoDetailsPage(),
                          ),
                        );
                      },
                    ),
                    CryptoCard(
                      title: 'Ethereum',
                      description: 'A plataforma para contratos inteligentes.',
                      imagePath: 'assets/images/Ethereum.svg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CryptoDetailsPage(),
                          ),
                        );
                      },
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
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ToolCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Gradient background;
  final VoidCallback onTap; // Função de callback para navegação

  const ToolCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.background,
    required this.onTap, // Adicione o parâmetro onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executa a função ao clicar no card
      child: Container(
        decoration: BoxDecoration(
          gradient: background,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  iconPath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const CryptoCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2B2E6F), Color(0xFF1E2337)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}

class CryptoDetailsPage extends StatelessWidget {
  const CryptoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Crypto')),
      body: const Center(child: Text('Detalhes sobre a Crypto selecionada.')),
    );
  }
}
