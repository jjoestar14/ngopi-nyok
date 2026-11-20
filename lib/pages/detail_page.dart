import 'package:flutter/material.dart';
import '../konstanta.dart';
import '../models/menu_item.dart';
import '../utils/format_rupiah.dart';
import '../widgets/radial_hero.dart';
import '../widgets/tombol_favorit.dart';

/// Halaman detail: hasil transformasi radial hero (lingkaran -> persegi besar).
class DetailPage extends StatelessWidget {
  final MenuItem item;
  final String heroTag;

  const DetailPage({super.key, required this.item, required this.heroTag});

  static const BoxDecoration _dekorasiPersegi =
      BoxDecoration(gradient: kGradienIkon);

  static const BoxDecoration _dekorasiInfo = BoxDecoration(
    color: kWarnaPutihKrem,
    borderRadius: BorderRadius.all(Radius.circular(18)),
    border: Border.fromBorderSide(BorderSide(color: kWarnaBorderKartu)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWarnaLatarHalaman,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: kWarnaPutihKrem,
                      side: const BorderSide(color: kWarnaBorderKartu),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: kWarnaCokelatTua,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Detail Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kWarnaCokelatTua,
                      ),
                    ),
                  ),
                  TombolFavorit(favorit: item.favorit),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Target akhir RadialHero: persegi besar (rasio 1:1)
                    // dengan ClipRRect berradius akhir kRadiusPersegi.
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 340),
                        child: RadialHero(
                          tag: heroTag,
                          ikon: item.ikon,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kRadiusPersegi),
                              ),
                              child: DecoratedBox(
                                decoration: _dekorasiPersegi,
                                child: Center(
                                  child: Icon(
                                    item.ikon,
                                    color: kWarnaPutihKrem,
                                    size: kUkuranIkonBesar,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Status selalu sinkron karena memakai objek MenuItem yang sama
                    ValueListenableBuilder<bool>(
                      valueListenable: item.tersedia,
                      builder: (context, tersedia, _) => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _PilChip(
                            teks: item.kategori,
                            warnaLatar: kWarnaKrem,
                            warnaTeks: kWarnaCokelat,
                          ),
                          _PilChip(
                            teks: tersedia ? 'Status: Tersedia' : 'Status: Habis',
                            warnaLatar:
                                tersedia ? kWarnaHijauMuda : kWarnaMerahMuda,
                            warnaTeks:
                                tersedia ? kWarnaHijauTersedia : kWarnaMerahHabis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item.nama,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: kWarnaCokelatTua,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatRupiah(item.harga),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: kWarnaCokelat,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: _dekorasiInfo,
                      child: Row(
                        children: [
                          _SelInfo(
                            ikon: Icons.category_outlined,
                            label: 'Kategori',
                            nilai: item.kategori,
                          ),
                          const _GarisPemisah(),
                          _SelInfo(
                            ikon: Icons.payments_outlined,
                            label: 'Harga',
                            nilai: formatRupiah(item.harga),
                          ),
                          const _GarisPemisah(),
                          ValueListenableBuilder<bool>(
                            valueListenable: item.tersedia,
                            builder: (context, tersedia, _) => _SelInfo(
                              ikon: tersedia
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.cancel_outlined,
                              label: 'Status',
                              nilai: tersedia ? 'Tersedia' : 'Habis',
                              warnaNilai: tersedia
                                  ? kWarnaHijauTersedia
                                  : kWarnaMerahHabis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Deskripsi Produk',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: kWarnaCokelatTua,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.deskripsi,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.5,
                        color: kWarnaTeksSamar,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  label: const Text('Kembali ke Katalog'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kWarnaCokelatTua,
                    foregroundColor: kWarnaPutihKrem,
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Label kecil berbentuk pil (kategori dan status).
class _PilChip extends StatelessWidget {
  final String teks;
  final Color warnaLatar;
  final Color warnaTeks;

  const _PilChip({
    required this.teks,
    required this.warnaLatar,
    required this.warnaTeks,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Text(
          teks,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: warnaTeks,
          ),
        ),
      ),
    );
  }
}

/// Satu kolom pada kartu ringkasan (ikon, label, nilai).
class _SelInfo extends StatelessWidget {
  final IconData ikon;
  final String label;
  final String nilai;
  final Color warnaNilai;

  const _SelInfo({
    required this.ikon,
    required this.label,
    required this.nilai,
    this.warnaNilai = kWarnaCokelatTua,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(ikon, size: 22, color: kWarnaCokelat),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: kWarnaTeksSamar),
          ),
          const SizedBox(height: 2),
          Text(
            nilai,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: warnaNilai,
            ),
          ),
        ],
      ),
    );
  }
}

class _GarisPemisah extends StatelessWidget {
  const _GarisPemisah();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48,
      child: VerticalDivider(width: 1, thickness: 1, color: kWarnaBorderKartu),
    );
  }
}
