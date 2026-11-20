import 'package:flutter/material.dart';
import '../konstanta.dart';
import '../models/menu_item.dart';
import '../widgets/item_menu.dart';

/// Halaman Favorit: menampilkan menu yang diberi tanda hati di Beranda.
class FavoritPage extends StatelessWidget {
  final List<MenuItem> menus;

  /// Gabungan semua notifier favorit; halaman dibangun ulang hanya saat ada hati yang diubah.
  final Listenable perubahanFavorit;
  final VoidCallback onJelajahi;

  const FavoritPage({
    super.key,
    required this.menus,
    required this.perubahanFavorit,
    required this.onJelajahi,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: perubahanFavorit,
      builder: (context, _) {
        final daftar = menus.where((m) => m.favorit.value).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favoritku',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: kWarnaCokelatTua,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    daftar.isEmpty
                        ? 'Menu yang kamu sukai akan muncul di sini.'
                        : '${daftar.length} menu kesukaanmu',
                    style: const TextStyle(fontSize: 14, color: kWarnaTeksSamar),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: daftar.isEmpty
                  ? _KosongFavorit(onJelajahi: onJelajahi)
                  // Daftar favorit juga memakai ListView.builder
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                      itemCount: daftar.length,
                      itemBuilder: (context, i) {
                        final item = daftar[i];
                        // Tag hero berbeda dari Beranda agar tidak bentrok di IndexedStack
                        return ItemMenu(
                          key: ValueKey(item.id),
                          item: item,
                          heroTag: 'fav-${item.id}',
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

/// Tampilan ketika belum ada menu favorit.
class _KosongFavorit extends StatelessWidget {
  final VoidCallback onJelajahi;

  const _KosongFavorit({required this.onJelajahi});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kWarnaKrem,
              ),
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 40,
                  color: kWarnaCokelat,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum ada favorit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kWarnaCokelatTua,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Ketuk ikon hati pada menu untuk menyimpannya di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: kWarnaTeksSamar),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: onJelajahi,
              style: ElevatedButton.styleFrom(
                backgroundColor: kWarnaCokelatTua,
                foregroundColor: kWarnaPutihKrem,
                elevation: 0,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Jelajahi Menu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
