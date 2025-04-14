import 'package:flutter/material.dart';

class PlanejamentoFinanceiro extends StatelessWidget {
  const PlanejamentoFinanceiro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planejamento Financeiro'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Organize suas finanças com dicas práticas voltadas para seu negócio ou sua família.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Card 1: Defina seus objetivos
          _buildFinanceCard(
            title: '1. Defina seus objetivos',
            description:
                'Tenha metas claras: economizar, investir, quitar dívidas ou expandir seu negócio.',
          ),

          // Card 2: Crie um orçamento realista
          _buildFinanceCard(
            title: '2. Crie um orçamento realista',
            description:
                'Anote tudo o que entra e sai. Separe gastos fixos, variáveis e possíveis investimentos.',
          ),

          // Card 3: Use planilhas ou aplicativos
          _buildFinanceCard(
            title: '3. Use planilhas ou aplicativos',
            description:
                'Ferramentas digitais ajudam a acompanhar melhor seu dinheiro e evitar esquecimentos.',
          ),

          // Card 4: Estabeleça uma reserva de emergência
          _buildFinanceCard(
            title: '4. Estabeleça uma reserva de emergência',
            description:
                'O ideal é guardar o equivalente a 3 a 6 meses de gastos fixos.',
          ),

          // Card 5: Dicas rápidas (accordion)
          ExpansionTile(
            title: const Text('5. Dicas rápidas'),
            children: const [
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Evite compras por impulso.'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Negocie dívidas e evite juros.'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Revise seu orçamento todo mês.'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Busque educação financeira.'),
              ),
            ],
          ),

          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Exemplo de navegação futura
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mais funcionalidades em breve!')),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Baixar planilha de planejamento'),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceCard({
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
