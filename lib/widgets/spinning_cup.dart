import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../konstanta.dart';

/// Widget ikon cangkir kopi yang berputar terus-menerus di bagian header.
class SpinningCup extends StatefulWidget {
  const SpinningCup({super.key});

  @override
  State<SpinningCup> createState() => _SpinningCupState();
}

class _SpinningCupState extends State<SpinningCup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // AnimationController berputar berulang tanpa henti (repeat)
    _controller = AnimationController(
      vsync: this,
      duration: kDurasiPutarCangkir,
    )..repeat();
  }

  @override
  void dispose() {
    // Membuang controller sebelum super.dispose() untuk mencegah kebocoran memori
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary mengisolasi area gambar ulang (repaint) dari seluruh halaman.
    // AnimatedBuilder memakai parameter child agar widget Icon tidak dibangun ulang tiap frame.
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: const Icon(
          Icons.local_cafe,
          size: 26,
          color: kWarnaPutihKrem,
        ),
        builder: (context, child) => Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        ),
      ),
    );
  }
}