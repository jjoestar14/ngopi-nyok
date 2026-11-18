import 'package:flutter/material.dart';
import '../konstanta.dart';
import '../models/menu_item.dart';
import '../pages/detail_page.dart';
import 'menu_card.dart';

/// Satu baris menu di daftar (dipakai di Beranda dan Favorit).
/// Hanya baris ini yang dibangun ulang saat status ketersediaan berubah.
class ItemMenu extends StatelessWidget {
  final MenuItem item;
  final String heroTag;

  const ItemMenu({super.key, required this.item, required this.heroTag});

  // [BUTIR 4] Navigasi memakai PageRouteBuilder dengan durasi 600 ms (kDurasiHero)
  void _bukaDetail(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder<void>(
        transitionDuration: kDurasiHero,
        reverseTransitionDuration: kDurasiHero,
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailPage(item: item, heroTag: heroTag),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  // [BUTIR 2] Tekan lama: ubah status tersedia, lalu beri umpan balik lewat SnackBar.
  void _ubahKetersediaan(BuildContext context) {
    final bool baru = !item.tersedia.value;
    item.tersedia.value = baru;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            '${item.nama}: status diubah menjadi ${baru ? 'Tersedia' : 'Habis'}',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ValueListenableBuilder<bool>(
        valueListenable: item.tersedia,
        builder: (context, tersedia, _) => MenuCard(
          nama: item.nama,
          kategori: item.kategori,
          deskripsi: item.deskripsi,
          harga: item.harga,
          tersedia: tersedia,
          ikon: item.ikon,
          heroTag: heroTag,
          favorit: item.favorit,
          onTap: () => _bukaDetail(context),
          onLongPress: () => _ubahKetersediaan(context),
        ),
      ),
    );
  }
}
