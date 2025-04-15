import 'package:finan/pages/home/educacao/educationScreen.dart';
import 'package:finan/pages/home/ferramentas/ferramentasScreen.dart';
import 'package:finan/pages/home/ferramentas/notificacoesScreen.dart';
import 'package:finan/pages/home/gastos/gerenciamentoScreen.dart';
import 'package:finan/pages/home/investimentos/investmentsPage.dart';
import 'package:finan/pages/home/main/homeScreen.dart';
import 'package:finan/pages/home/poupar/pouparScreen.dart';
import 'package:finan/pages/home/profile/perfil.dart';
import 'package:finan/pages/login/foco.dart';
import 'package:finan/pages/login/login.dart';
import 'package:finan/pages/login/register.dart';
import 'package:finan/pages/login/screenSplash.dart';
import 'package:finan/pages/login/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF368DF7),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FinanApp());
}

class FinanApp extends StatelessWidget {
  const FinanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finan - Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      routes: {
        '/inicio': (context) => const WelcomeScreen(),
        '/poupar': (context) => const PouparPage(),
        '/investimentos': (context) => const InvestimentosPage(),
        '/economia-domestica': (context) => const EducationPage(),
        '/gastos': (context) => const GastosPage(nomeUsuario: ''),
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const RegisterPage(),
        '/foco': (context) => const FocoPage(),
        '/register': (context) => const RegisterPage(),
        '/perfil': (context) => const ProfilePage(),
        '/ferramentas': (context) => FavoritesPage(),
        '/notificacao': (context) => NotificacoesPage(),
        '/gerenciamento': (context) => AdicionarTransacaoPage(),
      },
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            final isLoggedIn = snapshot.data as bool;
            return isLoggedIn
                ? const GastosPage(nomeUsuario: '')
                : const WelcomeScreen();
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId'); // Verifica se o usuário está logado
  }
}
