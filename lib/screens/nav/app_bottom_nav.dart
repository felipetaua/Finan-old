import 'package:finan/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _controller;
  late Animation<double> _fabScale;

  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home_outlined, label: 'Home'),
    _NavItem(icon: Icons.trending_up_outlined, label: 'Investir'),
    _NavItem(icon: Icons.bar_chart_outlined, label: 'Analytics'),
    _NavItem(icon: Icons.apps_rounded, label: 'Mais'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _fabScale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() => _selectedIndex = widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    if (index == 1) {
      // exemplo: poderia abrir outra tela/ação
    }
    widget.onTap(index);
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final double height = 84;
    return SizedBox(
      height: height + 30,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Container(
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.lightSurface
                          : AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // left two items
                    _buildNavItem(context, 0),
                    _buildNavItem(context, 1),
                    SizedBox(width: 72), // espaço para o FAB central
                    _buildNavItem(context, 2),
                    _buildNavItem(context, 3),
                  ],
                ),
              ),
            ),
          ),

          // Floating central button
          Positioned(
            top: 20,
            child: ScaleTransition(
              scale: _fabScale,
              child: GestureDetector(
                onTap: () {
                  // ação central (pode mudar para abrir modal, trocar aba, etc)
                  // aqui chamamos onTap com -1 para sinalizar "central"
                  // mas você pode adaptar.
                  // widget.onTap(-1);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primaryLight, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: 0.0,
                      child: const Icon(
                        Icons.sync_alt,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // indicador inferior (barra pequena no centro) opcional - como no iOS home indicator
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? AppColors.lightDivider
                          : AppColors.darkDivider,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final bool selected = _selectedIndex == index;
    final _NavItem item = _items[index];

    final Color activeColor = AppColors.primary;
    final Color inactiveColor =
        Theme.of(context).brightness == Brightness.light
            ? AppColors.lightTextSecondary
            : AppColors.darkTextSecondary;

    return Expanded(
      child: InkWell(
        onTap: () => _handleTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with circle background when selected
              Container(
                padding: const EdgeInsets.all(6),
                decoration:
                    selected
                        ? BoxDecoration(
                          color: activeColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        )
                        : null,
                child: Icon(
                  item.icon,
                  size: 22,
                  color: selected ? activeColor : inactiveColor,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? activeColor : inactiveColor,
                ),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
