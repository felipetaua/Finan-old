import 'dart:math';

import 'package:flutter/material.dart';

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

class InvestimentoListaPage extends StatefulWidget {
  final String tipo;
  final List<Map<String, dynamic>> itens;

  const InvestimentoListaPage({
    required this.tipo,
    required this.itens,
    super.key,
  });

  @override
  State<InvestimentoListaPage> createState() => _InvestimentoListaPageState();
}

String getRandomAssetImage(List<String> imagens) {
  final random = Random();
  final imagem = imagens[random.nextInt(imagens.length)];
  return 'assets/images/investimentos/abstratos/$imagem';
}

class _InvestimentoListaPageState extends State<InvestimentoListaPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredItens =
        widget.itens.where((item) {
          return item['nome'].toLowerCase().contains(searchText.toLowerCase());
        }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de ${widget.tipo}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => searchText = value),
              decoration: InputDecoration(
                hintText: 'Buscar ${widget.tipo}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItens.length,
              itemBuilder: (context, index) {
                final item = filteredItens[index];
                final imagem = getRandomAssetImage(imagens);
                return ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(imagem)),
                  title: Text(item['nome']),
                  subtitle: Text(item['preco']),
                  trailing: Text(
                    item['variacao'],
                    style: TextStyle(
                      color: item['up'] ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
