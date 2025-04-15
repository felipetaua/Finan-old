import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PouparPage extends StatelessWidget {
  const PouparPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de busca
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Pesquise',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.filter_list),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Gráfico com Card
              const Text(
                'Frequência de Depósitos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 150,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 3),
                              FlSpot(1, 10),
                              FlSpot(2, 7),
                              FlSpot(3, 4),
                              FlSpot(4, 1),
                            ],
                            isCurved: true,
                            color: Colors.blueAccent,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withAlpha((0.2 * 255).toInt()),
                            ),
                          ),
                          LineChartBarData(
                            spots: const [
                              FlSpot(1, 2),
                              FlSpot(2, 1),
                              FlSpot(3, 6),
                              FlSpot(4, 3),
                            ],
                            isCurved: true,
                            color: Colors.green,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.green.withAlpha(
                                (0.2 * 255).toInt(),
                              ),
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(show: false),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Botão para adicionar reservas e objetivos
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Bordas arredondadas
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Crie sua caixinha de metas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Título reservas
              const Text(
                'Reservas e Objetivos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Lista de metas como cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: reservas.length,
                  itemBuilder: (context, index) {
                    final reserva = reservas[index];
                    return ReservaItem(
                      titulo: reserva['titulo'],
                      local: reserva['local'],
                      progresso: reserva['progresso'],
                      valorTotal:
                          (reserva['valorTotal'] as num)
                              .toDouble(), // Conversão segura
                      valorRestante:
                          (reserva['valorRestante'] as num)
                              .toDouble(), // Conversão segura
                      data: reserva['data'],
                      image: reserva['image'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dados das reservas
final List<Map<String, dynamic>> reservas = [
  {
    'titulo': 'Viagem',
    'local': 'Fortaleza',
    'progresso': 0.33,
    'valorTotal': 5000.0, // Certifique-se de que é um double
    'valorRestante': 3350.0,
    'data': '15/01/2026',
    'image': 'assets/viagem.png',
  },
  {
    'titulo': 'Casa própria',
    'local': 'Fortaleza',
    'progresso': 0.15,
    'valorTotal': 200000.0, // Certifique-se de que é um double
    'valorRestante': 170000.0,
    'data': '31/09/2028',
    'image': 'assets/casa.png',
  },
  {
    'titulo': 'Carro',
    'local': 'Fortaleza',
    'progresso': 0.80,
    'valorTotal': 20000.0, // Certifique-se de que é um double
    'valorRestante': 4000.0,
    'data': '20/08/2026',
    'image': 'assets/carro.png',
  },
];

class ReservaItem extends StatelessWidget {
  final String titulo;
  final String local;
  final double progresso; // Deve ser um valor entre 0.0 e 1.0
  final double valorTotal;
  final double valorRestante;
  final String data;
  final String image;

  const ReservaItem({
    super.key,
    required this.titulo,
    required this.local,
    required this.progresso,
    required this.valorTotal,
    required this.valorRestante,
    required this.data,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título e imagem
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(image), radius: 22),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(local, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const Spacer(),
                Text(data, style: const TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 8),

            // Barra de progresso
            LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth; // Largura disponível
                return Stack(
                  children: [
                    Container(
                      height: 10,
                      width: maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Container(
                      height: 10,
                      width:
                          maxWidth *
                          progresso.clamp(
                            0.0,
                            1.0,
                          ), // Garante que progresso esteja entre 0.0 e 1.0
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 6),

            // Informações de valores
            Text(
              'Faltam: R\$ ${valorRestante.toStringAsFixed(2)}', // Exibe com 2 casas decimais
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Meta: R\$ ${valorTotal.toStringAsFixed(2)}', // Exibe com 2 casas decimais
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 12),

            // Botão Adicionar Dinheiro
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Ação ao clicar no botão
                  // print('Adicionar dinheiro para $titulo');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Cor do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Bordas arredondadas
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Adicionar Dinheiro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
