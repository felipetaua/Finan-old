import 'package:finan/pages/home/poupar/goal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // Importar para NumberFormat

class PouparPage extends StatefulWidget {
  const PouparPage({super.key});

  @override
  State<PouparPage> createState() => _PouparPageState();
}

class _PouparPageState extends State<PouparPage> {
  final List<GoalModel> _money = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController targetValueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  void _showCreateBoxModal() {
    nameController.clear();
    targetValueController.clear();
    descriptionController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Nova Caixinha',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nome do objetivo",
                    labelStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Icons.flag,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    labelStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: targetValueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MoneyInputFormatter(
                      thousandSeparator: ThousandSeparator.Period,
                      leadingSymbol: 'R\$',
                      useSymbolPadding: true,
                      mantissaLength: 2,
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: "Valor necessário",
                    labelStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.blueAccent,
                    ),
                    suffix: Text('reais'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final goal = GoalModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      description: descriptionController.text,
                      targetValue:
                          (double.tryParse(
                                targetValueController.text.replaceAll(
                                  RegExp(r'[^0-9]'),
                                  '',
                                ),
                              ) ??
                              0.0) /
                          100.0,
                      currentValue: 0,
                      createdAt: DateTime.now(),
                    );
                    setState(() {
                      _money.add(goal);
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Criar caixinha",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddMoneyDialog(GoalModel meta) {
    valueController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Adicionar Dinheiro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MoneyInputFormatter(
                      thousandSeparator: ThousandSeparator.Period,
                      leadingSymbol: 'R\$',
                      useSymbolPadding: true,
                      mantissaLength: 2,
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: "Valor",
                    labelStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(Icons.attach_money),
                    suffix: const Text('reais'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          String digitsOnly = valueController.text.replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );
                          double value =
                              (double.tryParse(digitsOnly) ?? 0.0) / 100.0;
                          setState(() {
                            meta.currentValue += value;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Adicionar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWithdrawMoneyDialog(GoalModel meta) {
    valueController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Retirar Dinheiro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MoneyInputFormatter(
                      thousandSeparator: ThousandSeparator.Period,
                      leadingSymbol: 'R\$',
                      useSymbolPadding: true,
                      mantissaLength: 2,
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: "Valor a retirar",
                    labelStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.redAccent, // Cor de foco para retirada
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          String digitsOnly = valueController.text.replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );
                          double valueToWithdraw =
                              (double.tryParse(digitsOnly) ?? 0.0) / 100.0;

                          if (valueToWithdraw <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Por favor, insira um valor válido para retirada.',
                                ),
                                backgroundColor: Colors.orangeAccent,
                              ),
                            );
                          } else if (valueToWithdraw > meta.currentValue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Você não pode retirar mais do que ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(meta.currentValue)}.',
                                ),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else {
                            setState(() {
                              meta.currentValue -= valueToWithdraw;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.redAccent, // Cor para retirada
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Retirar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ), // Ajustado o padding inferior
          child: SingleChildScrollView(
            // Adicionado SingleChildScrollView
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
                const Center(
                  child: Text(
                    'Frequência de Depósitos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xFF1b1d2e),
                  elevation: 6,
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Ultimas semanas - 2025',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
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
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.withOpacity(0.2),
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
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.green.withOpacity(0.2),
                                  ),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      const days = [
                                        'Seg',
                                        'Ter',
                                        'Qua',
                                        'Qui',
                                        'Sex',
                                      ];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          days[value.toInt() % days.length],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 2,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white60,
                                        ),
                                      );
                                    },
                                    reservedSize: 28,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                horizontalInterval: 2,
                                verticalInterval: 1,
                                getDrawingHorizontalLine:
                                    (value) => FlLine(
                                      color: Colors.grey.withOpacity(0.1),
                                      strokeWidth: 1,
                                    ),
                                getDrawingVerticalLine:
                                    (value) => FlLine(
                                      color: Colors.grey.withOpacity(0.1),
                                      strokeWidth: 1,
                                    ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              lineTouchData: LineTouchData(
                                handleBuiltInTouches: true,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipRoundedRadius: 12,
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  showOnTopOfTheChartBoxArea: true,
                                  tooltipPadding: const EdgeInsets.all(8),
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((spot) {
                                      return LineTooltipItem(
                                        "R\$ ${spot.y.toStringAsFixed(2)}",
                                        const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              minY: 0,
                              maxY: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Botão para adicionar reservas e objetivos
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showCreateBoxModal();
                    },
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
                const SizedBox(height: 5),

                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Adicionado physics
                  padding: const EdgeInsets.only(
                    bottom: 60,
                  ), // Padding inferior para o último item
                  itemCount: _money.length,
                  itemBuilder: (context, index) {
                    final meta = _money[index];
                    final progresso = (meta.currentValue / meta.targetValue)
                        .clamp(0.0, 1.0);
                    final double restante =
                        meta.targetValue > meta.currentValue
                            ? meta.targetValue - meta.currentValue
                            : 0.0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Ícone ou imagem à esquerda
                          Container(
                            width: 80,
                            height: 100,
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.savings,
                              color: Colors.blueAccent,
                              size: 36,
                            ),
                          ),

                          // Informações da meta
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 12,
                                top: 12,
                                bottom: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Título e botão de adicionar
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          meta.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.blueAccent,
                                        ),
                                        onSelected: (value) {
                                          if (value == 'add') {
                                            _showAddMoneyDialog(meta);
                                          } else if (value == 'withdraw') {
                                            _showWithdrawMoneyDialog(meta);
                                          }
                                        },
                                        itemBuilder:
                                            (
                                              BuildContext context,
                                            ) => <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                value: 'add',
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.add_circle_outline,
                                                  ),
                                                  title: Text(
                                                    'Adicionar valor',
                                                  ),
                                                ),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'withdraw',
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                  ),
                                                  title: Text(
                                                    'Retirar valor',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                      ),
                                    ],
                                  ),

                                  if (meta.description.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        meta.description,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),

                                  Text(
                                    'Guardado: ${currencyFormatter.format(meta.currentValue)}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'Meta: ${currencyFormatter.format(meta.targetValue)}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  if (meta.targetValue > 0)
                                    Text(
                                      'Falta: ${currencyFormatter.format(restante)}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color:
                                            restante > 0
                                                ? Colors.blueAccent
                                                : Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                  const SizedBox(height: 18),

                                  // Barra de progresso
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      value: progresso,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        progresso >= 1.0
                                            ? Colors.green
                                            : Colors.blueAccent,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 28),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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
                  // Ação ao clicar no botão()
                  // _showAddMoneyDialog();
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
