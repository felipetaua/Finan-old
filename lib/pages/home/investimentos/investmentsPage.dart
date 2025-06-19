import 'dart:math';

import 'package:finan/pages/home/investimentos/cryptoPage.dart';
import 'package:finan/pages/home/investimentos/listaDetalhada.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:finan/pages/home/investimentos/investimento_lista_page.dart';

const listaAcoes = [
  {
    'nome': 'PETR4',
    'preco': 'R\$29,45',
    'variacao': '+1.5%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'VALE3',
    'preco': 'R\$68,10',
    'variacao': '-0.3%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'ITUB4',
    'preco': 'R\$28,70',
    'variacao': '+0.9%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'BBDC4',
    'preco': 'R\$23,50',
    'variacao': '-1.2%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'ABEV3',
    'preco': 'R\$15,30',
    'variacao': '+0.5%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'BBAS3',
    'preco': 'R\$38,20',
    'variacao': '+0.8%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'WEGE3',
    'preco': 'R\$42,00',
    'variacao': '+2.1%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'MGLU3',
    'preco': 'R\$4,85',
    'variacao': '-2.5%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'LREN3',
    'preco': 'R\$36,10',
    'variacao': '+1.3%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'SUZB3',
    'preco': 'R\$56,40',
    'variacao': '-0.6%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
];

const listaFundos = [
  {
    'nome': 'BCFF11',
    'preco': 'R\$88,60',
    'variacao': '+2.1%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'XPLG11',
    'preco': 'R\$112,45',
    'variacao': '-0.8%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'HGLG11',
    'preco': 'R\$170,90',
    'variacao': '+0.7%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'KNRI11',
    'preco': 'R\$143,10',
    'variacao': '-0.4%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'MXRF11',
    'preco': 'R\$10,90',
    'variacao': '+1.2%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'VISC11',
    'preco': 'R\$104,00',
    'variacao': '+1.0%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'HGRE11',
    'preco': 'R\$129,60',
    'variacao': '-1.0%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'RECR11',
    'preco': 'R\$95,70',
    'variacao': '+0.3%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'FIIB11',
    'preco': 'R\$140,80',
    'variacao': '-0.2%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'JSRE11',
    'preco': 'R\$110,00',
    'variacao': '+1.4%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
];

const listaCriptos = [
  {
    'nome': 'Bitcoin',
    'preco': 'R\$300.000,00',
    'variacao': '+3.2%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Ethereum',
    'preco': 'R\$20.000,00',
    'variacao': '+1.0%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Litecoin',
    'preco': 'R\$600,00',
    'variacao': '+0.8%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Ripple',
    'preco': 'R\$3,50',
    'variacao': '-2.0%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Cardano',
    'preco': 'R\$1,30',
    'variacao': '+4.1%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Polkadot',
    'preco': 'R\$38,50',
    'variacao': '+0.9%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Solana',
    'preco': 'R\$180,00',
    'variacao': '-1.3%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Chainlink',
    'preco': 'R\$60,00',
    'variacao': '+2.7%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Dogecoin',
    'preco': 'R\$0,90',
    'variacao': '+1.1%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'Shiba Inu',
    'preco': 'R\$0,00007',
    'variacao': '-0.5%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
];

const listaEtfs = [
  {
    'nome': 'IVVB11',
    'preco': 'R\$300,00',
    'variacao': '+1.7%',
    'up': true,
    'icon': 'assets/images/investimento/abstratos/',
  },
  {
    'nome': 'BOVA11',
    'preco': 'R\$110,00',
    'variacao': '-0.5%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'SMAL11',
    'preco': 'R\$115,00',
    'variacao': '+2.3%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'DIVO11',
    'preco': 'R\$110,20',
    'variacao': '+0.4%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'XFIX11',
    'preco': 'R\$100,00',
    'variacao': '-1.1%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'ECOO11',
    'preco': 'R\$92,40',
    'variacao': '+1.5%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'FIND11',
    'preco': 'R\$87,10',
    'variacao': '-0.3%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'HASH11',
    'preco': 'R\$48,90',
    'variacao': '+3.8%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'BOVX11',
    'preco': 'R\$120,00',
    'variacao': '-1.0%',
    'up': false,
    'icon': 'assets/images/investimentos/abstratos/',
  },
  {
    'nome': 'GOVE11',
    'preco': 'R\$89,30',
    'variacao': '+2.6%',
    'up': true,
    'icon': 'assets/images/investimentos/abstratos/',
  },
];

List<Map<String, dynamic>> todosAtivos = [
  ...listaAcoes,
  ...listaFundos,
  ...listaCriptos,
  ...listaEtfs,
];

List<String> imagens = [
  'invest (1).png',
  'invest (2).png',
  'invest (3).png',
  'invest (4).png',
  'invest (5).png',
  'invest (6).png',
  'invest (7).png',
  'invest (8).png',
  'invest (9).png',
  'invest (10).png',
  'invest (11).png',
  'invest (12).png',
  'invest (13).png',
  'invest (14).png',
  'invest (15).png',
  'invest (16).png',
  'invest (17).png',
  'invest (18).png',
  'invest (19).png',
  'invest (20).png',
  'invest (21).png',
  'invest (22).png',
  'invest (23).png',
  'invest (24).png',
  'invest (25).png',
  'invest (26).png',
  'invest (27).png',
  'invest (28).png',
  'invest (29).png',
  'invest (30).png',
  'invest (31).png',
  'invest (32).png',
  'invest (33).png',
  'invest (34).png',
  'invest (35).png',
  'invest (36).png',
  'invest (37).png',
  'invest (38).png',
  'invest (39).png',
  'invest (40).png',
  'invest (41).png',
  'invest (42).png',
  'invest (43).png',
  'invest (44).png',
  'invest (45).png',
  'invest (46).png',
  'invest (47).png',
  'invest (48).png',
  'invest (49).png',
  'invest (50).png',
  'invest (51).png',
  'invest (52).png',
  'invest (53).png',
  'invest (54).png',
  'invest (55).png',
  'invest (56).png',
  'invest (57).png',
  'invest (58).png',
  'invest (59).png',
  'invest (60).png',
  'invest (61).png',
  'invest (62).png',
  'invest (63).png',
  'invest (64).png',
  'invest (65).png',
  'invest (66).png',
  'invest (67).png',
  'invest (68).png',
  'invest (69).png',
];

String getRandomAssetImage(List<String> nomesArquivos) {
  final random = Random();
  final nomeEscolhido = nomesArquivos[random.nextInt(nomesArquivos.length)];
  final caminho = 'assets/images/investimentos/abstratos/$nomeEscolhido';
  return caminho;
}

class InvestimentosPage extends StatefulWidget {
  const InvestimentosPage({super.key});

  @override
  State<InvestimentosPage> createState() => _InvestimentosPageState();
}

class _InvestimentosPageState extends State<InvestimentosPage> {
  final PageController cryptoController = PageController(
    viewportFraction: 1.00,
  );
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _filterSearch(String query) {
    final todosAtivos = [
      ...listaAcoes,
      ...listaFundos,
      ...listaCriptos,
      ...listaEtfs,
    ];

    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() {
      _searchResults =
          todosAtivos.where((ativo) {
            final nome = ativo['nome'].toString().toLowerCase();
            return nome.contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _abrirLista(String titulo, List<Map<String, dynamic>> lista) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ListaDetalhadaPage(
              titulo: titulo,
              ativos: lista,
              imagens: imagens, 
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController cryptoController = PageController(
      viewportFraction: 1.00,
    );

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
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterSearch,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Busque por ativos financeiros',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.filter_list),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Resultados da pesquisa
              if (_searchResults.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black26,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(maxHeight: 400),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final ativo = _searchResults[index];
                      return ListTile(
                        leading: Image.asset(
                          getRandomAssetImage(imagens),
                          width: 30,
                          height: 30,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                        ),

                        title: Text(ativo['nome']),
                        subtitle: Text(ativo['preco']),
                        trailing: Text(
                          ativo['variacao'],
                          style: TextStyle(
                            color: ativo['up'] ? Colors.green : Colors.red,
                          ),
                        ),
                        onTap: () {
                          _abrirLista('Resultado da busca', _searchResults);
                        },
                      );
                    },
                  ),
                ),

              // Título
              const Text(
                'Investimentos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: 
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InvestimentoBox(
                      label: 'Ações',
                      icon: const FaIcon(
                        FontAwesomeIcons.chartSimple,
                        color: Colors.white,
                      ),
                      image: 'assets/images/card-invest-acoes.png',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => InvestimentoListaPage(
                                    tipo: 'Ações',
                                    itens: listaAcoes,
                                  ),
                            ),
                          ),
                    ),
                    _InvestimentoBox(
                      label: 'Fundos',
                      icon: const FaIcon(
                        FontAwesomeIcons.solidBuilding,
                        color: Colors.white,
                      ),
                      image: 'assets/images/card-invest-fundos.png',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => InvestimentoListaPage(
                                    tipo: 'Fundos',
                                    itens: listaFundos,
                                  ),
                            ),
                          ),
                    ),
                    _InvestimentoBox(
                      label: 'Criptos',
                      icon: const FaIcon(
                        FontAwesomeIcons.bitcoin,
                        color: Colors.white,
                      ),
                      image: 'assets/images/card-invest-criptos.png',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => InvestimentoListaPage(
                                    tipo: 'Criptos',
                                    itens: listaCriptos,
                                  ),
                            ),
                          ),
                    ),
                    _InvestimentoBox(
                      label: 'ETF',
                      icon: const FaIcon(
                        FontAwesomeIcons.landmark,
                        color: Colors.white,
                      ),
                      image: 'assets/images/card-invest-favoritos.png',
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => InvestimentoListaPage(
                                    tipo: 'ETFs',
                                    itens: listaEtfs,
                                  ),
                            ),
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 180,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: cryptoController,
                        children: [
                          CryptoCard(
                            title: 'Explore o mundo das Cryptos!',
                            description:
                                'Descubra as melhores moedas digitais.',
                            imagePath: 'assets/images/rocket_crypto.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const CryptoDetailsPage(),
                                ),
                              );
                            },
                          ),
                          CryptoCard(
                            title: 'Invista em Bitcoin!',
                            description:
                                'A moeda digital mais popular do mundo.',
                            imagePath: 'assets/images/Bitcoin.png.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const CryptoDetailsPage(),
                                ),
                              );
                            },
                          ),
                          CryptoCard(
                            title: 'Ethereum',
                            description:
                                'A plataforma para contratos inteligentes.',
                            imagePath: 'assets/images/Ethereum.svg',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const CryptoDetailsPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: SmoothPageIndicator(
                        controller: cryptoController,
                        count: 3, // Número de cards
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Color(0xFF368DF7),
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                        ),
                      ),
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
  final Widget icon;
  final VoidCallback onTap;

  const _InvestimentoBox({
    required this.label,
    required this.image,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12),
        ),

        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 3, color: Colors.black)],
              ),
            ),
            const SizedBox(width: 20),
            icon, // Exibe o ícone
          ],
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
  bool _isExpanded = false; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; 
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
        margin: const EdgeInsets.symmetric(horizontal: 2),
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
