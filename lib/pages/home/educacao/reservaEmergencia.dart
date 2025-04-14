import 'package:flutter/material.dart';

class ReservaEmergencia extends StatelessWidget {
  const ReservaEmergencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva de Emergência'),
        backgroundColor: const Color(0xFFF33D3D),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroCard(),
          _buildSliderCard(
            context,
            title: 'O que é?',
            content:
                'A reserva de emergência é um valor guardado para cobrir gastos inesperados, como uma demissão ou um problema de saúde.',
          ),
          _buildExpansionTile(
            title: 'Quem precisa de uma?',
            content:
                '🟦 Todo mundo precisa! Ter essa reserva evita o uso de empréstimos caros em emergências.',
          ),
          _buildExpansionTile(
            title: 'Quanto guardar?',
            content:
                'Especialistas sugerem guardar entre 6 a 12 vezes seu gasto mensal. Quanto maior a instabilidade da sua renda, maior deve ser a reserva.',
          ),
          _buildSliderCard(
            context,
            title: 'Como montar?',
            content:
                '1. Organize seus gastos\n'
                '2. Estabeleça um valor mensal\n'
                '3. Automatize o processo\n'
                '4. Seja consistente até atingir a meta.\n',
          ),
          _buildExpansionTile(
            title: 'Onde investir?',
            content:
                '🟦 Invista em aplicações com liquidez diária e baixo risco, como Tesouro Selic, CDBs de grandes bancos e fundos DI com baixa taxa de administração.',
          ),
          _buildExpansionTile(
            title: 'Quando usar?',
            content:
                '🟦 Use somente em emergências reais, como desemprego ou despesas médicas. Se precisar usar, reponha o valor o quanto antes.',
          ),
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Comece com segurança',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'A reserva de emergência é o primeiro passo para uma vida financeira mais tranquila. Entenda tudo sobre como montar e investir com segurança.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderCard(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: Colors.lightBlue[50],
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(content),
        ),
      ),
    );
  }

  Widget _buildExpansionTile({required String title, required String content}) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(content),
        ),
      ],
    );
  }
}
