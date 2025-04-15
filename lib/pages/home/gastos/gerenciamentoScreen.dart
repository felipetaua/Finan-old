import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdicionarTransacaoPage extends StatelessWidget {
  const AdicionarTransacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Gastos mensais
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gastos mensais',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 255).toInt()),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: 50,
                                  radius: 10,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  color: Colors.red,
                                  value: 50,
                                  radius: 10,
                                  showTitle: false,
                                ),
                              ],
                              centerSpaceRadius: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Janeiro 2025',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('Receita: R\$ 4.746,00'),
                            Text('Despesas: R\$ 4.746,00'),
                            Text('Receita: R\$ 0'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Histórico de gastos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Histórico de seus gastos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.05 * 255).toInt()),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 150,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 3),
                              FlSpot(1, 4),
                              FlSpot(2, 5),
                              FlSpot(3, 4),
                              FlSpot(4, 3),
                              FlSpot(5, 6),
                            ],
                            isCurved: true,
                            color: Colors.purple,
                            dotData: FlDotData(show: true),
                          ),
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 2),
                              FlSpot(1, 3),
                              FlSpot(2, 4),
                              FlSpot(3, 3),
                              FlSpot(4, 2),
                              FlSpot(5, 4),
                            ],
                            isCurved: true,
                            color: Colors.blue,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF368DF7),
        shape: const CircleBorder(),
        heroTag: 'adicionar_transacao_fab', // Tag única para este botão
        child: const Icon(Icons.add),
      ),
    );
  }
}
