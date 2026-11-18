import 'package:flutter/material.dart';

/// Model data untuk satu item menu di katalog kafe.
class MenuItem {
  final int id;
  final String nama;
  final String kategori;
  final String deskripsi;
  final int harga;
  final IconData ikon;
  final ValueNotifier<bool> tersedia;
  final ValueNotifier<bool> favorit;

  MenuItem({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
    required this.ikon,
    required bool tersediaAwal,
  })  : tersedia = ValueNotifier<bool>(tersediaAwal),
        favorit = ValueNotifier<bool>(false);

  /// Membersihkan semua ValueNotifier ketika halaman ditutup.
  void dispose() {
    tersedia.dispose();
    favorit.dispose();
  }
}
