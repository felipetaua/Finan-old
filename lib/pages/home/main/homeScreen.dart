import 'package:finan/pages/home/educacao/educationScreen.dart';
import 'package:finan/pages/home/configuracoes/configPages.dart';
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
import 'package:flutter/services.dart';
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
  int _selectedIndex = 2;
  String? _currentAvatar;
  double _salario = 0.0;
  final List<Map<String, dynamic>> _transacoes = [];
  bool temaEscuro = false;

  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _adicionarTransacao(Map<String, dynamic> novaTransacao) {
    setState(() {
      _transacoes.add(novaTransacao);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAvatar(); // Carrega o avatar
    _carregarSalario(); // Carrega o salário do usuário

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF368DF7), // Cor da barra de status
        statusBarIconBrightness: Brightness.light, // Ícones brancos
      ),
    );
  }

  // Função para carregar o avatar armazenado
  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentAvatar =
          prefs.getString('avatarPath') ??
          'assets/avatares/avatar-default.jpg'; // Avatar padrão
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
    // Define _pages dentro do método build para garantir que _GastosContent
    // seja reconstruído com a lista de transações atualizada.
    _pages = [
      PouparPage(),
      EducationPage(),
      _GastosContent(salario: _salario, transacoes: _transacoes),
      InvestimentosPage(),
      AdicionarTransacaoPage(),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF368DF7),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF368DF7),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
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
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Editar avatar'),
                                    onTap: () {
                                      Navigator.pop(context); // Fecha o modal
                                      _openAvatarSelector(); // Abre a página de seleção de avatar
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.settings),
                                    title: const Text('Configurações'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => ConfiguracoesPage(
                                                temaEscuro: temaEscuro,
                                                onTemaAlterado: (novoValor) {
                                                  setState(() {
                                                    temaEscuro = novoValor;
                                                  });
                                                },
                                              ),
                                        ),
                                      );
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
                            'assets/avatares/avatar-default.jpg', // Avatar atual ou padrão
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
        body: IndexedStack(
          // Alterado para IndexedStack
          index: _selectedIndex,
          children: _pages,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        AddTransactionPage(onSave: _adicionarTransacao),
              ),
            );
          },
          backgroundColor: const Color(0xFF368DF7),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF368DF7),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.attach_money_rounded),
              label: _selectedIndex == 0 ? 'Poupar' : '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school_outlined),
              label: _selectedIndex == 1 ? 'Educação' : '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.swap_horiz),
              label: _selectedIndex == 2 ? 'Gastos' : '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.show_chart),
              label: _selectedIndex == 3 ? 'Investimentos' : '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long),
              label: _selectedIndex == 4 ? 'Gestão' : '',
            ),
          ],
        ),
      ),
    );
  }
}

class _GastosContent extends StatelessWidget {
  final double salario;
  final List<Map<String, dynamic>> transacoes;

  const _GastosContent({required this.salario, required this.transacoes});

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
                            builder:
                                (context) =>
                                    InvestimentosScreenCard(), //InvestimentosScreenCard
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Transações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Detalhes', style: TextStyle(color: Color(0xFF368DF7))),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children:
                transacoes.map((transacao) {
                  return TransacaoCard(transacao: transacao);
                }).toList(),
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

class TransacaoCard extends StatefulWidget {
  final Map<String, dynamic> transacao;

  const TransacaoCard({super.key, required this.transacao});

  @override
  State<TransacaoCard> createState() => _TransacaoCardState();
}

class _TransacaoCardState extends State<TransacaoCard> {
  bool _isExpanded = false; // Controla se o card está expandido

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Alterna entre expandido e contraído
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do card
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: widget.transacao['cor'],
                  child: Icon(
                    widget.transacao['categoria'],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.transacao['descricao'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.transacao['valor'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            widget.transacao['valor'].startsWith('+')
                                ? Colors.green
                                : widget.transacao['valor'].startsWith('-')
                                ? Colors.red
                                : Colors.grey,
                      ),
                    ),
                    Text(
                      widget.transacao['data'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 16),
              const Divider(), // Linha horizontal
              const SizedBox(height: 8),
              const Text(
                'Detalhes da Transação:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Categoria: ${widget.transacao['categoria']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                'Descrição: ${widget.transacao['descricao']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                'Data: ${widget.transacao['data']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                'Valor: ${widget.transacao['valor']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                'Obs: ${widget.transacao['observacao']}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
