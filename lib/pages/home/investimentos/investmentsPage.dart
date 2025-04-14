import 'package:finan/pages/home/investimentos/cryptoPage.dart';
import 'package:flutter/material.dart';

class InvestimentosPage extends StatelessWidget {
  const InvestimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de busca
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Pesquise',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.filter_list),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Título
              const Text(
                'Investimentos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Favoritos e Ações
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _InvestimentoBox(
                      label: 'Favoritos',
                      image: 'assets/images/card-invest-favoritos.png',
                    ),
                    SizedBox(width: 16), // Espaçamento entre os elementos
                    _InvestimentoBox(
                      label: 'Ações',
                      image: 'assets/images/card-invest-acoes.png',
                    ),
                    SizedBox(width: 16), // Espaçamento entre os elementos
                    _InvestimentoBox(
                      label: 'Fundos',
                      image: 'assets/images/card-invest-fundos.png',
                    ),
                    SizedBox(width: 16), // Espaçamento entre os elementos
                    _InvestimentoBox(
                      label: 'Criptos',
                      image: 'assets/images/card-invest-criptos.png',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

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

              const SizedBox(height: 24),

              // Lista de ativos
              const Text(
                'Ativos financeiros',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: const [
                    _AtivoItem(
                      nome: 'Vechain',
                      preco: 'R\$14.122,86',
                      variacao: '-10.5%',
                      up: false,
                      icon: 'assets/images/vechain.png',
                    ),
                    _AtivoItem(
                      nome: 'Bitcoin',
                      preco: 'R\$489.128,80',
                      variacao: '+1.9%',
                      up: true,
                      icon: 'assets/images/bitcoin.png',
                    ),
                    _AtivoItem(
                      nome: 'Etherium',
                      preco: 'R\$24.143,82',
                      variacao: '+1.7%',
                      up: true,
                      icon: 'assets/images/etherium.png',
                    ),
                    _AtivoItem(
                      nome: 'Bytecoin',
                      preco: 'R\$8.503,12',
                      variacao: '+3.9%',
                      up: true,
                      icon: 'assets/images/bytecoin.png',
                    ),
                    _AtivoItem(
                      nome: 'NK7',
                      preco: 'R\$489.128,80',
                      variacao: '+1.9%',
                      up: true,
                      icon: 'assets/images/nk7.png',
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

class _InvestimentoBox extends StatelessWidget {
  final String label;
  final String image;

  const _InvestimentoBox({required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 3, color: Colors.black)],
        ),
      ),
    );
  }
}

class _AtivoItem extends StatefulWidget {
  final String nome;
  final String preco;
  final String variacao;
  final bool up;
  final String icon;

  const _AtivoItem({
    required this.nome,
    required this.preco,
    required this.variacao,
    required this.up,
    required this.icon,
  });

  @override
  State<_AtivoItem> createState() => _AtivoItemState();
}

class _AtivoItemState extends State<_AtivoItem> {
  bool _isExpanded = false; // Controla se o item está expandido

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Alterna entre expandido e contraído
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.2 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.icon),
                  radius: 20,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.nome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.preco,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.variacao,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.up ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Detalhes do ativo:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Última cotação às 9:41\nVolume negociado: 1.234 BTC\nAlta do dia: R\$500.000,00\nBaixa do dia: R\$480.000,00',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
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
            Image.asset(
              imagePath,
              height: 130,
              width: 130,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
