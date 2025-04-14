import 'package:finan/pages/home/educacao/educationScreen.dart';
import 'package:finan/pages/home/ferramentas/configPages.dart';
import 'package:finan/pages/home/ferramentas/ferramentasScreen.dart';
import 'package:finan/pages/home/ferramentas/notificacoesScreen.dart';
import 'package:finan/pages/home/ferramentas/outrosScreen.dart';
import 'package:finan/pages/home/gastos/gerenciamentoScreen.dart';
import 'package:finan/pages/home/investimentos/investimentosSceenCard.dart';
import 'package:finan/pages/home/investimentos/investmentsPage.dart';
import 'package:finan/pages/home/main/add_despesas.dart';
import 'package:finan/pages/home/poupar/pouparScreen.dart';
import 'package:finan/pages/home/profile/avatarSelector.dart';
import 'package:finan/pages/home/profile/perfil.dart';
import 'package:finan/pages/home/renda/rendaScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GastosPage extends StatefulWidget {
  const GastosPage({super.key, required this.nomeUsuario, this.avatar});

  final String? avatar;
  final String nomeUsuario;

  @override
  State<GastosPage> createState() => _GastosPageState();
}

class _GastosPageState extends State<GastosPage> {
  int _selectedIndex = 2; // Começa na aba de Gastos
  String? _currentAvatar; // Para armazenar o avatar atual
  double _salario = 0.0; // Para armazenar o salário

  late List<Widget> _pages; // Declare _pages como late

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAvatar(); // Carrega o avatar
    _carregarSalario(); // Carrega o salário do usuário

    // Inicializa _pages no initState
    _pages = [
      PouparPage(),
      EducationPage(),
      _GastosContent(salario: _salario), // Passe o salário como parâmetro
      InvestimentosPage(),
      AdicionarTransacaoPage(),
    ];
  }

  // Função para carregar o avatar armazenado
  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentAvatar =
          prefs.getString('avatarPath') ??
          'assets/images/profile.png'; // Avatar padrão
    });
  }

  // Função para carregar o salário do usuário
  Future<void> _carregarSalario() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId'); // Recupera o ID do usuário salvo

    if (userId == null) {
      setState(() {
        _salario =
            0.0; // Define o salário como 0 se o usuário não estiver identificado
      });
      return;
    }

    final url = Uri.parse(
      'https://finan-4854e-default-rtdb.firebaseio.com/usuario/$userId.json',
    );

    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);
        setState(() {
          _salario =
              (dados['salario'] ?? 0)
                  .toDouble(); // Define o salário ou 0 como padrão
        });
      } else {
        setState(() {
          _salario = 0.0; // Define o salário como 0 em caso de erro
        });
      }
    } catch (e) {
      setState(() {
        _salario = 0.0; // Define o salário como 0 em caso de exceção
      });
    }
  }

  // Função para abrir a página de seleção de avatar
  void _openAvatarSelector() async {
    final newAvatar = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarSelectorPage(currentAvatar: _currentAvatar),
      ),
    );

    // Se um novo avatar for selecionado, salvar e atualizar o estado
    if (newAvatar != null && newAvatar is String) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'avatarPath',
        newAvatar,
      ); // Salva o avatar no SharedPreferences
      setState(() {
        _currentAvatar = newAvatar; // Atualiza o estado com o novo avatar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF368DF7),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder:
                          (context) => SizedBox(
                            height: 200, //
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: const Text('Ver perfil'),
                                  onTap: () {
                                    Navigator.pop(context); // Fecha o modal
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => ProfilePage(
                                              currentAvatar: _currentAvatar,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.settings),
                                  title: const Text('Configurações'),
                                  onTap: () {
                                    Navigator.pop(context); // Fecha o modal
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ConfiguracoesPage(),
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Editar avatar'),
                                  onTap: () {
                                    Navigator.pop(context); // Fecha o modal
                                    _openAvatarSelector(); // Abre a página de seleção de avatar
                                  },
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      _currentAvatar ??
                          'assets/images/profile.png', // Avatar atual ou padrão
                    ),
                    radius: 25,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Olá ${widget.nomeUsuario}!',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NotificacoesPage()),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.star_border, color: Colors.white),
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesPage(),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionPage()),
          );
        },
        backgroundColor: const Color(0xFF368DF7),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF368DF7),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded),
            label: 'Poupar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Educação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Investimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Receitas',
          ),
        ],
      ),
    );
  }
}

class _GastosContent extends StatelessWidget {
  final double salario; // Adicione o parâmetro salário

  const _GastosContent({required this.salario});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suas rendas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'R\$${salario.toStringAsFixed(2).replaceAll('.', ',')}', // Exibe o salário formatado
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.expand_more),
                    const Spacer(),
                    Image.asset(
                      'assets/icons/money-icon.png',
                      height: 32,
                      width: 32,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Text(
                      '+ R\$160,00',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    SizedBox(width: 6),
                    Text('▲ 3.09%', style: TextStyle(color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _RendaCategoria(
                      label: 'Dinheiro',
                      icon: Icons.add_circle_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => RendaScreen(
                                  categoria: 'Dinheiro',
                                  onSalarioAtualizado: () {},
                                ),
                          ),
                        );
                      },
                    ),
                    _RendaCategoria(
                      label: 'Investimentos',
                      icon: Icons.bar_chart,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvestimentosScreenCard(),
                          ),
                        );
                      },
                    ),
                    _RendaCategoria(
                      label: 'Outros',
                      icon: Icons.grid_view,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OutrosScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Column(
            children: const [
              _TransacaoItem(
                categoria: 'Entretenimento',
                descricao: 'Cartão de crédito',
                valor: '-65,50 R\$',
                data: '15/01/2025',
                icone: 'assets/icons/entretenimento.png',
                cor: Colors.red,
              ),
              _TransacaoItem(
                categoria: 'Casa',
                descricao: 'Aluguel da casa',
                valor: '-990,00 R\$',
                data: '15/01/2025',
                icone: 'assets/icons/casa.png',
                cor: Colors.red,
              ),
              _TransacaoItem(
                categoria: 'Combustível',
                descricao: 'Cartão de crédito',
                valor: '-105,00 R\$',
                data: '15/01/2025',
                icone: 'assets/icons/combustivel.png',
                cor: Colors.red,
              ),
              _TransacaoItem(
                categoria: 'Salário',
                descricao: 'Conta bancária',
                valor: '+4.500,00 R\$',
                data: '15/01/2025',
                icone: 'assets/icons/salario.png',
                cor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// Widget de categoria de renda
class _RendaCategoria extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap; // Função personalizada para navegação

  const _RendaCategoria({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executa a função personalizada ao clicar
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.blueGrey),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// Widget de transação
class _TransacaoItem extends StatelessWidget {
  final String categoria;
  final String descricao;
  final String valor;
  final String data;
  final String icone;
  final Color cor;

  const _TransacaoItem({
    required this.categoria,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(icone)),
        title: Text(categoria),
        subtitle: Text('$descricao\n$data'),
        isThreeLine: true,
        trailing: Text(
          valor,
          style: TextStyle(
            color: cor.withAlpha((1.0 * 255).toInt()),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
