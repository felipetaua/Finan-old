import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdicionarTransacaoPage extends StatelessWidget {
  const AdicionarTransacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Conteúdo da OutrosScreen
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildYearSelector(),
                    const SizedBox(height: 16),
                    _buildIncomeExpenseSummary(),
                    const SizedBox(height: 16),
                    SizedBox(height: 200, child: _buildLineChart()),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Despesas",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.sort),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildExpenseItem(Icons.home, "Rensidência", 71, 2550),
                    _buildExpenseItem(Icons.restaurant, "Comida", 23, 827.32),
                    _buildExpenseItem(Icons.directions_car, "Carro", 3, 108),
                    _buildExpenseItem(Icons.wifi, "Internet", 2, 80),
                    const SizedBox(height: 24),
                    const Text(
                      "Resumo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildQuickStats("Gasto médio", "R\$1.116,83"),
                    _buildQuickStats("Maior categoria", "Rens. - R\$2.550,80"),
                    _buildQuickStats("Total de gastos", "R\$3,565.32"),
                  ],
                ),
              ),

              // Gastos mensais
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gastos mensais',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                                    color: Colors.blue,
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
                              Text('Receita: R\$ 2.746,00'),
                              Text('Despesas: R\$ 2.746,00'),
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildYearSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("2023  ", style: TextStyle(color: Colors.grey)),
        Text("2024", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("  2025", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildIncomeExpenseSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Column(
          children: [
            Text("Renda", style: TextStyle(color: Colors.blue)),
            SizedBox(height: 4),
            Text(
              "\$2,450",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Text("Despesa", style: TextStyle(color: Colors.pink)),
            SizedBox(height: 4),
            Text(
              "\$2,535",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 5),
              FlSpot(1, 6),
              FlSpot(2, 4),
              FlSpot(3, 7),
              FlSpot(4, 6),
            ],
            isCurved: true,
            gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
            barWidth: 4,
          ),
          LineChartBarData(
            spots: const [
              FlSpot(0, 4),
              FlSpot(1, 5),
              FlSpot(2, 3),
              FlSpot(3, 6),
              FlSpot(4, 7),
            ],
            isCurved: true,
            gradient: LinearGradient(colors: [Colors.pink, Colors.pinkAccent]),
            barWidth: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(
    IconData icon,
    String label,
    int percent,
    double value,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(label),
      subtitle: Text("$percent%"),
      trailing: Text("R\$${value.toStringAsFixed(2)}"),
    );
  }

  Widget _buildQuickStats(String title, String value) {
    return ListTile(
      leading: const Icon(Icons.info_outline, color: Colors.grey),
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
