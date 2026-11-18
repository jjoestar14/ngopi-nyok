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
    // [BUTIR 5] AnimationController berputar berulang tanpa henti (repeat)
    _controller = AnimationController(
      vsync: this,
      duration: kDurasiPutarCangkir,
    )..repeat();
  }

  @override
  void dispose() {
    // [BUTIR 5] Membuang controller sebelum super.dispose() untuk mencegah kebocoran memori
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // [SEBELUM OPTIMASI]
    // - Tanpa RepaintBoundary: area repaint ikut meluas ke widget induknya.
    // - AnimatedBuilder tanpa parameter child: Icon dibuat ulang di setiap frame.
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Transform.rotate(
        angle: _controller.value * 2 * math.pi,
        child: Icon(
          Icons.local_cafe,
          size: 26,
          color: kWarnaPutihKrem,
        ),
      ),
    );
  }
}
