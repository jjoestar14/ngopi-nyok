import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../konstanta.dart';
import '../models/menu_item.dart';
import '../widgets/item_menu.dart';
import '../widgets/spinning_cup.dart';

/// Kondisi filter katalog: kategori terpilih (null = semua) dan kata kunci pencarian.
class _FilterMenu {
  final String? kategori;
  final String kueri;

  const _FilterMenu({this.kategori, this.kueri = ''});

  _FilterMenu denganKategori(String? nilai) =>
      _FilterMenu(kategori: nilai, kueri: kueri);

  _FilterMenu denganKueri(String nilai) =>
      _FilterMenu(kategori: kategori, kueri: nilai);

  bool cocok(MenuItem m) {
    final cocokKategori = kategori == null || m.kategori == kategori;
    final cocokNama = m.nama.toLowerCase().contains(kueri.trim().toLowerCase());
    return cocokKategori && cocokNama;
  }
}

/// Halaman Beranda: header cangkir berputar, pencarian, banner, chip kategori, dan daftar menu.
/// Daftar menu dimiliki oleh HomeShell (bersama halaman Favorit).
class KatalogPage extends StatefulWidget {
  final List<MenuItem> menus;

  const KatalogPage({super.key, required this.menus});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  // Filter disimpan di ValueNotifier, bukan setState: halaman tidak dibangun ulang,
  // hanya daftar yang dibungkus ValueListenableBuilder.
  final ValueNotifier<_FilterMenu> _filter =
      ValueNotifier<_FilterMenu>(const _FilterMenu());
  final TextEditingController _cariController = TextEditingController();

