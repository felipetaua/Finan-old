import 'package:finan/feedback/congratulationsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddTransactionPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

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
    Icons.fastfood: Colors.amber,
    Icons.shopping_cart: Colors.blue,
    Icons.home: Colors.brown,
    Icons.lightbulb: Colors.amber,
    Icons.water_drop: Colors.lightBlueAccent,
    Icons.gas_meter: Colors.deepOrangeAccent,
    Icons.phone: Colors.lightBlue,
    Icons.local_gas_station: Colors.orange,
    Icons.cleaning_services: Colors.teal,
    Icons.lock: Colors.grey,
    Icons.build: Colors.blueGrey,

    Icons.directions_car: Colors.purpleAccent,
    Icons.directions_bus: Colors.redAccent,
    Icons.directions_railway: Colors.indigoAccent,
    Icons.directions_bike: Colors.greenAccent,
    Icons.electric_bike: Colors.blueAccent,
    Icons.electric_car: Colors.deepPurpleAccent,
    Icons.car_rental: Colors.cyan,
    Icons.flight: Colors.deepPurple,
    Icons.map: Colors.purple,
    Icons.directions_boat: Colors.cyanAccent,

    Icons.local_hospital: Colors.pink,
    Icons.health_and_safety: Colors.red,
    Icons.work: Colors.teal,
    Icons.attach_money: Colors.green,
    Icons.paid: Colors.green,
    Icons.percent: Colors.red,
    Icons.money_off: Colors.redAccent,
    Icons.credit_card: Colors.purpleAccent,
    Icons.account_balance: Colors.indigo,
    Icons.savings: Colors.greenAccent,
    Icons.receipt: Colors.deepOrange,
    Icons.redeem: Colors.cyan,
    Icons.favorite: Colors.green,
    Icons.handshake: Colors.deepPurple,

    Icons.school: Colors.indigo,
    Icons.book: Colors.blueGrey,
    Icons.baby_changing_station: Colors.pink,
    Icons.pets: Colors.deepOrange,

    Icons.movie: Colors.lime,
    Icons.music_note: Colors.lightGreen,
    Icons.beach_access: Colors.tealAccent,
    Icons.cake: Colors.pinkAccent,
    Icons.camera: Colors.orangeAccent,
    Icons.computer: Colors.yellow,
    Icons.emoji_events: Colors.yellowAccent,
    Icons.store: Colors.brown,
    Icons.eco: Colors.lightGreenAccent,
    Icons.article: Colors.grey,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
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

  String _getTextoValor() {
    switch (_tabController.index) {
      case 0:
        return 'Valor de Despesas';
      case 1:
        return 'Valor de Receitas';
      case 2:
        return 'Valor de Transferências';
      default:
        return 'Valor';
    }
  }

  Color _getBackgroundColor() {
    switch (_tabController.index) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.green;
      case 2:
        return Colors.grey;
      default:
        return Colors.white;
    }
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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterExpensePage()),
    ).then((_) {
      Navigator.pop(context);
    });
  }

  void _adicionarTransacao(Map<String, dynamic> novaTransacao) {
    setState(() {
      _transacoes.add(novaTransacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _getBackgroundColor(),
        elevation: 0,
        title: const Text(
          'Controle de Gastos',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
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
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    String tempValue =
                        _inputValue; 
                    final TextEditingController
                    valueController = TextEditingController(
                      text: tempValue == '0' ? '' : _formatCurrency(tempValue),
                    ); 

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
                              'Digite o valor',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              cursorColor: Colors.blueAccent,
                              controller: valueController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                labelText: "Valor",
                                labelStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                                prefixIcon: const Icon(
                                  Icons.attach_money,
                                  color: Colors.blueAccent,
                                ),
                                suffix: Text(
                                  "reais",
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
                              onChanged: (value) {
                                String displayValueInTextField;
                                if (value.isEmpty) {
                                  displayValueInTextField =
                                      ''; 
                                  tempValue =
                                      '0'; 
                                } else {
                                  displayValueInTextField = _formatCurrency(
                                    value,
                                  ); 
                                  tempValue =
                                      value; 
                                }
                                valueController.value = TextEditingValue(
                                  text: displayValueInTextField,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(
                                      offset: displayValueInTextField.length,
                                    ),
                                  ),
                                );
                              },
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
                                      Navigator.pop(context, tempValue);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "OK",
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
                ).then((result) {
                  if (result != null) {
                    setState(() {
                      _inputValue =
                          result;
                    });
                  }
                });
              },
              child: Text(
                _formatCurrency(_inputValue),
                semanticsLabel:
                    _inputValue == '0'
                        ? ''
                        : _formatCurrency(
                          _inputValue,
                        ),
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _getTextoValor(),
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Nome da transação',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) => _nome = value,
            cursorColor: Colors.blueAccent,
            decoration: InputDecoration(
              hintText: 'Digite o nome...',
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
                    spacing: 19,
                    runSpacing: 10,
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
                          _categorias.entries.map((entry) {
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
            'Frequência',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            onChanged: (value) => _frequencia = value ?? '',
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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
            items: const [
              DropdownMenuItem(value: 'Unicamente', child: Text('Unicamente')),
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
            cursorColor: Colors.blueAccent,
            decoration: InputDecoration(
              hintText: 'Digite uma observação...',
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
