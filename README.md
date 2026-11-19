## Pengujian Performa Menggunakan Flutter DevTools

### 1. Tujuan Pengujian

Pengujian ini dilakukan untuk membandingkan performa aplikasi Ngopi Nyok sebelum dan sesudah optimasi kode. Pengukuran dilakukan menggunakan Flutter DevTools dalam Profile Mode.

### 2. Perangkat dan Metode Pengujian

- Perangkat: Xiaomi M2101K7BNY
- Sistem operasi: Android 13 (API 33)
- Mode pengujian: Profile Mode
- Tools: Flutter DevTools – Performance
- Metode: Membandingkan dua versi aplikasi melalui branch Git `sebelum` dan `main`.

Pengujian dilakukan menggunakan lima skenario:
1. Idle (aplikasi tanpa interaksi).
2. Long Press pada kartu katalog.
3. Membuka halaman detail.
4. Scrolling daftar katalog.
5. Mengetik pada kolom pencarian.

### 3. Hasil Pengukuran

| Skenario | FPS Sebelum | FPS Sesudah | Jank Sebelum | Jank Sesudah |
|---|---:|---:|---:|---:|
| Idle | 59 | 60 | 3 | 0 |
| Long Press | 60 | 60 | 5 | 1 |
| Membuka Detail | 59 | 60 | 28 | 4 |
| Scroll | 59 | 60 | 54 | 2 |
| Pencarian | 59 | 60 | 10 | 1 |
| **Total Jank** | - | - | **100** | **8** |

*Catatan: jumlah jank merupakan angka yang tercatat selama masing-masing sesi pengujian. Durasi dan jumlah frame setiap sesi belum dinormalisasi.*

### 4. Analisis Hasil

Berdasarkan pengujian, versi sesudah optimasi menunjukkan hasil yang lebih baik pada seluruh skenario.

Pada pengujian Idle, jumlah jank berkurang dari 3 menjadi 0. Pada Long Press, jumlah jank berkurang dari 5 menjadi 1 setelah cakupan pembaruan status menu dibuat lebih terarah.

Pengujian Membuka Detail menunjukkan penurunan dari 28 menjadi 4 jank. Sementara itu, pengujian Scroll menunjukkan penurunan paling besar, yaitu dari 54 menjadi 2 jank.

Pada pengujian Pencarian, jumlah jank juga berkurang dari 10 menjadi 1 setelah pembaruan filter dioptimasi.

Rata-rata FPS pada versi sebelum optimasi berada di kisaran 59–60 FPS, sedangkan versi sesudah optimasi mencapai 60 FPS pada seluruh skenario.

Secara agregat, jumlah jank yang tercatat turun dari 100 menjadi 8. Namun, angka tersebut merupakan perbandingan jumlah mentah dan belum memperhitungkan normalisasi durasi atau jumlah frame.

### 5. Kesimpulan

Berdasarkan hasil pengukuran menggunakan Flutter DevTools, optimasi kode memberikan hasil yang lebih baik pada lima skenario pengujian aplikasi Ngopi Nyok.

Perubahan pada penggunaan RepaintBoundary, AnimatedBuilder, ListenableBuilder, pengelolaan filter, dan penggunaan const ditujukan untuk mengurangi pekerjaan rendering dan rebuild yang tidak diperlukan.

Hasil pengujian menunjukkan bahwa versi sesudah optimasi memiliki jumlah jank yang lebih rendah serta rata-rata FPS yang lebih stabil.

Dengan demikian, optimasi yang dilakukan menunjukkan dampak positif terhadap performa aplikasi dalam skenario pengujian yang digunakan.

### 6. Versi Pembanding

Repository ini menyediakan dua branch Git:

- `main`: versi aplikasi sesudah optimasi.
- `sebelum`: versi aplikasi sebelum optimasi.