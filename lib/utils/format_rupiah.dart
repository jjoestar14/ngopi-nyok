/// Mengubah angka integer menjadi string berformat Rupiah (contoh: Rp 18.000).
String formatRupiah(int nominal) {
  final teks = nominal.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < teks.length; i++) {
    if (i > 0 && (teks.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(teks[i]);
  }

  return 'Rp ${buffer.toString()}';
}