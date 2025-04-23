import 'package:finan/pages/home/ferramentas/ferramentasScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => CalculadoraState();
}

class CalculadoraState extends State<CalculadoraPage> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Pro',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: CalculatorPage(onToggleTheme: toggleTheme),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const CalculatorPage({super.key, required this.onToggleTheme});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';
  // ignore: prefer_final_fields
  List<String> _history = [];

  final formatter = NumberFormat.decimalPattern();

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == '=') {
        try {
          final result = _evaluateExpression(_expression);
          if (result != null) {
            _result = formatter.format(result);
            _history.insert(0, '$_expression = $_result');
            _expression = result.toString();
          }
        } catch (e) {
          _result = 'Erro';
        }
      } else {
        // Evitar múltiplos operadores seguidos
        if (_isOperator(value)) {
          if (_expression.isEmpty ||
              _isOperator(_expression[_expression.length - 1])) {
            return;
          }
        }

        // Evita ponto duplicado
        if (value == '.') {
          final parts = _expression.split(RegExp(r'[+\-*/]'));
          if (parts.isNotEmpty && parts.last.contains('.')) return;
        }

        // Evita zeros desnecessários
        if (value == '0') {
          if (_expression.endsWith('00')) return;
        }

        _expression += value;
      }
    });
  }

  double? _evaluateExpression(String expr) {
    try {
      String finalExpr = expr.replaceAll('×', '*').replaceAll('÷', '/');

      // Evita divisão por zero
      if (finalExpr.contains(RegExp(r'/0(?!\d)'))) {
        _result = 'Erro: Divisão por zero';
        return null;
      }

      final parsed = _parseAndCalculate(finalExpr);
      return parsed;
    } catch (_) {
      return null;
    }
  }

  double _parseAndCalculate(String expr) {
    final exp = expr.replaceAll('--', '+');
    final rpn = _toRPN(exp);
    return _evaluateRPN(rpn);
  }

  List<String> _toRPN(String expr) {
    final output = <String>[];
    final stack = <String>[];
    final tokens =
        RegExp(
          r'\d+\.\d+|\d+|[+\-*/()]',
        ).allMatches(expr).map((m) => m.group(0)!).toList();

    final precedence = {'+': 1, '-': 1, '*': 2, '/': 2};

    for (var token in tokens) {
      if (double.tryParse(token) != null) {
        output.add(token);
      } else if ('+-*/'.contains(token)) {
        while (stack.isNotEmpty &&
            precedence[stack.last] != null &&
            precedence[stack.last]! >= precedence[token]!) {
          output.add(stack.removeLast());
        }
        stack.add(token);
      } else if (token == '(') {
        stack.add(token);
      } else if (token == ')') {
        while (stack.isNotEmpty && stack.last != '(') {
          output.add(stack.removeLast());
        }
        stack.removeLast();
      }
    }

    while (stack.isNotEmpty) {
      output.add(stack.removeLast());
    }

    return output;
  }

  double _evaluateRPN(List<String> rpn) {
    final stack = <double>[];

    for (var token in rpn) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else {
        final b = stack.removeLast();
        final a = stack.removeLast();
        switch (token) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            stack.add(a * b);
            break;
          case '/':
            stack.add(a / b);
            break;
        }
      }
    }

    return stack.single;
  }

  bool _isOperator(String value) {
    return ['+', '-', '*', '/', '×', '÷'].contains(value);
  }

  final List<String> _buttons = [
    'C',
    '⌫',
    '(',
    ')',
    '7',
    '8',
    '9',
    '÷',
    '4',
    '5',
    '6',
    '×',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => FavoritesPage()),
              ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression, style: const TextStyle(fontSize: 28)),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 4,
              childAspectRatio: 1.2,
              children:
                  _buttons.map((btn) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _onKeyTap(btn),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            btn,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  _isOperator(btn)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const Divider(),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children:
                  _history
                      .take(5)
                      .map(
                        (item) =>
                            Text(item, style: const TextStyle(fontSize: 16)),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
