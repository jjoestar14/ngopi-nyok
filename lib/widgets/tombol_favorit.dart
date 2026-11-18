import 'package:flutter/material.dart';
import '../konstanta.dart';

/// Tombol hati. Hanya tombol ini yang dibangun ulang saat status favorit berubah.
class TombolFavorit extends StatelessWidget {
  final ValueNotifier<bool> favorit;

  const TombolFavorit({super.key, required this.favorit});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: favorit,
      builder: (context, aktif, _) => IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: () => favorit.value = !aktif,
        icon: Icon(
          aktif ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: aktif ? kWarnaFavorit : kWarnaTeksSamar,
          size: 24,
        ),
      ),
    );
  }
}
