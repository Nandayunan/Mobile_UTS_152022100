import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'biodata_page.dart';
import 'kontak_page.dart';
import 'kalkulator_page.dart';
import 'cuaca_page.dart';
import 'berita_page.dart';

/// MAIN SHELL dgn BottomNavigationBar
/// Tab: Biodata, Kontak, Kalkulator, Cuaca, Berita
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _pages = [
    const BiodataPage(),
    const KontakPage(),
    const KalkulatorPage(),
    const CuacaPage(),
    const BeritaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.workspace_premium, color: AppColors.gold),
            const SizedBox(width: 10),
            Text('Homepage', style: t.titleLarge),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_index],
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        indicatorColor: AppColors.gold.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            label: 'Biodata',
          ),
          NavigationDestination(
            icon: Icon(Icons.contacts_outlined),
            label: 'Kontak',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            label: 'Kalkulator',
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud_outlined),
            label: 'Cuaca',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            label: 'Berita',
          ),
        ],
      ),
    );
  }
}
