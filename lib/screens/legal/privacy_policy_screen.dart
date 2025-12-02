import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finan/theme/app_colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          'Política de Privacidade',
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
              _buildSectionTitle('1. Informações que Coletamos'),
              _buildSectionContent(
                'O Finan coleta informações que você nos fornece diretamente, incluindo: dados de cadastro (nome, e-mail, telefone), informações financeiras (transações, contas bancárias), dados de uso do aplicativo, informações de dispositivo e localização.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('2. Como Usamos suas Informações'),
              _buildSectionContent(
                'Utilizamos suas informações para: fornecer e melhorar nossos serviços, processar suas transações financeiras, enviar notificações importantes, personalizar sua experiência, prevenir fraudes e garantir segurança, cumprir obrigações legais.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('3. Compartilhamento de Dados'),
              _buildSectionContent(
                'O Finan não vende suas informações pessoais. Podemos compartilhar seus dados apenas com: prestadores de serviços autorizados, instituições financeiras parceiras (com seu consentimento), autoridades legais quando exigido por lei, em caso de fusão ou aquisição da empresa.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('4. Segurança dos Dados'),
              _buildSectionContent(
                'Implementamos medidas de segurança técnicas e organizacionais para proteger suas informações, incluindo: criptografia de dados em trânsito e em repouso, autenticação de dois fatores, monitoramento contínuo de atividades suspeitas, backups regulares e recuperação de desastres.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('5. Seus Direitos'),
              _buildSectionContent(
                'De acordo com a LGPD (Lei Geral de Proteção de Dados), você tem direito a: acessar seus dados pessoais, corrigir dados incompletos ou desatualizados, solicitar a exclusão de seus dados, revogar consentimento, portabilidade de dados, informações sobre compartilhamento.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('6. Retenção de Dados'),
              _buildSectionContent(
                'Mantemos suas informações pessoais pelo tempo necessário para cumprir os propósitos descritos nesta política, a menos que um período de retenção maior seja exigido ou permitido por lei.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('7. Cookies e Tecnologias Similares'),
              _buildSectionContent(
                'Utilizamos cookies e tecnologias similares para melhorar sua experiência, analisar padrões de uso e personalizar conteúdo. Você pode gerenciar suas preferências de cookies nas configurações do aplicativo.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('8. Privacidade de Menores'),
              _buildSectionContent(
                'Nossos serviços não são direcionados a menores de 18 anos. Não coletamos intencionalmente informações de menores. Se tomarmos conhecimento de que coletamos dados de um menor, tomaremos medidas para excluir essas informações.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('9. Transferência Internacional de Dados'),
              _buildSectionContent(
                'Seus dados podem ser transferidos e mantidos em computadores localizados fora do seu país, onde as leis de proteção de dados podem ser diferentes. Ao usar o Finan, você consente com essa transferência.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('10. Alterações nesta Política'),
              _buildSectionContent(
                'Podemos atualizar esta Política de Privacidade periodicamente. Notificaremos você sobre quaisquer alterações significativas através do aplicativo ou por e-mail. O uso contínuo do aplicativo após as alterações constitui aceitação da política revisada.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('11. Contato'),
              _buildSectionContent(
                'Para exercer seus direitos de privacidade ou se tiver dúvidas sobre esta política, entre em contato conosco através do e-mail de suporte fornecido no aplicativo ou na seção de ajuda.',
              ),
              const SizedBox(height: 40),
              Text(
                'Última atualização: Dezembro de 2025',
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
