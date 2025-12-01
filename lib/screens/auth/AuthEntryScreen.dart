import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finan/theme/app_colors.dart';
import 'package:finan/widgets/custom_button.dart';
import 'package:finan/widgets/custom_text_field.dart';
import 'package:finan/screens/auth/widgets/auth_widgets.dart';

class AuthEntryScreen extends StatefulWidget {
  const AuthEntryScreen({super.key});

  @override
  State<AuthEntryScreen> createState() => _AuthEntryScreenState();
}

class _AuthEntryScreenState extends State<AuthEntryScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _emailController;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleContinue() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite seu e-mail para continuar'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushNamed(
          context,
          '/login-password',
          arguments: _emailController.text,
        ).then((_) {
          if (mounted) {
            _animationController.reset();
          }
        });
      }
    });
  }

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
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 0),
                const Text(
                  'Finan',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    fontFamily: 'Madimi One',
                  ),
                ),
                const SizedBox(height: 15),

                Text(
                  'Login ou Criar Conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 25),

                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                CustomButton(
                  label: 'Continue',
                  onPressed: _isLoading ? null : _handleContinue,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 24),

                const OrDivider(),

                const SizedBox(height: 24),

                SocialAuthButton(
                  icon: FontAwesomeIcons.google,
                  label: 'Continue com Google',
                  iconColor: Colors.redAccent,
                  onPressed: () => _showSnackbar('Login com Google...'),
                ),
                SocialAuthButton(
                  icon: FontAwesomeIcons.apple,
                  label: 'Continue com Apple',
                  iconColor: Theme.of(context).colorScheme.onBackground,
                  onPressed: () => _showSnackbar('Login com Apple...'),
                ),
                SocialAuthButton(
                  icon: FontAwesomeIcons.facebook,
                  label: 'Continue com Facebook',
                  iconColor: const Color(0xFF3b5998),
                  onPressed: () => _showSnackbar('Login com Facebook...'),
                ),
                const SizedBox(height: 10),

                // Link de Ajuda
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/help'),
                  child: const Text(
                    'Precisa de Ajuda para criar conta?',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Texto Legal/Termos
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Ao se cadastrar, você está criando uma conta no Finan e concorda com os ',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF808080),
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Termos',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () =>
                                        Navigator.pushNamed(context, '/terms'),
                        ),
                        const TextSpan(text: ' e a '),
                        TextSpan(
                          text: 'Política de Privacidade',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => Navigator.pushNamed(
                                      context,
                                      '/privacy',
                                    ),
                        ),
                        const TextSpan(text: ' do Finan.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
