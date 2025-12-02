import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/auth/AuthEntryScreen.dart';
import 'screens/auth/login_with_password_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/nav/main_navigation_screen.dart';
import 'screens/legal/terms_of_use_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/support/help_screen.dart';
import 'theme/app_theme.dart';

class FinanApp extends StatefulWidget {
  const FinanApp({super.key});

  @override
  State<FinanApp> createState() => _FinanAppState();
}

class _FinanAppState extends State<FinanApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    // Listen for theme changes
    _startThemeListener();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme_mode') ?? 'system';
    setState(() {
      _themeMode = _getThemeModeFromString(theme);
    });
  }

  void _startThemeListener() {
    // Check for theme changes every second
    Future.delayed(const Duration(seconds: 1), () async {
      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        final theme = prefs.getString('theme_mode') ?? 'system';
        final newThemeMode = _getThemeModeFromString(theme);
        if (newThemeMode != _themeMode) {
          setState(() {
            _themeMode = newThemeMode;
          });
        }
        _startThemeListener();
      }
    });
  }

  ThemeMode _getThemeModeFromString(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const AuthEntryScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const MainNavigationScreen(),
        '/terms': (context) => const TermsOfUseScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
        '/help': (context) => const HelpScreen(),
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
