import 'package:flutter/material.dart';

class ListaDetalhadaPage extends StatelessWidget {
  final String titulo;
  final List<Map<String, dynamic>> ativos;

  const ListaDetalhadaPage({
    super.key,
    required this.titulo,
    required this.ativos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: ListView.builder(
        itemCount: ativos.length,
        itemBuilder: (context, index) {
          final ativo = ativos[index];
          return ListTile(
            leading: Image.asset(ativo['icon'], width: 30, height: 30),
            title: Text(ativo['nome']),
            subtitle: Text(ativo['preco']),
            trailing: Text(
              ativo['variacao'],
              style: TextStyle(color: ativo['up'] ? Colors.green : Colors.red),
            ),
          );
        },
      ),
    );
  }
}
