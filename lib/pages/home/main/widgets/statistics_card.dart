// lib/widgets/statistics_card.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key});

  // Dados de exemplo para os gastos da semana
  final List<double> weeklySpending = const [
    65.0,
    80.0,
    110.0,
    75.0,
    90.0,
    40.0,
    120.0,
  ];
  final double limitPerDay = 105.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '05 Jun',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Limit',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              Text(
                '\$${limitPerDay.toStringAsFixed(2)} per day',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: 150, // O valor máximo do eixo Y, um pouco acima do limite
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: _bottomTitles,
                    ),
                  ),
                ),
                // Esta é a linha pontilhada de limite
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: limitPerDay,
                      color: Colors.red.withOpacity(0.5),
                      strokeWidth: 2,
                      dashArray: [8, 4], // Padrão da linha pontilhada
                    ),
                  ],
                ),
                barGroups: _generateBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gera as barras do gráfico a partir dos dados da semana
  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(weeklySpending.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: weeklySpending[index],
            width: 16,
            color: const Color(0xFF3B82F6), // Azul
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    });
  }

  // Constrói os textos de baixo (dias da semana)
  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'MON';
        break;
      case 1:
        text = 'TUE';
        break;
      case 2:
        text = 'WED';
        break;
      case 3:
        text = 'THU';
        break;
      case 4:
        text = 'FRI';
        break;
      case 5:
        text = 'SAT';
        break;
      case 6:
        text = 'SUN';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      fitInside: meta.axisSide,
      meta: null,
      child: Text(text, style: style),
    );
  }
}
