import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Visão Geral',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sections: _buildChartSections(),
                    centerSpaceRadius: 70,
                    sectionsSpace: 4,
                    startDegreeOffset: -90,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'R\$978,85',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Balanço Disponível',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _FinancialInfo(
                color: Color(0xFF4A90E2),
                label: 'Ganhos',
                amount: 'R\$1.582,67',
              ),
              _FinancialInfo(
                color: Color(0xFFD0021B),
                label: 'Gastos',
                amount: 'R\$595,11',
              ),
              _FinancialInfo(
                color: Color(0xFF7ED321),
                label: 'Disponível',
                amount: 'R\$987,56',
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections() {
    final double earnings = 1582.67;
    final double spend = 595.11;
    final double total = earnings + spend;

    return [
      PieChartSectionData(
        color: const Color(0xFF4A90E2),
        value: (earnings / total) * 100,
        title: '${((earnings / total) * 100).toStringAsFixed(0)}%',
        radius: 30,
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: const Color(0xFFD0021B),
        value: (spend / total) * 100,
        title: '${((spend / total) * 100).toStringAsFixed(0)}%',
        radius: 30,
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}

class _FinancialInfo extends StatelessWidget {
  final Color color;
  final String label;
  final String amount;

  const _FinancialInfo({
    required this.color,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 5, backgroundColor: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          amount,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
