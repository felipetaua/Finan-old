import 'package:flutter/material.dart';

class CryptoDetailsPage extends StatelessWidget {
  const CryptoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investir em Criptomoedas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildIntroCard(),
            const SizedBox(height: 16),
            _buildStepsAccordion(),
            const SizedBox(height: 16),
            _buildSliderCard(
              title: 'Como investir com pouco dinheiro?',
              content:
                  'Você pode começar a investir com apenas R\$ 1,00. '
                  'Use estratégias como o investimento recorrente para diluir riscos e aproveitar oportunidades.',
            ),
            const SizedBox(height: 16),
            _buildSliderCard(
              title: 'Melhores criptos para iniciantes',
              content:
                  'Recomendadas: Bitcoin (BTC), Ethereum (ETH), Litecoin (LTC) e USD Coin (USDC). '
                  'Essas moedas são mais estáveis, seguras e com boa liquidez no mercado.',
            ),
            const SizedBox(height: 16),
            _buildSliderCard(
              title: 'Qual o valor mínimo para investir?',
              content:
                  'A maioria das exchanges permite começar com R\$ 1,00. '
                  'Foque no longo prazo e evite decisões impulsivas com as oscilações do mercado.',
            ),
            const SizedBox(height: 16),
            _buildSecurityTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text(
              'Comece a Investir em Criptomoedas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Descubra como dar seus primeiros passos no mundo dos investimentos digitais de forma simples e segura. '
              'Aprenda como comprar criptomoedas mesmo com pouco dinheiro!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsAccordion() {
    final steps = [
      {
        'title': 'Passo 1 - Escolha uma plataforma confiável',
        'content':
            'Pesquise por uma exchange segura ou um banco com suporte a criptomoedas. '
            'Considere reputação, taxas e facilidade de uso.',
      },
      {
        'title': 'Passo 2 - Crie sua conta e faça a verificação (KYC)',
        'content':
            'Cadastre-se e envie documentos básicos. Esse processo protege sua conta contra fraudes.',
      },
      {
        'title': 'Passo 3 - Deposite fundos',
        'content':
            'Transfira dinheiro da sua conta bancária para a plataforma. Comece com valores pequenos.',
      },
      {
        'title': 'Passo 4 - Compre sua primeira criptomoeda',
        'content':
            'Invista em moedas conhecidas como Bitcoin (BTC) ou Ethereum (ETH). '
            'Escolha o valor e conclua sua compra com segurança.',
      },
      {
        'title': 'Passo 5 - Armazene suas criptos com segurança',
        'content':
            'Use carteiras digitais (wallets). Iniciantes podem usar carteiras online antes de migrar para carteiras físicas.',
      },
      {
        'title': 'Passo 6 - Acompanhe e aprenda sempre',
        'content':
            'Monitore seus investimentos, estude sobre o mercado cripto e busque aprendizado contínuo.',
      },
    ];

    return ExpansionPanelList.radio(
      dividerColor: Colors.grey.shade300,
      elevation: 1,
      children:
          steps.map((step) {
            return ExpansionPanelRadio(
              value: step['title']!,
              headerBuilder:
                  (context, isExpanded) => ListTile(
                    title: Text(
                      step['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(step['content']!),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSliderCard({required String title, required String content}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blueGrey.shade50,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTips() {
    final tips = [
      'Use autenticação de dois fatores (2FA) para proteger sua conta.',
      'Nunca compartilhe senhas ou chaves privadas.',
      'Prefira carteiras confiáveis e atualizadas.',
      'Mantenha seus dispositivos protegidos e atualizados.',
      'Desconfie de promessas de lucros rápidos. Golpes são comuns.',
      'Use apenas plataformas com boa reputação no mercado.',
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dicas de Segurança',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...tips.map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.shield, size: 18, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Expanded(child: Text(tip)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
