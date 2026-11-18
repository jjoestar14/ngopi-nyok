import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngopi_nyok/main.dart';
import 'package:ngopi_nyok/pages/detail_page.dart';
import 'package:ngopi_nyok/pages/favorit_page.dart';
import 'package:ngopi_nyok/pages/katalog_page.dart';

/// Layar setara ponsel (360x1200 dp) agar kartu pertama sudah terlihat di bawah bagian intro.
void _ukuranPonsel(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 3600);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets(
    '1. Beranda menampilkan menu pertama (Espresso) dan memakai ListView',
    (WidgetTester tester) async {
      _ukuranPonsel(tester);
      await tester.pumpWidget(const KatalogMenuApp());
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.descendant(
          of: find.byType(KatalogPage),
          matching: find.byType(ListView),
        ),
        findsOneWidget,
      );
      expect(find.text('Espresso'), findsOneWidget);
    },
  );

  testWidgets(
    '2. Long press pada kartu Espresso mengubah AnimatedOpacity ke 0.4 dan menambah label Habis',
    (WidgetTester tester) async {
      _ukuranPonsel(tester);
      await tester.pumpWidget(const KatalogMenuApp());
      await tester.pump(const Duration(milliseconds: 100));

      final int jumlahHabisAwal = tester.widgetList(find.text('Habis')).length;
      final Finder finderEspresso = find.text('Espresso');
      expect(finderEspresso, findsOneWidget);

      final Finder finderAnimatedOpacity = find.ancestor(
        of: finderEspresso,
        matching: find.byType(AnimatedOpacity),
      );
      expect(
        tester.widget<AnimatedOpacity>(finderAnimatedOpacity).opacity,
        1.0,
      );

      // Tekan lama kartu Espresso lalu tunggu 500 ms (melewati durasi fade 400 ms)
      await tester.longPress(finderEspresso);
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        tester.widget<AnimatedOpacity>(finderAnimatedOpacity).opacity,
        0.4,
      );

      final int jumlahHabisAkhir = tester.widgetList(find.text('Habis')).length;
      expect(jumlahHabisAkhir, jumlahHabisAwal + 1);
    },
  );

  testWidgets(
    '3. Tap kartu membuka DetailPage setelah pump bertahap melewati 600 ms',
    (WidgetTester tester) async {
      _ukuranPonsel(tester);
      await tester.pumpWidget(const KatalogMenuApp());
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Espresso'));
      // Pump bertahap hingga lebih dari 600 ms (tanpa pumpAndSettle)
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(DetailPage), findsOneWidget);
    },
  );

  testWidgets(
    '4. Pencarian memfilter daftar menu',
    (WidgetTester tester) async {
      _ukuranPonsel(tester);
      await tester.pumpWidget(const KatalogMenuApp());
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), 'nasi');
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Nasi Goreng'), findsOneWidget);
      expect(find.text('Espresso'), findsNothing);
    },
  );

  testWidgets(
    '5. Menu yang diberi hati muncul di halaman Favorit lewat bottom navigation',
    (WidgetTester tester) async {
      _ukuranPonsel(tester);
      await tester.pumpWidget(const KatalogMenuApp());
      await tester.pump(const Duration(milliseconds: 100));

      final Finder espressoDiFavorit = find.descendant(
        of: find.byType(FavoritPage),
        matching: find.text('Espresso'),
      );
      expect(espressoDiFavorit, findsNothing);

      await tester.tap(find.byKey(const ValueKey('tombol-favorit-menu-1')));
      await tester.pump();

      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Favorit'),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));

      expect(espressoDiFavorit, findsOneWidget);
    },
  );
}
