import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gold_pill.dart';
import 'main_shell.dart';

/// SPLASH SCREEN (5 detik)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    // Pindah otomatis ke Dashboard setelah 5 detik (sesuai UTS)
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(_fade(const MainShell()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Route _fade(Widget page) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient + noise
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0E1218), Color(0xFF121722)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Accent gold shimmer blob
          Align(
            alignment: const Alignment(0.9, -0.8),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final v = (sin(_controller.value * 2 * pi) + 1) / 2;
                return Container(
                  width: 220 + 30 * v,
                  height: 220 + 30 * v,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.gold.withOpacity(0.25),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Foto kamu (pakai Image.asset dengan fallback)
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: AppColors.gold.withOpacity(0.2),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 108,
                        height: 108,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.person,
                              size: 48,
                              color: AppColors.gold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('Welcome to my project', style: t.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Nama: Abdy Ananda Yunan',
                    style: t.bodyLarge!.copyWith(color: AppColors.gold),
                  ),
                  const SizedBox(height: 4),
                  Text('NIM: 152022100', style: t.bodyMedium),
                  const SizedBox(height: 22),
                  const GoldPill(text: 'Pemrograman Mobile — UTS'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
