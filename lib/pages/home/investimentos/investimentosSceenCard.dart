import 'package:finan/pages/home/investimentos/showWallet.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvestimentosScreenCard extends StatelessWidget {
  const InvestimentosScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF368DF7),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.wallet),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowWalletPage()),
                  );
                }, // Abrir a página de seleção de avatar
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              PortfolioCard(
                title: "Seus Ativos",
                value: "\$115,087.80",
                percentage: "+12.8%",
                amountChange: "\$58,105",
                isPositive: true,
                lineColor: Colors.green,
              ),
              SizedBox(height: 20),
              PortfolioCard(
                title: "Sua Carteira de Ativos",
                value: "\$385,115.02",
                percentage: "-12.8%",
                amountChange: "\$58,105",
                isPositive: false,
                lineColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final String amountChange;
  final bool isPositive;
  final Color lineColor;

  const PortfolioCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.amountChange,
    required this.isPositive,
    this.lineColor = Colors.blue, // Valor padrão para evitar null
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/avatar.png'), // avatar fixo
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.notifications_none),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.remove_red_eye_outlined, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 18,
              ),
              Text(
                "$percentage ($amountChange) o todo tempo",
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(Icons.settings, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [lineColor, lineColor.withOpacity(0.5)],
                    ),
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          lineColor.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    spots: const [
                      FlSpot(0, 1),
                      FlSpot(1, 1.2),
                      FlSpot(2, 0.9),
                      FlSpot(3, 1.5),
                      FlSpot(4, 1.3),
                      FlSpot(5, 1.4),
                      FlSpot(6, 1.7),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              TimeFilter(text: "1m"),
              TimeFilter(text: "3m"),
              TimeFilter(text: "6m"),
              TimeFilter(text: "1A"),
              TimeFilter(text: "Tudo", selected: true),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeFilter extends StatelessWidget {
  final String text;
  final bool selected;

  const TimeFilter({super.key, required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
