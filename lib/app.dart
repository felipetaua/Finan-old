import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/auth/AuthEntryScreen.dart';
import 'screens/auth/login_with_password_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/legal/terms_of_use_screen.dart';
import 'theme/app_theme.dart';

class FinanApp extends StatelessWidget {
  const FinanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const AuthEntryScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/terms': (context) => const TermsOfUseScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/login-password') {
          final email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => LoginWithPasswordScreen(email: email),
          );
        }
        return null;
      },
    );
  }
}
