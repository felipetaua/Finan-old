import 'dart:convert';
import 'package:finan/pages/login/foco.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finan/pages/home/main/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool obscurePassword = true;
  bool estaCarregado = false;
  String mensagemErro = '';

  Future<void> logar() async {
    setState(() {
      estaCarregado = true;
      mensagemErro = '';
    });

    final url = Uri.parse(
      'https://finan-4854e-default-rtdb.firebaseio.com/usuario.json',
    );

    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final Map<String, dynamic>? dados = jsonDecode(resposta.body);

        if (dados != null) {
          bool usuarioValido = false;
          String nomeUsuario = '';

          dados.forEach((key, valor) {
            if (valor['email'] == emailController.text &&
                valor['senha'] == senhaController.text) {
              usuarioValido = true;
              nomeUsuario = valor['nome'];
            }
          });

          if (usuarioValido) {
            final prefs = await SharedPreferences.getInstance();
            final isFirstTime = prefs.getBool('isFirstTime') ?? true;

            if (isFirstTime) {
              await prefs.setBool('isFirstTime', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FocoPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GastosPage(nomeUsuario: nomeUsuario),
                ),
              );
            }
          } else {
            setState(() {
              mensagemErro = "Email ou senha inválidos";
              estaCarregado = false;
            });
          }
        } else {
          setState(() {
            mensagemErro = 'Erro ao buscar dados do servidor.';
            estaCarregado = false;
          });
        }
      } else {
        setState(() {
          mensagemErro = 'Erro de conexão com o servidor.';
          estaCarregado = false;
        });
      }
    } catch (e) {
      setState(() {
        mensagemErro = 'Erro ao conectar ao servidor.';
        estaCarregado = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          child: AppBar(
            title: Text('Finan', style: GoogleFonts.getFont('Aoboshi One')),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF368DF7),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Para acessar é só preencher os campos abaixo.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Email:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Color(0xFF368DF7),
                    hintText: 'Digite seu email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF368DF7),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Senha:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: senhaController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    prefixIconColor: Color(0xFF368DF7),
                    hintText: 'Digite sua senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF368DF7),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Lógica para esqueci a senha
                    },
                    child: const Text(
                      'Esqueci a senha',
                      style: TextStyle(color: Color(0xFF368DF7)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF368DF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed:
                          estaCarregado
                              ? null
                              : logar, // Desativa o botão enquanto carrega
                      child:
                          estaCarregado
                              ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ) // Indicador de carregamento
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não possui conta? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Registre-se',
                          style: TextStyle(
                            color: Color(0xFF368DF7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
