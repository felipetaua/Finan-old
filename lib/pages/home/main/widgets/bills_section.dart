import 'package:finan/pages/home/main/widgets/bill_list_item.dart';
import 'package:flutter/material.dart';

class BillsSection extends StatefulWidget {
  const BillsSection({super.key});

  @override
  State<BillsSection> createState() => _BillsSectionState();
}

class _BillsSectionState extends State<BillsSection> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo
    final allBills = [
      BillInfo('Dribbble', 'Aguardando pagamento', Icons.sports_basketball, const Color(0xFFEA4C89)),
      BillInfo('Font Awesome', 'Aguardando pagamento', Icons.font_download, const Color(0xFF1CA0F2)),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Contas a Pagar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text('Ver Todas'),
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Todas'),
              Tab(text: 'Próximas'),
              Tab(text: 'Anteriores'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200, // Altura fixa para a visualização das abas
          child: TabBarView(
            controller: _tabController,
            children: [
              // Aba "Todas"
              ListView.separated(
                itemCount: allBills.length,
                itemBuilder: (context, index) => BillListItem(info: allBills[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 10),
              ),
              // Aba "Próximas" - Deveria ter sua própria lista de dados
              const Center(child: Text('Nenhuma conta próxima', style: TextStyle(color: Colors.grey))),
              // Aba "Anteriores"
              const Center(child: Text('Nenhuma conta anterior', style: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
      ],
    );
  }
}