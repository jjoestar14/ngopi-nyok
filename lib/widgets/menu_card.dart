import 'package:flutter/material.dart';
import '../konstanta.dart';
import '../utils/format_rupiah.dart';
import 'radial_hero.dart';
import 'tombol_favorit.dart';

/// Kartu untuk menampilkan satu item menu pada halaman katalog.
class MenuCard extends StatelessWidget {
  final String nama;
  final String kategori;
  final String deskripsi;
  final int harga;
  final bool tersedia;
  final IconData ikon;
  final String heroTag;
  final ValueNotifier<bool> favorit;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  // Constructor const pada widget
  const MenuCard({
    super.key,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
    required this.tersedia,
    required this.ikon,
    required this.heroTag,
    required this.favorit,
    required this.onTap,
    required this.onLongPress,
  });

  // Satu BoxDecoration static const memuat sekaligus:
  // LinearGradient, borderRadius 20, border, dan boxShadow.
  static const BoxDecoration _dekorasiKartu = BoxDecoration(
    gradient: LinearGradient(
      colors: [kWarnaPutihKrem, kWarnaKrem],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(kRadiusKartu)),
    border: Border.fromBorderSide(
      BorderSide(color: kWarnaBorderKartu, width: 1.5),
    ),
    boxShadow: [
      BoxShadow(
        color: kWarnaBayanganKartu,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  // Dekorasi lingkaran ikon memakai BoxShape.circle (tanpa borderRadius)
  static const BoxDecoration _dekorasiLingkaranIkon = BoxDecoration(
    shape: BoxShape.circle,
    gradient: kGradienIkon,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // AnimatedOpacity: transparansi 0.4 selama 400 ms jika habis.
        // Pada nilai 1.0 Flutter tidak membuat layer offscreen (saveLayer),
        // sehingga kartu yang tersedia tetap murah untuk digambar.
        AnimatedOpacity(
          opacity: tersedia ? kOpacityTersedia : kOpacityHabis,
          duration: kDurasiFade,
          curve: Curves.easeInOut,
          // Container terluar dengan tepat satu BoxDecoration
          child: Container(
            decoration: _dekorasiKartu,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(kRadiusKartu),
                ),
                onTap: onTap,
                onLongPress: onLongPress,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
                  child: Row(
                    children: [
                      // RadialHero membungkus lingkaran ikon pada kartu
                      RadialHero(
                        tag: heroTag,
                        ikon: ikon,
                        // Ikon berada di dalam lingkaran
                        child: Container(
                          width: kUkuranLingkaranIkon,
                          height: kUkuranLingkaranIkon,
                          alignment: Alignment.center,
                          decoration: _dekorasiLingkaranIkon,
                          child: Icon(
                            ikon,
                            color: kWarnaPutihKrem,
                            size: kUkuranIkonKecil,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tersedia ? '$kategori • Tersedia' : kategori,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tersedia
                                    ? kWarnaHijauTersedia
                                    : kWarnaTeksSamar,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: kWarnaCokelatTua,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              deskripsi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: kWarnaTeksSamar,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              formatRupiah(harga),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: kWarnaCokelat,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TombolFavorit(
                        key: ValueKey('tombol-favorit-$heroTag'),
                        favorit: favorit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Label "Habis" berada di luar AnimatedOpacity agar tetap terbaca jelas
        Positioned(
          top: 0,
          right: 22,
          child: IgnorePointer(
            child: AnimatedSwitcher(
              duration: kDurasiFade,
              child: tersedia ? const SizedBox.shrink() : const _BadgeHabis(),
            ),
          ),
        ),
      ],
    );
  }
}

/// Label penanda menu habis yang "menggantung" di tepi atas kartu.
class _BadgeHabis extends StatelessWidget {
  const _BadgeHabis();

  static const BoxDecoration _dekorasiBadge = BoxDecoration(
    color: kWarnaMerahHabis,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: _dekorasiBadge,
      child: const Text(
        'Habis',
        style: TextStyle(
          color: kWarnaPutihKrem,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
