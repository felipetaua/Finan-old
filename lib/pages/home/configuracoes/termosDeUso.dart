import 'package:flutter/material.dart';

class TermosDeUsoPage extends StatelessWidget {
  const TermosDeUsoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termos de Uso'),
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
              '1. Aceitação dos Termos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Ao utilizar este aplicativo, você concorda com os termos e condições aqui descritos. '
              'Se você não concordar, por favor, não utilize nossos serviços.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Uso do Aplicativo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Você concorda em utilizar o aplicativo de forma legal, ética e responsável. É proibido utilizar para fins ilícitos, abusivos ou que violem direitos de terceiros.',
            ),
            SizedBox(height: 16),
            Text(
              '3. Modificações',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Reservamo-nos o direito de modificar estes termos a qualquer momento. '
              'Você será notificado sobre alterações significativas.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Responsabilidades',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Não nos responsabilizamos por danos diretos ou indiretos decorrentes do uso do aplicativo.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Contato',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Para dúvidas, entre em contato: suporte@seudominio.com'),
          ],
        ),
      ),
    );
  }
}
