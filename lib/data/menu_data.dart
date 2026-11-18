import 'package:flutter/material.dart';
import '../models/menu_item.dart';

/// Kategori yang tampil sebagai chip filter di KatalogPage.
const List<String> kDaftarKategori = ['Kopi', 'Non-Kopi', 'Makanan', 'Camilan'];

/// Membuat daftar 10 menu kafe (2 menu habis di awal untuk demo efek opacity).
List<MenuItem> buatDaftarMenu() {
  return [
    MenuItem(
      id: 1,
      nama: 'Espresso',
      kategori: 'Kopi',
      deskripsi:
          'Kopi pekat dengan crema tebal, diseduh dari biji pilihan untuk rasa yang bold dan beraroma.',
      harga: 18000,
      ikon: Icons.coffee,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 2,
      nama: 'Cappuccino',
      kategori: 'Kopi',
      deskripsi:
          'Perpaduan espresso, susu panas, dan busa susu tebal yang lembut di setiap tegukan.',
      harga: 25000,
      ikon: Icons.local_cafe,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 3,
      nama: 'Caffe Latte',
      kategori: 'Kopi',
      deskripsi:
          'Espresso dengan susu steamed yang creamy, rasanya ringan dan mudah dinikmati.',
      harga: 27000,
      ikon: Icons.free_breakfast,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 4,
      nama: 'Teh Tarik',
      kategori: 'Non-Kopi',
      deskripsi:
          'Teh hitam pekat dengan susu yang ditarik hingga berbusa, manis dan hangat.',
      harga: 15000,
      ikon: Icons.emoji_food_beverage,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 5,
      nama: 'Es Kopi Susu',
      kategori: 'Kopi',
      deskripsi:
          'Kopi susu dingin dengan gula aren, segar dan manisnya pas untuk siang hari.',
      harga: 22000,
      ikon: Icons.local_drink,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 6,
      nama: 'Croissant',
      kategori: 'Camilan',
      deskripsi:
          'Pastry berlapis dengan kulit renyah dan bagian dalam lembut beraroma mentega.',
      harga: 20000,
      ikon: Icons.bakery_dining,
      tersediaAwal: false,
    ),
    MenuItem(
      id: 7,
      nama: 'Choco Cookies',
      kategori: 'Camilan',
      deskripsi:
          'Kue renyah dengan potongan cokelat leleh, teman ngopi yang pas.',
      harga: 14000,
      ikon: Icons.cookie,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 8,
      nama: 'Nasi Goreng',
      kategori: 'Makanan',
      deskripsi:
          'Nasi goreng bumbu khas dengan telur dan kerupuk, pengisi perut sambil ngopi.',
      harga: 30000,
      ikon: Icons.rice_bowl,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 9,
      nama: 'Mie Ayam',
      kategori: 'Makanan',
      deskripsi:
          'Mie kenyal dengan topping ayam berbumbu dan kuah kaldu yang gurih.',
      harga: 22000,
      ikon: Icons.ramen_dining,
      tersediaAwal: true,
    ),
    MenuItem(
      id: 10,
      nama: 'Cheesecake',
      kategori: 'Camilan',
      deskripsi:
          'Kue keju lembut dengan dasar biskuit renyah, manis dan creamy.',
      harga: 32000,
      ikon: Icons.cake,
      tersediaAwal: false,
    ),
  ];
}
