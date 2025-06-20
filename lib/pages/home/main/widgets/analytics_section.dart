// lib/widgets/analytics_section.dart

import 'package:flutter/material.dart';

class AnalyticsSection extends StatelessWidget {
  const AnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _CategoryAnalyticsItem(
              label: 'Bank',
              icon: Icons.account_balance_rounded,
              color: Color(0xFF6366F1), // Roxo
            ),
            _CategoryAnalyticsItem(
              label: 'E-commerce',
              icon: Icons.shopping_bag_rounded,
              color: Color(0xFFF59E0B), // Laranja
            ),
            _CategoryAnalyticsItem(
              label: 'Food',
              icon: Icons.fastfood_rounded,
              color: Color(0xFF10B981), // Verde
            ),
          ],
        )
      ],
    );
  }
}

// Widget interno para cada item da seção de Análise
class _CategoryAnalyticsItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryAnalyticsItem({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: Center(
            child: Icon(icon, color: color, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }
}