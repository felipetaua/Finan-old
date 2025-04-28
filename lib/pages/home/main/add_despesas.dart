import 'package:finan/feedback/congratulationsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave; // Função para salvar a transação

  const AddTransactionPage({super.key, required this.onSave});

  @override
  AddTransactionPageState createState() => AddTransactionPageState();
}

class AddTransactionPageState extends State<AddTransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _inputValue = '0';
  String _nome = '';
  String _frequencia = '';
  String _observacao = '';
  IconData? _categoriaSelecionada;
  Color _categoriaCor = Colors.grey;
  final List<Map<String, dynamic>> _transacoes = [];
  bool _mostrarTodasCategorias = false;

  final Map<IconData, Color> _categorias = {
    Icons.article: Colors.grey,
    Icons.map: Colors.purple,
    Icons.favorite: Colors.green,
    Icons.credit_card: Colors.purpleAccent,
    Icons.sports_basketball: Colors.orange,
    Icons.percent: Colors.red,
    Icons.shopping_cart: Colors.blue,
    Icons.home: Colors.brown,
    Icons.school: Colors.indigo,
    Icons.work: Colors.teal,
    Icons.car_rental: Colors.cyan,
    Icons.fastfood: Colors.amber,
    Icons.local_hospital: Colors.pink,
    Icons.flight: Colors.deepPurple,
    Icons.movie: Colors.lime,
    Icons.music_note: Colors.deepOrange,
    Icons.pets: Colors.lightGreen,
    Icons.phone: Colors.lightBlue,
    Icons.computer: Colors.yellow,
    Icons.book: Colors.blueGrey,
    Icons.beach_access: Colors.tealAccent,
    Icons.cake: Colors.pinkAccent,
    Icons.camera: Colors.orangeAccent,
    Icons.directions_bike: Colors.greenAccent,
    Icons.directions_boat: Colors.cyanAccent,
    Icons.directions_bus: Colors.redAccent,
    Icons.directions_car: Colors.purpleAccent,
    Icons.directions_railway: Colors.indigoAccent,
    Icons.directions_walk: Colors.amberAccent,
    Icons.eco: Colors.lightGreenAccent,
    Icons.electric_bike: Colors.blueAccent,
    Icons.electric_car: Colors.deepPurpleAccent,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {}); // Atualiza a cor quando desliza entre as abas
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatCurrency(String value) {
    final number =
        double.tryParse(value.replaceAll(',', '').replaceAll('.', '')) ?? 0.0;
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(number / 100);
  }

  void _salvarTransacao() {
    if (_categoriaSelecionada == null ||
        _nome.isEmpty ||
        _frequencia.isEmpty ||
        _inputValue == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios.')),
      );
      return;
    }

    final novaTransacao = {
      'categoria': _categoriaSelecionada,
      'cor': _categoriaCor,
      'descricao': _nome,
      'valor':
          (_tabController.index == 0 ? '-' : '+') +
          _formatCurrency(_inputValue),
      'data': DateFormat('dd/MM/yyyy').format(DateTime.now()),
    };

    _adicionarTransacao(novaTransacao);
    widget.onSave(novaTransacao);

    // Navega para a tela de carregamento
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterExpensePage()),
    ).then((_) {
      // Retorna para a tela anterior após o carregamento
      Navigator.pop(context);
    });
  }

  void _adicionarTransacao(Map<String, dynamic> novaTransacao) {
    setState(() {
      _transacoes.add(novaTransacao); // Adiciona a nova transação à lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Controle de Gastos',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Despesas'),
            Tab(text: 'Receitas'),
            Tab(text: 'Transferências'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionForm('despesa'),
          _buildTransactionForm('receita'),
          _buildTransactionForm('transferência'),
        ],
      ),
    );
  }

  Widget _buildTransactionForm(String tipo) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    String tempValue = _inputValue;
                    return AlertDialog(
                      title: const Text('Digite o valor'),
                      content: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Ex: 1050'),
                        onChanged: (value) => tempValue = value,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, tempValue),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
                if (result != null && result.isNotEmpty) {
                  setState(() {
                    _inputValue = result;
                  });
                }
              },
              child: Text(
                _formatCurrency(_inputValue),
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Saldo disponível',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categorias',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _mostrarTodasCategorias = !_mostrarTodasCategorias;
                      });
                    },
                    child: Text(
                      _mostrarTodasCategorias ? 'Ver menos' : 'Ver mais',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _mostrarTodasCategorias
                  ? Wrap(
                    spacing: 12,
                    children:
                        _categorias.entries.map((entry) {
                          final isSelected = _categoriaSelecionada == entry.key;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _categoriaSelecionada = entry.key;
                                _categoriaCor = entry.value;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? entry.value.withOpacity(0.2)
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: entry.value),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(entry.key, color: entry.value),
                            ),
                          );
                        }).toList(),
                  )
                  : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          _categorias.entries.take(6).map((entry) {
                            final isSelected =
                                _categoriaSelecionada == entry.key;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _categoriaSelecionada = entry.key;
                                  _categoriaCor = entry.value;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? entry.value.withOpacity(0.2)
                                          : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: entry.value),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Icon(entry.key, color: entry.value),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Nome da transação',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            onChanged: (value) => _nome = value,
            decoration: const InputDecoration(hintText: 'Digite o nome...'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Frequência',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            onChanged: (value) => _frequencia = value ?? '',
            items: const [
              DropdownMenuItem(
                value: 'Diariamente',
                child: Text('Diariamente'),
              ),
              DropdownMenuItem(
                value: 'Semanalmente',
                child: Text('Semanalmente'),
              ),
              DropdownMenuItem(
                value: 'Mensalmente',
                child: Text('Mensalmente'),
              ),
              DropdownMenuItem(value: 'Anualmente', child: Text('Anualmente')),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Observação',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) => _observacao = value,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Digite uma observação...',
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: _salvarTransacao,
              icon: const Icon(Icons.check),
              label: const Text('Salvar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_observacao', _observacao));
  }
}
