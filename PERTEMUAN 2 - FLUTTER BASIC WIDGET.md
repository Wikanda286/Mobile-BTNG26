# 🎬 Movie App - Flutter Project Documentation

Dokumentasi project **Movie App** ini dibuat agar memudahkan untuk dipelajari, dicoba, dan dicontoh oleh teman-teman.

---

## 📌 Deskripsi Project
Aplikasi Flutter **Movie App** adalah aplikasi tampilan daftar film populer, sedang tayang (*Now Playing*), *Upcoming*, dan *Top Rated*.

---

## 📁 Struktur Folder Project

```text
movieapp/
├── assets/
│   └── images/          # Tempat menyimpan gambar poster film (movie1.png, movie2.png, dll)
│   └── fonts/           # Tempat menyimpan font Poppins
├── lib/
│   ├── main.dart        # Entry point aplikasi Flutter & konfigurasi tema
│   └── home_page.dart   # Halaman utama aplikasi (UI Tampilan Film)
└── pubspec.yaml         # Dependensi dan konfigurasi aset gambar/font
```

---

## ⚙️ Config `pubspec.yaml` (Asset Setup)

Pastikan bagian `assets` di `pubspec.yaml` sudah terdaftar seperti berikut:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
```

---

## 💻 Source Code

### 1. `lib/main.dart`
File utama untuk menjalankan aplikasi Flutter dan mengatur tema dasar (Background Color: `#112028` & Font Family: `Poppins`).

```dart
import 'package:flutter/material.dart';
import 'package:movieapp/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF112028),
      ),
      home: homePage(),
    );
  }
}
```

---

### 2. `lib/home_page.dart`
File UI untuk menampilkan halaman utama dengan AppBar, Kategori Film (*Popular, Now Playing, Upcoming, Top Rated*), serta Grid/Row Poster Film.

```dart
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF112028),
        title: const Text(
          "What do you want to watch?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Popular",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Image(
                  image: AssetImage("assets/images/movie1.png"),
                  width: 160,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Image(
                  image: AssetImage("assets/images/movie2.png"),
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Now Playing",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 4,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Upcoming",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Top Rated",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/movie.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie3.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie4.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/movie4.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie5.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Image(
                      image: AssetImage("assets/images/movie6.png"),
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🚀 Cara Menjalankan Project (Untuk Teman-teman)

1. **Clone / Download** kode ini.
2. Buka terminal di folder project dan jalankan:
   ```bash
   flutter pub get
   ```
3. Pastikan gambar diletakkan di folder `assets/images/` (`movie1.png`, `movie2.png`, `movie3.png`, `movie4.png`, `movie5.png`, `movie6.png`, `movie.png`).
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```
