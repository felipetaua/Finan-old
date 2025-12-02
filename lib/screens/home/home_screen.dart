import 'package:finan/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finan/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = true;
  String userName = 'Tauã Felipe';
  bool isPremiumUser = true;

  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Starbucks Coffe',
      'date': '29 Novembro 20:30',
      'amount': -44.80,
      'cashback': 0.00,
      'icon': FontAwesomeIcons.coffee,
      'iconColor': const Color(0xFF00704A),
    },
    {
      'name': 'Compra Amazon',
      'date': '30 Outubro 11:21',
      'amount': -74.23,
      'cashback': 1.50,
      'icon': FontAwesomeIcons.amazon,
      'iconColor': const Color(0xFFFF9900),
    },
    {
      'name': 'Compra Mcdonalds',
      'date': '22 Outubro 20:13',
      'amount': -23.90,
      'cashback': 1.50,
      'icon': FontAwesomeIcons.burger,
      'iconColor': const Color(0xFFFFC300),
    },
    {
      'name': 'Netflix',
      'date': '05 Outubro 09:00',
      'amount': -39.90,
      'cashback': 0.00,
      'icon': FontAwesomeIcons.solidCirclePlay,
      'iconColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bom dia,',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color:
                                isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Plano ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightTextSecondary,
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors:
                                      isPremiumUser
                                          ? [
                                            const Color(0xFF22C6EB),
                                            const Color(0xFF4A90E2),
                                          ]
                                          : [
                                            const Color(0xFF9E9E9E),
                                            const Color(0xFF757575),
                                          ],
                                  stops: const [0.31, 0.60],
                                ).createShader(bounds);
                              },
                              child: Text(
                                isPremiumUser ? 'Premium' : 'Gratuito',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _HeaderButton(
                          icon: Icons.flash_on,
                          onPressed: () => _showSnackbar('Ajustes Rápidos'),
                          hasGradientBorder: true,
                        ),
                        const SizedBox(width: 8),
                        _HeaderButton(
                          icon: Icons.notifications_none,
                          onPressed: () => _showSnackbar('Notificações'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Seu saldo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isBalanceVisible ? 'R\$3,500.00' : 'R\$******',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color:
                                  isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isBalanceVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.lightTextSecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        label: 'Adicionar Dinheiro',
                        onPressed: () => _showSnackbar('Adicionar Dinheiro'),
                        backgroundColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seus Cartões',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showSnackbar('Novo cartão'),
                      child: const Text(
                        '+ Novo cartão',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _CreditCard(
                      isPrimary: true,
                      lastFourDigits: '2345',
                      cardType: 'VISA',
                      onDetailsPressed:
                          () => _showSnackbar('Ver Detalhes do Cartão 2345'),
                    ),
                    const SizedBox(width: 16),
                    _CreditCard(
                      isPrimary: false,
                      lastFourDigits: '1234',
                      cardType: 'MASTERCARD',
                      onDetailsPressed:
                          () => _showSnackbar('Ver Detalhes do Cartão 1234'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transações',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color:
                                  isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                            ),
                          ),
                          GestureDetector(
                            onTap:
                                () => _showSnackbar('Ver todas as transações'),
                            child: const Text(
                              'Ver todas',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // Desativa o scroll da lista
                        shrinkWrap: true,
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return _TransactionItem(
                            name: tx['name'],
                            date: tx['date'],
                            amount: tx['amount'],
                            cashback: tx['cashback'],
                            icon: tx['icon'],
                            iconColor: tx['iconColor'],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool hasGradientBorder;

  const _HeaderButton({
    required this.icon,
    required this.onPressed,
    this.hasGradientBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (hasGradientBorder) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF22C6EB), Color(0xFF4A90E2)],
            stops: [0.31, 0.60],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Color(0xFF22C6EB), Color(0xFF4A90E2)],
                  stops: [0.31, 0.60],
                ).createShader(bounds);
              },
              child: Icon(icon, color: Colors.white),
            ),
            onPressed: onPressed,
          ),
        ),
      );
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _CreditCard extends StatefulWidget {
  final bool isPrimary;
  final String lastFourDigits;
  final String cardType;
  final VoidCallback onDetailsPressed;

  const _CreditCard({
    required this.isPrimary,
    required this.lastFourDigits,
    required this.cardType,
    required this.onDetailsPressed,
  });

  @override
  State<_CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<_CreditCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.isPrimary ? AppColors.primary : AppColors.darkSurface,
            gradient:
                widget.isPrimary
                    ? const LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            boxShadow:
                widget.isPrimary
                    ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                    : null,
            image: DecorationImage(
              image: AssetImage(
                widget.isPrimary
                    ? 'assets/images/paterns/paterns-1.png'
                    : 'assets/images/paterns/paterns-2.png',
              ),
              fit: BoxFit.cover,
              opacity: 0.15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Finan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Madimi One',
                      ),
                    ),
                    Text(
                      widget.cardType,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cartão de Crédito',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '**** ${widget.lastFourDigits}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: OutlinedButton(
                            onPressed: widget.onDetailsPressed,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Detalhes',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String name;
  final String date;
  final double amount;
  final double cashback;
  final IconData icon;
  final Color iconColor;

  const _TransactionItem({
    required this.name,
    required this.date,
    required this.amount,
    required this.cashback,
    required this.icon,
    required this.iconColor,
  });

  String _formatCurrency(double value) {
    return 'R\$${value.abs().toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Valor e Cashback
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatCurrency(amount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                if (cashback > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '+${_formatCurrency(cashback)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          height: 1,
          thickness: 1,
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
