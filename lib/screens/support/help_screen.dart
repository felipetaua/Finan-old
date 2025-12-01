import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finan/theme/app_colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        title: Text(
          'Central de Ajuda',
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
              // Título principal
              Text(
                'Como podemos ajudar?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Encontre respostas para as perguntas mais frequentes sobre o Finan.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Perguntas Frequentes
              _buildSectionTitle('Perguntas Frequentes'),
              const SizedBox(height: 16),

              _buildFAQItem(
                context,
                'Como criar uma conta no Finan?',
                'Para criar uma conta, basta inserir seu e-mail na tela inicial e seguir os passos de cadastro. Você também pode se cadastrar usando sua conta do Google, Apple ou Facebook.',
              ),
              _buildFAQItem(
                context,
                'Esqueci minha senha, o que fazer?',
                'Na tela de login, clique em "Esqueceu a senha?" e siga as instruções para redefinir sua senha. Um e-mail será enviado com as instruções de recuperação.',
              ),
              _buildFAQItem(
                context,
                'Como o Finan protege meus dados?',
                'O Finan utiliza criptografia de ponta a ponta para proteger suas informações financeiras. Nunca compartilhamos seus dados com terceiros sem seu consentimento.',
              ),
              _buildFAQItem(
                context,
                'Posso usar o Finan em vários dispositivos?',
                'Sim! Faça login com sua conta em qualquer dispositivo e seus dados serão sincronizados automaticamente.',
              ),
              _buildFAQItem(
                context,
                'Como excluir minha conta?',
                'Você pode excluir sua conta a qualquer momento nas configurações do aplicativo. Todos os seus dados serão permanentemente removidos.',
              ),

              const SizedBox(height: 32),

              // Contato
              _buildSectionTitle('Precisa de mais ajuda?'),
              const SizedBox(height: 16),

              _buildContactCard(
                context,
                icon: Icons.email_outlined,
                title: 'E-mail',
                description: 'suporte@finan.com.br',
                subtitle: 'Resposta em até 24 horas',
              ),
              const SizedBox(height: 12),

              _buildContactCard(
                context,
                icon: Icons.chat_bubble_outline,
                title: 'Chat ao vivo',
                description: 'Disponível 24/7',
                subtitle: 'Resposta imediata',
              ),
              const SizedBox(height: 12),

              _buildContactCard(
                context,
                icon: Icons.help_outline,
                title: 'Central de Ajuda Online',
                description: 'Acesse nossa base de conhecimento',
                subtitle: 'Artigos e tutoriais',
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
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            question,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: Theme.of(
            context,
          ).colorScheme.onBackground.withOpacity(0.6),
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
