import 'package:finan/pages/home/main/widgets/bills_section.dart';
import 'package:finan/pages/home/main/widgets/overview_card.dart';
import 'package:flutter/material.dart';

class DetalhesTransacoes extends StatelessWidget {
  const DetalhesTransacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // Ação para voltar
          },
        ),
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              OverviewCard(),
              SizedBox(height: 30),
              BillsSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}