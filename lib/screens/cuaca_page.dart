import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';

/// CUACA — data statis
class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    // Data statis (bisa kamu ubah sesuka hati)
    const city = 'Bandung, ID';
    const temp = 24; // °C
    const humidity = 72; // %
    const condition = 'Berawan • Angin 2.1 m/s';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Cuaca',
            subtitle: 'Detail suhu, kelembapan, kondisi udara di lokasi anda.',
          ),
          const SizedBox(height: 12),
          Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF1D2433), AppColors.card],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  // Ikon matahari berputar halus (micro-animation)
                  AnimatedBuilder(
                    animation: _c,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: _c.value * 2 * pi,
                        child: const Icon(
                          Icons.wb_sunny_rounded,
                          size: 64,
                          color: AppColors.gold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(city, style: t.titleLarge),
                        const SizedBox(height: 6),
                        Text(
                          '$temp°C',
                          style: t.headlineMedium!.copyWith(
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('Kelembapan: $humidity%', style: t.bodyLarge),
                        Text(condition, style: t.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
