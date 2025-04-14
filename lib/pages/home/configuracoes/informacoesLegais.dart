import 'package:flutter/material.dart';

class InformacoesLegaisPage extends StatelessWidget {
  const InformacoesLegaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações Legais'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Propriedade Intelectual',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Todo o conteúdo do aplicativo, incluindo marca, nome, logotipo e interface são de propriedade exclusiva da empresa desenvolvedora.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Licenciamento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'O uso do aplicativo é concedido sob licença de uso pessoal e intransferível.',
            ),
            SizedBox(height: 16),
            Text(
              '3. Jurisdição',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Este contrato será regido pelas leis brasileiras. Quaisquer disputas serão resolvidas no foro da comarca da sede da empresa.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Responsabilidades do Usuário',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'O usuário se compromete a utilizar o app conforme as leis vigentes e este termo.',
            ),
          ],
        ),
      ),
    );
  }
}
