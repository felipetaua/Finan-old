import 'package:flutter/material.dart';

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
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item['icon']),
                  ),
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
