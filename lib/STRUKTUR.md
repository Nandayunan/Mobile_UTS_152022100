# Struktur Proyek UTS Mobile App

## Organisasi Folder

Proyek ini telah diorganisir dengan baik mengikuti best practices Flutter:

### 📁 `/lib`
```
lib/
├── main.dart                    # Entry point aplikasi (minimal dan clean)
├── theme/
│   ├── app_colors.dart         # Definisi warna aplikasi
│   └── app_theme.dart          # Konfigurasi tema Material Design
├── screens/
│   ├── splash_screen.dart      # Layar splash 5 detik
│   ├── main_shell.dart         # Main shell dengan navigation bar
│   ├── biodata_page.dart       # Form biodata statis
│   ├── kontak_page.dart        # Daftar kontak dengan detail
│   ├── kalkulator_page.dart    # Kalkulator sederhana
│   ├── cuaca_page.dart         # Tampilan data cuaca statis
│   └── berita_page.dart        # Daftar berita statis
├── widgets/
│   ├── gold_pill.dart          # Widget badge/pill dengan aksen gold
│   ├── section_header.dart     # Widget header section
│   └── contact_detail_tile.dart # Widget detail kontak dalam bottom sheet
└── models/
    ├── contact.dart            # Model data Contact
    └── news.dart               # Model data News

```

## Penjelasan Struktur

### 🎨 `theme/`
- **app_colors.dart**: Menyimpan semua konstanta warna (dark mode + gold accent)
- **app_theme.dart**: Konfigurasi tema global untuk MaterialApp

### 🖼️ `screens/`
Setiap halaman adalah file terpisah:
- **splash_screen.dart**: Tampil 5 detik dengan animasi shimmer
- **main_shell.dart**: Navigator dengan 5 tab di bottom
- Halaman untuk setiap tab (biodata, kontak, kalkulator, cuaca, berita)

### 🧩 `widgets/`
Komponen UI yang reusable dan terpisah dari logic:
- **gold_pill.dart**: Badge dengan gradient gold
- **section_header.dart**: Header section dengan title + subtitle
- **contact_detail_tile.dart**: Tile untuk detail kontak

### 📊 `models/`
Model data (Plain Dart Classes):
- **contact.dart**: Kelas Contact dengan data dan logika default
- **news.dart**: Kelas News untuk data berita

## Keuntungan Struktur Ini

✅ **Mudah dimaintain** - Setiap komponen punya tanggung jawab sendiri
✅ **Reusable** - Widget dapat digunakan di berbagai tempat
✅ **Scalable** - Mudah menambah fitur baru
✅ **Clean Code** - main.dart hanya 20 baris!
✅ **Testable** - Setiap komponen bisa ditest terpisah

## Cara Menambah Fitur

1. **Halaman Baru**: Tambah file di `screens/`
2. **Widget Baru**: Tambah file di `widgets/`
3. **Model Baru**: Tambah file di `models/`
4. **Warna/Tema Baru**: Update `theme/app_colors.dart` atau `theme/app_theme.dart`
