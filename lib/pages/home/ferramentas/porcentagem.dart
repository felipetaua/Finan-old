import 'package:flutter/material.dart';

class PorcentagemCalculadoraPage extends StatefulWidget {
  const PorcentagemCalculadoraPage({super.key});

  @override
  State<PorcentagemCalculadoraPage> createState() =>
      _PorcentagemCalculadoraPageState();
}

class _PorcentagemCalculadoraPageState
    extends State<PorcentagemCalculadoraPage> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _porcentagemController = TextEditingController();

  String _resultado = '';
  // ignore: prefer_final_fields
  List<String> _historico = [];

  void _calcularPorcentagem() {
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.'));
    final porcentagem = double.tryParse(
      _porcentagemController.text.replaceAll(',', '.'),
    );

    if (valor == null || porcentagem == null) {
      setState(() => _resultado = 'Entrada inválida');
      return;
    }

    final resultado = (valor * porcentagem) / 100;
    final textoResultado = '$porcentagem% de $valor = $resultado';

    setState(() {
      _resultado = resultado.toStringAsFixed(2).replaceAll('.', ',');
      _historico.insert(0, textoResultado);
    });
  }

  void _limparCampos() {
    _valorController.clear();
    _porcentagemController.clear();
    setState(() => _resultado = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Porcentagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor base (ex: 150)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _porcentagemController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Porcentagem (ex: 20)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _calcularPorcentagem,
              icon: const Icon(Icons.percent),
              label: const Text('Calcular'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _limparCampos,
              // ignore: sort_child_properties_last
              child: const Text('Limpar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _resultado.isNotEmpty ? 'Resultado: $_resultado' : '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            const Text(
              'Histórico',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _historico.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_historico[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
