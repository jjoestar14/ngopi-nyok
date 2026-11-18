import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../konstanta.dart';

/// Widget pembungkus Hero yang mengubah bentuk lingkaran menjadi persegi besar
/// secara bertahap dengan lintasan melengkung (radial hero animation).
class RadialHero extends StatelessWidget {
  final String tag;
  final IconData ikon;
  final Widget child;

  const RadialHero({
    super.key,
    required this.tag,
    required this.ikon,
    required this.child,
  });

  // [BUTIR 4] Lintasan gerak melengkung menggunakan MaterialRectCenterArcTween
  static RectTween _buatRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static const BoxDecoration _dekorasiShuttle =
      BoxDecoration(gradient: kGradienIkon);

  @override
  Widget build(BuildContext context) {
    // [BUTIR 4] Hero dengan createRectTween dan flightShuttleBuilder
    return Hero(
      tag: tag,
      createRectTween: _buatRectTween,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // t bergerak 0.0 -> 1.0 saat push, dan 1.0 -> 0.0 saat pop
                final double t = animation.value;
                final double sisi = constraints.biggest.shortestSide;
                // [BUTIR 4] Radius ClipRRect diinterpolasi: lingkaran (sisi/2) -> persegi (kRadiusPersegi)
                final double radius = lerpDouble(sisi / 2, kRadiusPersegi, t)!;
                final double ukuranIkon = lerpDouble(
                  kUkuranIkonKecil,
                  kUkuranIkonBesar,
                  t,
                )!;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: DecoratedBox(
                    decoration: _dekorasiShuttle,
                    child: Center(
                      child: Icon(
                        ikon,
                        color: kWarnaPutihKrem,
                        size: ukuranIkon,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: child,
    );
  }
}
