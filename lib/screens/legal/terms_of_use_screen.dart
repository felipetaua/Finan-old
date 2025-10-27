import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finan/theme/app_colors.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Defina o estilo da barra de status
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        title: Text(
          'Termos de Uso',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('1. Aceitação dos Termos'),
              _buildSectionContent(
                'Ao acessar e usar o aplicativo Finan, você aceita estar vinculado por estes Termos de Uso. Se você não concordar com qualquer parte destes termos, você não pode usar nosso aplicativo.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('2. Uso Apropriado'),
              _buildSectionContent(
                'Você concorda em usar o aplicativo apenas para fins legítimos e de forma que não infrinja os direitos de terceiros ou restrinja seu uso e prazer. O comportamento proibido inclui: assédio ou violência, conteúdo ofensivo, acesso não autorizado a dados, interferência com o funcionamento normal do aplicativo.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('3. Propriedade Intelectual'),
              _buildSectionContent(
                'Todo conteúdo do aplicativo Finan, incluindo texto, gráficos, logotipos, imagens e software, é propriedade intelectual do Finan ou de seus fornecedores de conteúdo e é protegido pelas leis de direitos autorais.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('4. Contas de Usuário'),
              _buildSectionContent(
                'Você é responsável por manter a confidencialidade de suas credenciais de login. Você concorda em aceitar responsabilidade por todas as atividades que ocorrem sob sua conta. Você deve notificar-nos imediatamente sobre qualquer uso não autorizado de sua conta.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('5. Segurança de Dados'),
              _buildSectionContent(
                'O Finan implementa medidas de segurança para proteger seus dados pessoais. No entanto, nenhum método de transmissão ou armazenamento é 100% seguro. Você reconhece que se submete a riscos inerentes.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('6. Limitação de Responsabilidade'),
              _buildSectionContent(
                'O aplicativo Finan é fornecido "COMO ESTÁ" sem garantias de qualquer tipo. O Finan não será responsável por danos indiretos, incidentais, especiais ou consequentes decorrentes do uso ou da incapacidade de usar o aplicativo.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('7. Modificações dos Termos'),
              _buildSectionContent(
                'O Finan se reserva o direito de modificar estes Termos de Uso a qualquer momento. Continuando a usar o aplicativo após tais modificações, você está concordando em ficar vinculado pelos termos modificados.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('8. Lei Aplicável'),
              _buildSectionContent(
                'Estes Termos de Uso são regidos pelas leis do Brasil e você concorda em se submeter à jurisdição não exclusiva dos tribunais localizados no Brasil.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('9. Contato'),
              _buildSectionContent(
                'Se você tiver dúvidas sobre estes Termos de Uso, entre em contato conosco através do endereço de e-mail fornecido no aplicativo ou em nossa seção de suporte.',
              ),
              const SizedBox(height: 40),
              Text(
                'Última atualização: Outubro de 2025',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
      ),
    );
  }
}
