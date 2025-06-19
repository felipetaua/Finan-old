import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowWalletPage extends StatelessWidget {
  const ShowWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Total de Ativos"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "R\$12,547.50",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildCard(
                    "1028",
                    "R\$9,425",
                    const FaIcon(
                      FontAwesomeIcons.ccMastercard,
                      color: Colors.white,
                    ),
                    Colors.black,
                  ),
                  const SizedBox(width: 12),
                  _buildCard(
                    "5602",
                    "R\$4,620",
                    const FaIcon(FontAwesomeIcons.ccVisa, color: Colors.white),
                    Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Transações Recentes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildTransaction(
                "BitCoin",
                "Completado por FinanCorp.",
                "+R\$90,00",
                Colors.green,
              ),
              _buildTransaction(
                "LiL",
                "Venda de LilusCrypto",
                "-R\$550.00",
                Colors.black,
              ),
              _buildTransaction(
                "Etherium",
                "Completado por FinanCorp.",
                "+R\$39.99",
                Colors.green,
              ),
              _buildTransaction(
                "DogeCoin",
                "Completado por FinanCorp.",
                "+R\$14.98",
                Colors.green,
              ),
              const SizedBox(height: 24),
              const Text(
                "Frequência de Investimentos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(height: 180, child: _buildBarChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String number, String amount, Widget icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("****", style: TextStyle(color: Colors.white)),
                Text(number, style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 8), // Espaço entre os textos
                icon,
              ],
            ),
            const SizedBox(height: 20),
            Text(
              amount,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransaction(
    String name,
    String desc,
    String value,
    Color color,
  ) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.update, color: Colors.white),
      ),
      title: Text(name),
      subtitle: Text(desc),
      trailing: Text(value, style: TextStyle(color: color)),
    );
  }

  Widget _buildBarChart() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1b1d2e),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ), 
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text(
                        'Jan',
                        style: TextStyle(color: Colors.white),
                      );
                    case 1:
                      return const Text(
                        'Fev',
                        style: TextStyle(color: Colors.white),
                      );
                    case 2:
                      return const Text(
                        'Mar',
                        style: TextStyle(color: Colors.white),
                      );
                    case 3:
                      return const Text(
                        'Abr',
                        style: TextStyle(color: Colors.white),
                      );
                    case 4:
                      return const Text(
                        'Mai',
                        style: TextStyle(color: Colors.white),
                      );
                    default:
                      return const Text('');
                  }
                },
                reservedSize: 32,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 6, color: Colors.blue)],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 7, color: Colors.pink)],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [BarChartRodData(toY: 5, color: Colors.blue)],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [BarChartRodData(toY: 8, color: Colors.pink)],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [BarChartRodData(toY: 6, color: Colors.blue)],
            ),
          ],
        ),
      ),
    );
  }
}
