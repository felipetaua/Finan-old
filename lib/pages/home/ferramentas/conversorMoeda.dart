import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ConversorMoedasApp extends StatelessWidget {
  // ignore: use_super_parameters
  const ConversorMoedasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const ConversorMoedasPage(),
    );
  }
}

class ConversorMoedasPage extends StatefulWidget {
  // ignore: use_super_parameters
  const ConversorMoedasPage({Key? key}) : super(key: key);

  @override
  State<ConversorMoedasPage> createState() => _ConversorMoedasPageState();
}

class _ConversorMoedasPageState extends State<ConversorMoedasPage> {
  final TextEditingController _valorController = TextEditingController();
  String _moedaOrigem = 'USD';
  String _moedaDestino = 'BRL';
  String _resultado = '';
  Map<String, dynamic> _taxas = {};

  final List<String> _moedas = ['USD', 'BRL', 'EUR', 'GBP', 'JPY'];

  @override
  void initState() {
    super.initState();
    _carregarTaxas();
  }

  Future<void> _carregarTaxas() async {
    final pares = _moedas
        .expand(
          (moeda1) => _moedas
              .where((moeda2) => moeda1 != moeda2)
              .map((moeda2) => '$moeda1-$moeda2'),
        )
        .join(',');

    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/$pares',
    );

    try {
      final resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        final dados = json.decode(resposta.body);
        setState(() {
          _taxas = dados;
        });
      } else {
        _mostrarErro('Erro ao carregar taxas de câmbio.');
      }
    } catch (e) {
      _mostrarErro('Erro de conexão: $e');
      debugPrint('Erro: $e'); // Adicione isso para depuração
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _converter() {
    final entrada = _valorController.text.replaceAll(',', '.').trim();
    final valor = double.tryParse(entrada);
    if (valor == null) {
      _mostrarErro('Valor inválido.');
      return;
    }

    final chave = '$_moedaOrigem-$_moedaDestino';
    final taxa = _taxas[chave]?['bid'];
    if (taxa == null) {
      _mostrarErro('Taxa de câmbio não disponível.');
      return;
    }

    final valorConvertido = valor * double.parse(taxa);
    final formato = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      name: _moedaDestino,
    );
    setState(() {
      _resultado = formato.format(valorConvertido);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Moedas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _valorController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _moedaOrigem,
                    items:
                        _moedas
                            .map(
                              (moeda) => DropdownMenuItem(
                                value: moeda,
                                child: Text(moeda),
                              ),
                            )
                            .toList(),
                    onChanged: (valor) {
                      setState(() {
                        _moedaOrigem = valor!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'De',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _moedaDestino,
                    items:
                        _moedas
                            .map(
                              (moeda) => DropdownMenuItem(
                                value: moeda,
                                child: Text(moeda),
                              ),
                            )
                            .toList(),
                    onChanged: (valor) {
                      setState(() {
                        _moedaDestino = valor!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Para',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _converter,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
