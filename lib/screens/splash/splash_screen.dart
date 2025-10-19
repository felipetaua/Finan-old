import 'dart:async';
import 'package:flutter/material.dart';
import 'package:finan/theme/app_colors.dart';

const Duration splashDuration = Duration(milliseconds: 2500);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;

  late final AnimationController _coinController;

  // Animações
  late final Animation<double> _logoScaleAnim;
  late final Animation<double> _logoFadeAnim;
  late final Animation<Offset> _coinSlideAnim;
  late final Animation<double> _coinOpacityAnim;

  Timer? _navigationTimer;
  Timer? _delayedCoinTimer;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoScaleAnim = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _logoFadeAnim = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
    );

    _coinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _coinSlideAnim = Tween<Offset>(
      begin: const Offset(0, -3.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(parent: _coinController, curve: Curves.easeIn));

    _coinOpacityAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_coinController);

    _logoController.forward();

    _delayedCoinTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        _coinController.forward();
      }
    });

    _navigationTimer = Timer(splashDuration, () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _delayedCoinTimer?.cancel();
    _logoController.dispose();
    _coinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ScaleTransition(
                  scale: _logoScaleAnim,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),

                SlideTransition(
                  position: _coinSlideAnim,
                  child: FadeTransition(
                    opacity: _coinOpacityAnim,
                    child: const Icon(
                      Icons.savings,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            FadeTransition(
              opacity: _logoFadeAnim,
              child: ScaleTransition(
                scale: _logoScaleAnim,
                child: const Text(
                  'Finan',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            FadeTransition(
              opacity: _coinOpacityAnim,
              child: Text(
                'Seu planejamento financeiro começa aqui.',
                style: TextStyle(
                  color: theme.colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