  @override
  void dispose() {
    _filter.dispose();
    _cariController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // [BUTIR 5] & [BUTIR 6] Header const, tidak ikut rebuild saat filter berubah
        const HeaderKatalog(),
        Expanded(
          child: ValueListenableBuilder<_FilterMenu>(
            valueListenable: _filter,
            builder: (context, filter, _) {
              final tampil = widget.menus.where(filter.cocok).toList();
              // [BUTIR 3] ListView.builder: indeks 0 = bagian intro, sisanya kartu menu
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                itemCount: tampil.isEmpty ? 2 : tampil.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return _IntroKatalog(
                      key: const ValueKey('intro'),
                      controller: _cariController,
                      filter: filter,
                      jumlah: tampil.length,
                      onKueri: (v) =>
                          _filter.value = _filter.value.denganKueri(v),
                      onKategori: (k) =>
                          _filter.value = _filter.value.denganKategori(k),
                    );
                  }
                  if (tampil.isEmpty) return const _KosongKatalog();
                  final item = tampil[i - 1];
                  return ItemMenu(
                    key: ValueKey(item.id),
                    item: item,
                    heroTag: 'menu-${item.id}',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Header: nama kedai di kiri dan ikon cangkir berputar di kanan.
class HeaderKatalog extends StatelessWidget {
  // [BUTIR 6] Widget header menggunakan const constructor
  const HeaderKatalog({super.key});

  static const BoxDecoration _dekorasiCangkir = BoxDecoration(
    shape: BoxShape.circle,
    color: kWarnaCokelatTua,
  );

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NGOPI NYOK',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: kWarnaCokelatTua,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'KEDAI KOPI & CAMILAN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                  color: kWarnaTeksSamar,
                ),
              ),
            ],
          ),
          Spacer(),
          // [BUTIR 5] Ikon cangkir berputar di header
          DecoratedBox(
            decoration: _dekorasiCangkir,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SpinningCup(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bagian atas daftar: sapaan, kolom cari, banner, chip kategori, dan judul daftar.
class _IntroKatalog extends StatelessWidget {
  final TextEditingController controller;
  final _FilterMenu filter;
  final int jumlah;
  final ValueChanged<String> onKueri;
  final ValueChanged<String?> onKategori;

  const _IntroKatalog({
    super.key,
    required this.controller,
    required this.filter,
    required this.jumlah,
    required this.onKueri,
    required this.onKategori,
  });

  static const OutlineInputBorder _garis = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: kWarnaBorderKartu),
  );

  static const OutlineInputBorder _garisFokus = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: kWarnaCokelat, width: 1.5),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        TextField(
          controller: controller,
          onChanged: onKueri,
          decoration: InputDecoration(
            hintText: 'Cari kopi atau camilan...',
            hintStyle: const TextStyle(color: kWarnaTeksSamar),
            prefixIcon: const Icon(Icons.search_rounded, color: kWarnaCokelat),
            suffixIcon: filter.kueri.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close_rounded, color: kWarnaCokelat),
                    onPressed: () {
                      controller.clear();
                      onKueri('');
                    },
                  ),
            filled: true,
            fillColor: kWarnaPutihKrem,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: _garis,
            enabledBorder: _garis,
            focusedBorder: _garisFokus,
          ),
        ),
        const SizedBox(height: 18),
        _BannerPilihan(onLihat: () => onKategori('Kopi')),
        const SizedBox(height: 18),
        _BarisKategori(terpilih: filter.kategori, onPilih: onKategori),
        const SizedBox(height: 22),
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: kWarnaCokelatTua,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tekan lama kartu untuk ubah ketersediaan',
                    style: TextStyle(fontSize: 12.5, color: kWarnaTeksSamar),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(
                color: kWarnaKrem,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: Text(
                '$jumlah Menu',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: kWarnaCokelat,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

/// Banner promosi berlatar gradien espresso. Tombolnya memfilter kategori Kopi.
class _BannerPilihan extends StatelessWidget {
  final VoidCallback onLihat;

  const _BannerPilihan({required this.onLihat});

  static const BoxDecoration _dekorasi = BoxDecoration(
    gradient: LinearGradient(
      colors: [kWarnaCokelat, kWarnaCokelatTua],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(24)),
    boxShadow: [
      BoxShadow(
        color: kWarnaBayanganKartu,
        blurRadius: 14,
        offset: Offset(0, 6),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: _dekorasi,
      child: Stack(
        children: [
          const Positioned(
            right: -26,
            bottom: -30,
            child: Icon(Icons.coffee_rounded, size: 160, color: kWarnaDekorBanner),
          ),
          const Positioned(
            right: 40,
            top: -34,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kWarnaDekorBanner,
              ),
              child: SizedBox(width: 96, height: 96),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 80, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    color: kWarnaPilBanner,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Text(
                      'Pilihan Barista',
                      style: TextStyle(fontSize: 12, color: kWarnaKrem),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Sedikit Pahit,\nBanyak Cerita.',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: kWarnaPutihKrem,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Seduh kopi favoritmu, nikmati tiap tegukan.',
                  style: TextStyle(fontSize: 12.5, color: kWarnaKrem),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: onLihat,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kWarnaPutihKrem,
                    foregroundColor: kWarnaCokelatTua,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Lihat Menu Kopi',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Baris chip kategori yang dapat digeser horizontal.
class _BarisKategori extends StatelessWidget {
  final String? terpilih;
  final ValueChanged<String?> onPilih;

  const _BarisKategori({required this.terpilih, required this.onPilih});

  Widget _chip(String label, bool aktif, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: aktif,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        selectedColor: kWarnaCokelatTua,
        backgroundColor: kWarnaKrem,
        side: BorderSide.none,
        shape: const StadiumBorder(),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: aktif ? kWarnaPutihKrem : kWarnaCokelat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip('Semua', terpilih == null, () => onPilih(null)),
          for (final k in kDaftarKategori)
            _chip(k, terpilih == k, () => onPilih(k)),
        ],
      ),
    );
  }
}

/// Tampilan ketika hasil pencarian kosong.
class _KosongKatalog extends StatelessWidget {
  const _KosongKatalog();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, size: 48, color: kWarnaTeksSamar),
          SizedBox(height: 10),
          Text(
            'Menu tidak ditemukan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kWarnaCokelatTua,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba kata kunci atau kategori lain.',
            style: TextStyle(fontSize: 13, color: kWarnaTeksSamar),
          ),
        ],
      ),
    );
  }
}
