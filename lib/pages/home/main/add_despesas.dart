import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _inputValue = '0';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {}); // Atualiza a cor quando desliza entre as abas
    });
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (value == 'del') {
        if (_inputValue.length > 1) {
          _inputValue = _inputValue.substring(0, _inputValue.length - 1);
        } else {
          _inputValue = '0';
        }
      } else {
        if (_inputValue == '0') {
          _inputValue = value;
        } else {
          _inputValue += value;
        }
      }
    });
  }

  Widget _buildKeyboard() {
    final keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'del',
      '0',
      'ok',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final key = keys[index];
        IconData? icon;
        if (key == 'del') icon = Icons.backspace_outlined;
        if (key == 'ok') icon = Icons.check;

        return ElevatedButton(
          onPressed: () => _onKeyboardTap(key),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
          ),
          child:
              icon != null
                  ? Icon(icon)
                  : Text(key, style: const TextStyle(fontSize: 20)),
        );
      },
    );
  }

  String _formatCurrency(String value) {
    final digits = value.padLeft(3, '0');
    final cents = digits.substring(digits.length - 2);
    final reais = digits.substring(0, digits.length - 2);
    return 'R\$ ${reais.isEmpty ? '0' : reais},$cents';
  }

  Widget _buildTransactionTab(String tipo) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                Text(
                  'Categorias',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text('ver tudo', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildTransferTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          'A funcionalidade de transferência ainda não está disponível.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabColors = [Colors.red, Colors.green, Colors.grey];
    final tabLabels = ['Despesas', 'Receita', 'Transferência'];

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: tabColors[_tabController.index],
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white,
                  onTap: (_) => setState(() {}),
                  tabs: tabLabels.map((label) => Tab(text: label)).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  _formatCurrency(_inputValue),
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionTab('Despesas'),
                _buildTransactionTab('Receita'),
                _buildTransferTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
