import 'package:flutter/material.dart';

// Semua warna, durasi, dan ukuran disimpan sebagai konstanta (const).
// Memakai literal Color(0xAARRGGBB) tanpa Color.withOpacity (tidak dihitung ulang saat runtime).

// Palet bertema kopi (espresso, krem, karamel)
const Color kWarnaLatarHalaman = Color(0xFFFBF6F0);
const Color kWarnaCokelatTua = Color(0xFF2E1B16);
const Color kWarnaCokelat = Color(0xFF5D4037);
const Color kWarnaCokelatMuda = Color(0xFF8D6E63);
const Color kWarnaKaramel = Color(0xFFD7A86E);
const Color kWarnaKrem = Color(0xFFF3E4D0);
const Color kWarnaPutihKrem = Color(0xFFFFFBF7);
const Color kWarnaBorderKartu = Color(0xFFE8D5BD);
const Color kWarnaBayanganKartu = Color(0x1F3E2723);
const Color kWarnaTeksSamar = Color(0xFF8A7569);
const Color kWarnaMerahHabis = Color(0xFFB3261E);
const Color kWarnaMerahMuda = Color(0xFFFADEDC);
const Color kWarnaHijauTersedia = Color(0xFF2E7D4F);
const Color kWarnaHijauMuda = Color(0xFFDDEFE2);
const Color kWarnaFavorit = Color(0xFFD6455D);
const Color kWarnaDekorBanner = Color(0x1AFFFFFF);
const Color kWarnaPilBanner = Color(0x26FFFFFF);

// Gradient untuk lingkaran ikon (kartu), shuttle hero, dan persegi besar di DetailPage
const LinearGradient kGradienIkon = LinearGradient(
  colors: [kWarnaCokelatMuda, kWarnaCokelatTua],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Durasi animasi
const Duration kDurasiHero = Duration(milliseconds: 600);
const Duration kDurasiFade = Duration(milliseconds: 400);
const Duration kDurasiPutarCangkir = Duration(seconds: 3);

// Opacity
const double kOpacityTersedia = 1.0;
const double kOpacityHabis = 0.4;

// Radius dan ukuran
const double kRadiusKartu = 20.0;
const double kRadiusPersegi = 28.0;
const double kUkuranLingkaranIkon = 60.0;
const double kUkuranIkonKecil = 28.0;
const double kUkuranIkonBesar = 140.0;
