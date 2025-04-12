import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RendaScreen extends StatefulWidget {
  final String categoria;
  final VoidCallback onSalarioAtualizado; // Função de callback

  const RendaScreen({
    super.key,
    required this.categoria,
    required this.onSalarioAtualizado,
  });

  @override
  State<RendaScreen> createState() => _RendaScreenState();
}

class _RendaScreenState extends State<RendaScreen> {
  final TextEditingController _salarioController = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    _recuperarUserId();
  }

  Future<void> _recuperarUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  void _enviarSalario() async {
    final salarioTexto = _salarioController.text;

    if (salarioTexto.isEmpty) {
      _mostrarSnackBar('Por favor, preencha o salário.', Colors.redAccent);
      return;
    }

    final salarioLimpo =
        salarioTexto
            .replaceAll("R\$", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")
            .trim();

    final double? salario = double.tryParse(salarioLimpo);

    if (salario == null) {
      _mostrarSnackBar(
        'Salário inválido. Digite um valor válido.',
        Colors.redAccent,
      );
      return;
    }

    if (userId == null) {
      _mostrarSnackBar('Erro: usuário não identificado.', Colors.redAccent);
      return;
    }

    final url = Uri.parse(
      'https://finan-4854e-default-rtdb.firebaseio.com/usuario/$userId.json',
    );

    try {
      final resposta = await http.patch(
        url,
        body: jsonEncode({'salario': salario}),
        headers: {'Content-Type': 'application/json'},
      );

      if (resposta.statusCode == 200) {
        _mostrarSnackBar('Salário enviado com sucesso!', Colors.green);

        // Chama a função de callback para notificar a atualização do salário
        widget.onSalarioAtualizado();

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        _mostrarSnackBar('Erro ao salvar o salário.', Colors.redAccent);
      }
    } catch (e) {
      _mostrarSnackBar('Erro: $e', Colors.redAccent);
    }
  }

  void _mostrarSnackBar(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.categoria),
        backgroundColor: const Color(0xFF368DF7),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                "Informe seu salário mensal",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF368DF7),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Precisamos saber quanto você ganha para te ajudar com seus gastos.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              const Text(
                "Salário:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _salarioController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // ignore: deprecated_member_use
                  MoneyInputFormatter(
                    leadingSymbol: 'R\$',
                    thousandSeparator: ThousandSeparator.Period,
                    useSymbolPadding: true,
                    mantissaLength: 2,
                  ),
                ],
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.bag_badge_plus,
                    color: Colors.blue,
                  ),
                  suffix: const Text("Reais"),
                  hintText: "Digite seu salário",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xFF368DF7),
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "🔒 Essa informação é confidencial e não será compartilhada.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _enviarSalario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF368DF7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Enviar", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
