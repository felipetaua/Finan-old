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

              const SizedBox(height: 16),

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
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
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

class _AtivoItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(icon), radius: 20),
      title: Text(nome),
      subtitle: Text(
        'última cotação às 9:41',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(preco, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            variacao,
            style: TextStyle(
              fontSize: 12,
              color: up ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
