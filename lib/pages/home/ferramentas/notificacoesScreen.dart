import 'package:flutter/material.dart';

class NotificacoesPage extends StatelessWidget {
  NotificacoesPage({super.key});

  final List<Map<String, dynamic>> notificacoes = [
    {
      'titulo': 'IPVA',
      'descricao': 'Você possui o IPVA de 2025 para pagar',
      'data': '23/01/2025',
      'barraCor': Colors.green,
      'imagemPath': 'assets/images/ipva.png',
    },
    {
      'titulo': 'Declaração de Imposto',
      'descricao': 'Declare sua renda anualmente',
      'data': '18/02/2025',
      'barraCor': Colors.red,
      'imagemPath': 'assets/images/imposto.png',
    },
    // Adicione mais notificações aqui
  ];

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
              'Notificações',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: const TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.blueAccent,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Pesquise',

                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Filtros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                filtroBotao('Tudo', selecionado: true),
                filtroBotao('Recentes'),
                filtroBotao('Ultimos'),
              ],
            ),
            const SizedBox(height: 8),
            // Lista de notificações
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: notificacoes.length, // Número de notificações
                itemBuilder: (context, index) {
                  final notificacao = notificacoes[index];
                  return itemNotificacao(
                    notificacao['titulo'],
                    notificacao['descricao'],
                    notificacao['data'],
                    notificacao['barraCor'],
                    notificacao['imagemPath'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filtroBotao(String texto, {bool selecionado = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: selecionado ? const Color(0xFF368DF7) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF368DF7)),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: selecionado ? Colors.white : const Color(0xFF368DF7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget itemNotificacao(
    String titulo,
    String descricao,
    String data,
    Color barraCor,
    String imagemPath,
  ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
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
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagemPath),
            radius: 25,
            onBackgroundImageError: (_, __) {
              print('Erro ao carregar a imagem: $imagemPath');
            },
            child: const Icon(Icons.error, color: Colors.red),
          ),
          title: Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(descricao),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: 1,
                color: barraCor,
                backgroundColor: Colors.grey.shade200,
                minHeight: 5,
              ),
            ],
          ),
          trailing: Text(data),
        ),
      ),
    );
  }
}
