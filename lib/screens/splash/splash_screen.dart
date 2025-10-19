import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnim;

  late final AnimationController _lottieController;

  // Animações
  late final Animation<double> _logoScaleAnim;
  late final Animation<double> _logoFadeAnim;

  Timer? _navigationTimer;

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

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _lottieController = AnimationController(vsync: this);

    _logoController.forward();

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.forward();

        _navigationTimer = Timer(
          _fadeController.duration ?? const Duration(milliseconds: 500),
          () {
            if (mounted) Navigator.pushReplacementNamed(context, '/');
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _logoController.dispose();
    _fadeController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_fadeAnim),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _logoScaleAnim,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    //
                  ),
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/splashscreen.json',
                      controller: _lottieController,
                      fit: BoxFit.contain,
                      onLoaded: (composition) {
                        _lottieController.duration = composition.duration;
                        _lottieController.forward();
                      },
                    ),
                  ),
                ),
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
                opacity: _logoFadeAnim,
                child: Text(
                  'Controle financeiro na palma da mão',
                  textAlign: TextAlign.center,
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
      ),
    );
  }
}
