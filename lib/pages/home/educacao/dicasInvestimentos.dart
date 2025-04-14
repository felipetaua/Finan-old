import 'package:flutter/material.dart';

class DicasInvestimentos extends StatelessWidget {
  final List<Map<String, String>> dicas = [
    {
      'titulo': '1) Entenda o risco que está disposto a assumir',
      'descricao':
          'Investir depende do perfil de risco e do tempo. Jovens podem arriscar mais, enquanto quem está próximo da aposentadoria deve optar por segurança.',
    },
    {
      'titulo': '2) Tenha uma reserva de emergência',
      'descricao':
          'Antes de investir, tenha uma reserva com 3 a 6 meses de despesas em aplicações de alta liquidez.',
    },
    {
      'titulo': '3) Defina expectativas realistas',
      'descricao':
          'Não espere retornos rápidos. Tenha paciência, estude e evite promessas de enriquecimento rápido.',
    },
    {
      'titulo': '4) Não tente acompanhar o mercado',
      'descricao':
          'Investir regularmente é melhor que tentar prever o mercado. A consistência supera a sorte.',
    },
    {
      'titulo': '5) Diversifique',
      'descricao':
          'Distribua seus investimentos entre setores e ativos diferentes para reduzir riscos.',
    },
    {
      'titulo': '6) Fique de olho nas taxas',
      'descricao':
          'Taxas podem corroer seus lucros. Prefira investimentos com baixas taxas de administração.',
    },
    {
      'titulo': '7) Não entre em pânico',
      'descricao':
          'Mercado oscila. Tenha disciplina e não venda em baixa por impulso.',
    },
    {
      'titulo': '8) Evite seguir modinhas',
      'descricao':
          'Invista em ativos que você conhece. Pesquise antes de seguir tendências passageiras.',
    },
    {
      'titulo': '9) Seja inteligente ao lidar com impostos',
      'descricao':
          'Use contas vantajosas fiscalmente e segure investimentos por mais de um ano quando possível.',
    },
    {
      'titulo': '10) Reajuste o seu portfólio',
      'descricao':
          'Rebalanceie seus investimentos periodicamente conforme seu perfil e objetivos.',
    },
    {
      'titulo': '11) Continue aprendendo',
      'descricao':
          'Acompanhe tendências e notícias. Aprenda sempre para melhorar suas decisões.',
    },
    {
      'titulo': '12) Peça ajuda quando precisar',
      'descricao':
          'Um bom consultor financeiro pode te ajudar a traçar estratégias mais seguras e eficazes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        title: Text('Dicas de Investimentos'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Investir pode ser emocionante e desafiador. Então aqui estão algumas dicas para ajudar iniciantes a investirem com mais confiança e segurança.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          ...dicas.map(
            (dica) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  dica['titulo']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(dica['descricao']!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
