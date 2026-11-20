import 'package:flutter/material.dart';
import 'konstanta.dart';
import 'pages/home_shell.dart';

void main() {
  runApp(const KatalogMenuApp());
}

/// Widget akar aplikasi Katalog Menu.
class KatalogMenuApp extends StatelessWidget {
  // Penggunaan const pada widget utama
  const KatalogMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ngopi Nyok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kWarnaCokelat,
          surface: kWarnaLatarHalaman,
        ),
        scaffoldBackgroundColor: kWarnaLatarHalaman,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: kWarnaCokelatTua,
          contentTextStyle: TextStyle(color: kWarnaPutihKrem),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
        ),
      ),
      home: const HomeShell(),
    );
  }
}