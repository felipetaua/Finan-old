import 'package:finan/feedback/sucessPage.dart';
import 'package:finan/pages/home/poupar/goal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  // Lista de ícones e cores para seleção
  final List<IconData> _availableIcons = [
    Icons.savings,
    Icons.account_balance_wallet,
    Icons.credit_card,
    Icons.home,
    Icons.directions_car,
    Icons.flight,
    Icons.school,
    Icons.lightbulb,
    Icons.shopping_cart,
    Icons.phone_iphone,
    Icons.computer,
    Icons.build,
    Icons.favorite,
    Icons.card_giftcard,
    Icons.pets,
  ];

  final List<Color> _availableColors = [
    Colors.blueAccent,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.cyan,
    Colors.indigo,
    Colors.brown,
    Colors.grey[700]!,
  ];

  // Variáveis para armazenar a seleção atual no modal
  IconData _selectedIconForNewGoal = Icons.savings;
  Color _selectedColorForNewGoal = Colors.blueAccent;

  void _showCreateBoxModal() {
    nameController.clear();
    targetValueController.clear();
    descriptionController.clear();

    // Reseta para os padrões ao abrir o modal
    // Garante que _selectedIconForNewGoal e _selectedColorForNewGoal
    // sejam os primeiros da lista ou os padrões desejados.
    _selectedIconForNewGoal = _availableIcons.first;
    _selectedColorForNewGoal = _availableColors.first;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // Alterado para receber BuildContext
        return StatefulBuilder(
          // Adicionado StatefulBuilder
          builder: (BuildContext context, StateSetter modalSetState) {
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
                child: SingleChildScrollView(
                  // Adicionado para evitar overflow com seletores
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Nova Caixinha',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: nameController,
                        cursorColor: Colors.blueAccent,
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
                        cursorColor: Colors.blueAccent,
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
                        cursorColor: Colors.blueAccent,
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
                          suffix: Text(
                            'reais',
                            style: TextStyle(color: Colors.blueAccent),
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
                      const SizedBox(height: 16),
                      const Text(
                        "Escolha um ícone:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height:
                            60, // Altura definida para o carrossel de ícones
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _availableIcons.length,
                          itemBuilder: (context, index) {
                            final icon = _availableIcons[index];
                            bool isSelected = _selectedIconForNewGoal == icon;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ), // Espaçamento entre ícones
                              child: GestureDetector(
                                onTap: () {
                                  modalSetState(() {
                                    _selectedIconForNewGoal = icon;
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? _selectedColorForNewGoal
                                                .withOpacity(0.2)
                                            : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        isSelected
                                            ? Border.all(
                                              color: _selectedColorForNewGoal,
                                              width: 2,
                                            )
                                            : Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1,
                                            ),
                                    boxShadow:
                                        isSelected
                                            ? [
                                              BoxShadow(
                                                color: _selectedColorForNewGoal
                                                    .withOpacity(0.3),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                              ),
                                            ]
                                            : [],
                                  ),
                                  child: Icon(
                                    icon,
                                    color:
                                        isSelected
                                            ? _selectedColorForNewGoal
                                            : Colors.grey[700],
                                    size: 28,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Escolha uma cor:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 50, // Altura definida para o carrossel de cores
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _availableColors.length,
                          itemBuilder: (context, index) {
                            final color = _availableColors[index];
                            bool isSelected = _selectedColorForNewGoal == color;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ), // Espaçamento entre cores
                              child: GestureDetector(
                                onTap: () {
                                  modalSetState(() {
                                    _selectedColorForNewGoal = color;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ), // Círculo
                                    border:
                                        isSelected
                                            ? Border.all(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              width: 3,
                                            )
                                            : Border.all(
                                              color: Colors.grey.shade400
                                                  .withOpacity(0.6),
                                              width: 1,
                                            ),
                                    boxShadow:
                                        isSelected
                                            ? [
                                              BoxShadow(
                                                color: color.withOpacity(0.6),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              ),
                                            ]
                                            : [],
                                  ),
                                  child:
                                      isSelected
                                          ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 24,
                                          )
                                          : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          final goal = GoalModel(
                            id:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
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
                            iconData:
                                _selectedIconForNewGoal, // Usa o ícone selecionado
                            color:
                                _selectedColorForNewGoal, // Usa a cor selecionada
                          );
                          setState(() {
                            // setState da _PouparPageState
                            _money.add(goal);
                          });
                          Navigator.pop(context); // Fecha o modal
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const SuccessPage(
                                    message: 'Caixinha criada com sucesso!',
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _selectedColorForNewGoal, // Cor do botão usa a cor selecionada
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
              ),
            );
          },
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
                  cursorColor: Colors.blueAccent,
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
                  cursorColor: Colors.blueAccent,
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
                        color: Colors.blueAccent, // Alterado para azul
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
                    cursorColor: Colors.blueAccent,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Pesquise suas metas',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.filter_list),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Favoritos e Ações
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: // Dentro do Row dos cards
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _sujestoesBox(
                        label: 'Populares',
                        icon: const FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.white,
                        ),

                        // image: 'assets/images/card-invest-favoritos.png', // Removido
                        onTap: () => Navigator.push,
                      ),
                      _sujestoesBox(
                        label: 'Progresso',
                        icon: const FaIcon(
                          FontAwesomeIcons.trophy,
                          color: Colors.white,
                        ),

                        // image: 'assets/images/card-invest-favoritos.png', // Removido
                        onTap: () => Navigator.push,
                      ),
                      _sujestoesBox(
                        label: 'Dicas',
                        icon: const FaIcon(
                          FontAwesomeIcons.book,
                          color: Colors.white,
                        ),

                        // image: 'assets/images/card-invest-favoritos.png', // Removido
                        onTap: () => Navigator.push,
                      ),
                      _sujestoesBox(
                        label: 'Metas',
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowTrendUp,
                          color: Colors.white,
                        ),

                        // image: 'assets/images/card-invest-favoritos.png', // Removido
                        onTap: () => Navigator.push,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
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
                  color: const Color(0xFF242530),
                  elevation: 6,
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
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
                      // _selectedIconForNewGoal = _availableIcons.first; // Já é feito no início de _showCreateBoxModal
                      // _selectedColorForNewGoal = _availableColors.first; // Já é feito no início de _showCreateBoxModal
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
                              color: meta.color.withOpacity(
                                0.1,
                              ), // Usa a cor da meta
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              meta.iconData, // Usa o ícone da meta
                              color: meta.color, // Usa a cor da meta
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
                                        icon: Icon(
                                          Icons.more_vert,
                                          color:
                                              meta.color, // Usa a cor da meta
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
                                                ? meta.color
                                                : Colors
                                                    .green, // Usa a cor da meta
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
                                            : meta.color, // Usa a cor da meta
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

                const Text("asasds"),
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
                final maxWidth = constraints.maxWidth;
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
                      width: maxWidth * progresso.clamp(0.0, 1.0),
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
              'Faltam: R\$ ${valorRestante.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Meta: R\$ ${valorTotal.toStringAsFixed(2)}',
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

class _sujestoesBox extends StatelessWidget {
  final String label;
  final Widget icon;
  // final String image; // Removido
  final VoidCallback onTap;

  const _sujestoesBox({
    required this.label,
    // required this.image, // Removido
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          gradient: LinearGradient(
            // Adicionado gradiente
            colors: [
              Color(0xFF368DF7), // Azul principal do app
              Color(0xFF2A79D7), // Um tom um pouco mais escuro de azul
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            // Adicionada uma sombra sutil para destaque
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),

        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 3, color: Colors.black)],
              ),
            ),
            const SizedBox(width: 20),
            icon, // Exibe o ícone
          ],
        ),
      ),
    );
  }
}
