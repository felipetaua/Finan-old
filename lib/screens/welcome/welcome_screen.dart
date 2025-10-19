import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color finanBlue = Color(0xFF1E88E5);
const Color darkText = Color(0xFF1D1D1D);
const Color lightGrayText = Color(0xFF5A5A5A);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overlay = SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: _AppHeaderImagePlaceholder(),
                ),
              ),

              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Planejamento financeiro que muda vidas.',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onBackground,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Com um planejamento eficiente mude sua vida para melhor, tenha liberdade e qualidade de vida.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),

                      SizedBox(height: 20),

                      _CtaButton(),

                      SizedBox(height: 20),
                    ],
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

class _AppHeaderImagePlaceholder extends StatelessWidget {
  const _AppHeaderImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              color: finanBlue.withOpacity(0.03),
              child: Align(
                alignment: const Alignment(0, 0.25),
                child: Image.asset(
                  'assets/images/mockup.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: finanBlue.withOpacity(0.1),
                        child: const Center(
                          child: Text(
                            'Mockup\\n(Placeholder)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: finanBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),

          const Positioned(
            left: 20,
            top: 12,
            child: Text(
              'Finan',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: finanBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
          debugPrint('Iniciar Pressionado');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: finanBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Iniciar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
