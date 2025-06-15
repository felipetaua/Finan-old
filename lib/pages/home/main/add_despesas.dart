import 'package:finan/feedback/congratulationsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

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
    Icons.fastfood: Colors.amber, // Alimentação
    Icons.shopping_cart: Colors.blue, // Compras
    Icons.home: Colors.brown, // Moradia
    Icons.lightbulb: Colors.amber, // Conta de luz
    Icons.water_drop: Colors.lightBlueAccent, // Conta de água
    Icons.gas_meter: Colors.deepOrangeAccent, // Gás
    Icons.phone: Colors.lightBlue, // Telefone / Internet
    Icons.local_gas_station: Colors.orange, // Combustível
    Icons.cleaning_services: Colors.teal, // Limpeza / Serviços
    Icons.lock: Colors.grey, // Seguro residencial
    Icons.build: Colors.blueGrey, // Manutenção / Reformas

    Icons.directions_car: Colors.purpleAccent, // Transporte (carro)
    Icons.directions_bus: Colors.redAccent, // Transporte público
    Icons.directions_railway: Colors.indigoAccent, // Trem / Metrô
    Icons.directions_bike: Colors.greenAccent, // Bicicleta
    Icons.electric_bike: Colors.blueAccent, // Bike elétrica
    Icons.electric_car: Colors.deepPurpleAccent, // Carro elétrico
    Icons.car_rental: Colors.cyan, // Aluguel de carro
    Icons.flight: Colors.deepPurple, // Viagens aéreas
    Icons.map: Colors.purple, // Viagens / Localizações
    Icons.directions_boat: Colors.cyanAccent, // Barco / Passeios

    Icons.local_hospital: Colors.pink, // Saúde
    Icons.health_and_safety: Colors.red, // Seguro saúde
    Icons.work: Colors.teal, // Trabalho / Renda fixa
    Icons.attach_money: Colors.green, // Renda extra / Ganhos
    Icons.paid: Colors.green, // Pagamento recebido
    Icons.percent: Colors.red, // Juros / Impostos
    Icons.money_off: Colors.redAccent, // Multas / Dívidas
    Icons.credit_card: Colors.purpleAccent, // Cartão de crédito
    Icons.account_balance: Colors.indigo, // Banco / Conta
    Icons.savings: Colors.greenAccent, // Poupança / Reservas

    Icons.receipt: Colors.deepOrange, // Contas / Faturas
    Icons.redeem: Colors.cyan, // Recompensas / Cashback
    Icons.favorite: Colors.green, // Doações / Causas
    Icons.handshake: Colors.deepPurple, // Contratos / Parcerias

    Icons.school: Colors.indigo, // Educação
    Icons.book: Colors.blueGrey, // Materiais / Estudos
    Icons.baby_changing_station: Colors.pink, // Despesas com filhos
    Icons.pets: Colors.deepOrange, // Pets

    Icons.movie: Colors.lime, // Cinema / Entretenimento
    Icons.music_note: Colors.lightGreen, // Música / Streaming
    Icons.beach_access: Colors.tealAccent, // Férias / Viagens
    Icons.cake: Colors.pinkAccent, // Presentes / Festas
    Icons.camera: Colors.orangeAccent, // Fotografia / Hobby
    Icons.computer: Colors.yellow, // Eletrônicos
    Icons.emoji_events: Colors.yellowAccent, // Prêmios / Incentivos
    Icons.store: Colors.brown, // Loja / Negócio próprio
    Icons.eco: Colors.lightGreenAccent, // Sustentabilidade
    Icons.article: Colors.grey, // Outros / Geral
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {}); // Atualiza o estado para refletir a aba atual
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
        return Colors.redAccent; // Cor para Despesas
      case 1:
        return Colors.green; // Cor para Receitas
      case 2:
        return Colors.grey; // Cor para Transferências
      default:
        return Colors.white; // Cor padrão
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _getBackgroundColor(), // Cor dinâmica
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
                    String tempValue = _inputValue;
                    final TextEditingController valueController =
                        TextEditingController(text: _formatCurrency(tempValue));

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
                              // autofocus: true, // Removido para não focar automaticamente
                              controller: valueController,
                              keyboardType:
                                  TextInputType
                                      .number, // Alterado para TextInputType.number
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Permite apenas dígitos
                              ],
                              decoration: InputDecoration(
                                labelText: "Valor",
                                labelStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                                prefixIcon: const Icon(Icons.attach_money),
                                suffix: Text("reais"),
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
                                // Substitui ',' por '.' para padronizar o valor
                                tempValue = value.replaceAll(',', '.');
                                // value aqui são os dígitos puros devido a FilteringTextInputFormatter.digitsOnly
                                tempValue = value;
                                final formattedValue = _formatCurrency(value);
                                valueController.value = TextEditingValue(
                                  text: formattedValue,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: formattedValue.length),
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
                  if (result != null && result.isNotEmpty) {
                    setState(() {
                      _inputValue = result;
                    });
                  }
                });
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
            decoration: InputDecoration(
              hintText: 'Digite o nome...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue, // Cor do foco alterada para verde
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
            onChanged: (value) => _frequencia = value ?? '',
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue, // Cor do foco alterada para verde
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
            decoration: InputDecoration(
              hintText: 'Digite uma observação...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue, // Cor do foco alterada para verde
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
