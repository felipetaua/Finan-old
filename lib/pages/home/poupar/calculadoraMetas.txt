import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoalCalculatorScreen extends StatefulWidget {
  const GoalCalculatorScreen({super.key});

  @override
  State<GoalCalculatorScreen> createState() => _GoalCalculatorScreenState();
}

class _GoalCalculatorScreenState extends State<GoalCalculatorScreen> {
  enum CalculationMode { time, monthlyAmount }

  CalculationMode _mode = CalculationMode.time;

  // Controladores para os campos de texto
  final _goalAmountController = TextEditingController();
  final _monthlyAmountController = TextEditingController();
  final _timeController = TextEditingController();

  // Variável para armazenar o resultado
  String _result = '';

  void _calculate() {
    // Limpa o resultado anterior
    setState(() {
      _result = '';
    });

    final double? goalAmount = double.tryParse(_goalAmountController.text.replaceAll(',', '.'));

    if (goalAmount == null || goalAmount <= 0) {
      _showError('Por favor, insira um valor de meta válido.');
      return;
    }

    if (_mode == CalculationMode.time) {
      final double? monthlyAmount = double.tryParse(_monthlyAmountController.text.replaceAll(',', '.'));
      if (monthlyAmount == null || monthlyAmount <= 0) {
        _showError('Por favor, insira quanto você pode guardar por mês.');
        return;
      }
      // Fórmula: Tempo = Valor Total / Valor por Mês
      final double totalMonths = goalAmount / monthlyAmount;
      final int years = totalMonths ~/ 12;
      final int months = (totalMonths % 12).ceil();

      setState(() {
        String timeString = '';
        if (years > 0) {
          timeString += '$years ${years > 1 ? "anos" : "ano"}';
        }
        if (months > 0) {
          if (timeString.isNotEmpty) timeString += ' e ';
          timeString += '$months ${months > 1 ? "meses" : "mês"}';
        }
        _result = 'Tempo estimado: $timeString';
      });
    } else {
      final int? timeInMonths = int.tryParse(_timeController.text);
      if (timeInMonths == null || timeInMonths <= 0) {
        _showError('Por favor, insira o prazo em meses.');
        return;
      }
      // Fórmula: Valor por Mês = Valor Total / Tempo em Meses
      final double amountPerMonth = goalAmount / timeInMonths;
      final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
      
      setState(() {
        _result = 'Você precisa guardar: ${formatter.format(amountPerMonth)} por mês.';
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  void dispose() {
    _goalAmountController.dispose();
    _monthlyAmountController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Metas  Simples 🎯'),
        backgroundColor: Colors.deepPurple.shade50,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Seletor de modo de cálculo
                  SegmentedButton<CalculationMode>(
                    segments: const <ButtonSegment<CalculationMode>>[
                      ButtonSegment<CalculationMode>(
                        value: CalculationMode.time,
                        label: Text('Calcular Tempo'),
                        icon: Icon(Icons.access_time),
                      ),
                      ButtonSegment<CalculationMode>(
                        value: CalculationMode.monthlyAmount,
                        label: Text('Calcular Valor Mensal'),
                        icon: Icon(Icons.attach_money),
                      ),
                    ],
                    selected: <CalculationMode>{_mode},
                    onSelectionChanged: (Set<CalculationMode> newSelection) {
                      setState(() {
                        final previousMode = _mode;
                        _mode = newSelection.first;
                        _result = ''; // Limpa o resultado ao trocar de modo
                        
                        if (previousMode == CalculationMode.time && _mode == CalculationMode.monthlyAmount) {
                          _monthlyAmountController.clear();
                        } else if (previousMode == CalculationMode.monthlyAmount && _mode == CalculationMode.time) {
                          _timeController.clear();
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 24.0),

                  // Campo: Valor Total da Meta
                  _buildTextField(
                    controller: _goalAmountController,
                    label: 'Qual o valor total da sua meta?',
                    icon: Icons.flag,
                  ),
                  const SizedBox(height: 16.0),

                  // Campos condicionais baseados no modo
                  if (_mode == CalculationMode.time)
                    _buildTextField(
                      controller: _monthlyAmountController,
                      label: 'Quanto pode guardar por mês?',
                      icon: Icons.savings,
                    )
                  else
                    _buildTextField(
                      controller: _timeController,
                      label: 'Em quantos meses quer atingir?',
                      icon: Icons.calendar_today,
                      isInteger: true,
                    ),
                  const SizedBox(height: 24.0),

                  // Botão de Calcular
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Calcular'),
                  ),
                  const SizedBox(height: 20.0),

                  // Exibição do Resultado
                  if (_result.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _result,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar campos de texto padronizados
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isInteger = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isInteger
          ? TextInputType.number // Teclado numérico simples para inteiros
          : const TextInputType.numberWithOptions(decimal: true), // Teclado com decimais
      inputFormatters: isInteger
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.,]?\d{0,2}'))],
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
      ),
    );
  }
}