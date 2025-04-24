import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GerenciamentoScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transacoes = [
    {'titulo': 'Mercado', 'valor': 150.00, 'categoria': 'Alimentação', 'data': '2025-04-21'},
    {'titulo': 'Uber', 'valor': 30.00, 'categoria': 'Transporte', 'data': '2025-04-22'},
    {'titulo': 'Cinema', 'valor': 45.00, 'categoria': 'Lazer', 'data': '2025-04-20'},
    {'titulo': 'Restaurante', 'valor': 80.00, 'categoria': 'Alimentação', 'data': '2025-04-22'},
  ];

  GerenciamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> totalPorCategoria = {};
    for (var t in transacoes) {
      totalPorCategoria[t['categoria']] =
          (totalPorCategoria[t['categoria']] ?? 0) + t['valor'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Gastos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Gráfico de Pizza
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: totalPorCategoria.entries.map((entry) {
                    final color = _getColor(entry.key);
                    return PieChartSectionData(
                      color: color,
                      value: entry.value,
                      title: '${entry.key}\nR\$${entry.value.toStringAsFixed(0)}',
                      radius: 60,
                      titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transacoes.length,
                itemBuilder: (context, index) {
                  final t = transacoes[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(Icons.category, color: _getColor(t['categoria'])),
                      title: Text(t['titulo']),
                      subtitle: Text('${t['categoria']} • ${t['data']}'),
                      trailing: Text(
                        'R\$${t['valor'].toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // Aqui você pode abrir uma tela de edição
                      },
                      onLongPress: () {
                        _mostrarConfirmacaoExclusao(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String categoria) {
    switch (categoria) {
      case 'Alimentação':
        return Colors.green;
      case 'Transporte':
        return Colors.blue;
      case 'Lazer':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _mostrarConfirmacaoExclusao(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir transação'),
        content: const Text('Deseja realmente excluir esta transação?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () {
              Navigator.of(context).pop();
              // Aqui você pode adicionar lógica para remover a transação
              // e atualizar a interface
            },
          ),
        ],
      ),
    );
  }
}
