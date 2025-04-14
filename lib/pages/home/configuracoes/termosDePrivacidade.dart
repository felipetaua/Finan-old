import 'package:flutter/material.dart';

class PoliticaDePrivacidadePage extends StatelessWidget {
  const PoliticaDePrivacidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidade'),
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
              '1. Coleta de Dados',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Coletamos informações como nome, e-mail e uso do aplicativo para melhorar sua experiência.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Uso dos Dados',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Os dados são utilizados para personalização, suporte ao cliente e melhorias no sistema.',
            ),
            SizedBox(height: 16),
            Text(
              '3. Compartilhamento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Não compartilhamos suas informações com terceiros sem o seu consentimento.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Segurança',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Adotamos medidas de segurança para proteger seus dados contra acessos não autorizados.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Direitos do Usuário',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Você pode solicitar a exclusão ou correção dos seus dados a qualquer momento.',
            ),
          ],
        ),
      ),
    );
  }
}
