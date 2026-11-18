import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../konstanta.dart';
import '../models/menu_item.dart';
import 'favorit_page.dart';
import 'katalog_page.dart';

/// Kerangka aplikasi: bottom navigation bar (Beranda dan Favorit).
/// Daftar menu dimiliki di sini supaya kedua halaman memakai data yang sama.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final List<MenuItem> _menus;
  late final Listenable _perubahanFavorit;
  late final List<Widget> _halaman;
  // Indeks tab disimpan di ValueNotifier: pindah tab hanya membangun ulang
  // IndexedStack dan NavigationBar, bukan kedua halaman.
  final ValueNotifier<int> _indeks = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _menus = buatDaftarMenu();
    _perubahanFavorit = Listenable.merge(_menus.map((m) => m.favorit).toList());
    // Halaman dibuat sekali; instance yang sama dipakai ulang sehingga tidak ikut rebuild.
    _halaman = [
      KatalogPage(menus: _menus),
      FavoritPage(
        menus: _menus,
        perubahanFavorit: _perubahanFavorit,
        onJelajahi: () => _indeks.value = 0,
      ),
    ];
  }

  @override
  void dispose() {
    for (final item in _menus) {
      item.dispose();
    }
    _indeks.dispose();
    super.dispose();
  }

  static const BoxDecoration _garisAtasNav = BoxDecoration(
    border: Border(top: BorderSide(color: kWarnaBorderKartu)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWarnaLatarHalaman,
      body: SafeArea(
        bottom: false,
        child: ValueListenableBuilder<int>(
          valueListenable: _indeks,
          // IndexedStack menjaga posisi scroll, filter, dan teks pencarian Beranda.
          // TickerMode mematikan animasi (cangkir berputar) pada tab yang tidak terlihat.
          builder: (context, indeks, _) => IndexedStack(
            index: indeks,
            children: [
              for (int i = 0; i < _halaman.length; i++)
                TickerMode(enabled: i == indeks, child: _halaman[i]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: _garisAtasNav,
        child: ValueListenableBuilder<int>(
          valueListenable: _indeks,
          builder: (context, indeks, _) => NavigationBar(
            selectedIndex: indeks,
            onDestinationSelected: (i) {
              // Tutup keyboard agar tidak tertinggal saat berpindah tab
              FocusManager.instance.primaryFocus?.unfocus();
              _indeks.value = i;
            },
            backgroundColor: kWarnaPutihKrem,
            surfaceTintColor: Colors.transparent,
            indicatorColor: kWarnaKrem,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: kWarnaTeksSamar),
                selectedIcon: Icon(Icons.home_rounded, color: kWarnaCokelatTua),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded, color: kWarnaTeksSamar),
                selectedIcon:
                    Icon(Icons.favorite_rounded, color: kWarnaCokelatTua),
                label: 'Favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
