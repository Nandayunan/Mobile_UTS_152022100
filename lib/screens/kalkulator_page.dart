import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_header.dart';

/// KALKULATOR — sederhana
class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _display = '0';
  double? _acc;
  String? _op; // + - × ÷
  bool _resetOnNext = false;

  void _input(String v) {
    setState(() {
      if (_resetOnNext) {
        _display = (v == '.') ? '0.' : v;
        _resetOnNext = false;
        return;
      }
      if (v == '.') {
        if (_display.contains('.')) return;
        _display += '.';
      } else {
        _display = (_display == '0') ? v : _display + v;
      }
    });
  }

  void _operate(String op) {
    setState(() {
      _acc = double.tryParse(_display) ?? 0.0;
      _op = op;
      _resetOnNext = true;
    });
  }

  void _equals() {
    setState(() {
      final b = double.tryParse(_display) ?? 0.0;
      final a = _acc ?? 0.0;
      double res = b;
      switch (_op) {
        case '+':
          res = a + b;
          break;
        case '-':
          res = a - b;
          break;
        case '×':
          res = a * b;
          break;
        case '÷':
          res = b == 0 ? double.nan : a / b;
          break;
      }
      _display = _fmt(res);
      _acc = null;
      _op = null;
      _resetOnNext = true;
    });
  }

  void _square() {
    setState(() {
      final x = double.tryParse(_display) ?? 0.0;
      _display = _fmt(x * x);
      _resetOnNext = true;
    });
  }

  void _sqrt() {
    setState(() {
      final x = double.tryParse(_display) ?? 0.0;
      _display = x < 0 ? 'NaN' : _fmt(sqrt(x));
      _resetOnNext = true;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _acc = null;
      _op = null;
      _resetOnNext = false;
    });
  }

  void _backspace() {
    setState(() {
      if (_resetOnNext) {
        _display = '0';
        _resetOnNext = false;
      } else {
        _display = _display.length <= 1
            ? '0'
            : _display.substring(0, _display.length - 1);
      }
    });
  }

  String _fmt(double v) {
    if (v.isNaN || v.isInfinite) return v.toString();
    final s = v.toStringAsFixed(12);
    return RegExp(r'\.?0+$').hasMatch(s)
        ? s.replaceAll(RegExp(r'\.?0+$'), '')
        : s;
  }

  Widget _btn(String label, {Color? bg, VoidCallback? onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg ?? AppColors.card,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final gridPad = const EdgeInsets.all(8);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Kalkulator',
            subtitle:
                'Kalkulator sederhana dengan operasi dasar dan fungsional',
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _display,
                    key: const ValueKey('display'),
                    style: t.headlineLarge!.copyWith(color: AppColors.gold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _btn('7', onTap: () => _input('7')),
              _btn('8', onTap: () => _input('8')),
              _btn('9', onTap: () => _input('9')),
              _btn('÷', bg: AppColors.gold, onTap: () => _operate('÷')),
              _btn('4', onTap: () => _input('4')),
              _btn('5', onTap: () => _input('5')),
              _btn('6', onTap: () => _input('6')),
              _btn('×', bg: AppColors.gold, onTap: () => _operate('×')),
              _btn('1', onTap: () => _input('1')),
              _btn('2', onTap: () => _input('2')),
              _btn('3', onTap: () => _input('3')),
              _btn('-', bg: AppColors.gold, onTap: () => _operate('-')),
              _btn('.', onTap: () => _input('.')),
              _btn('0', onTap: () => _input('0')),
              _btn('⌫', onTap: _backspace),
              _btn('+', bg: AppColors.gold, onTap: () => _operate('+')),
              _btn('x²', onTap: _square),
              _btn('√x', onTap: _sqrt),
              _btn('C', onTap: _clear),
              _btn('=', bg: AppColors.gold, onTap: _equals),
            ],
          ),
          Padding(padding: gridPad),
        ],
      ),
    );
  }
}
