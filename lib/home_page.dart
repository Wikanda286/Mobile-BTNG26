import 'package:flutter/material.dart';
import 'package:movieapp/detail_page.dart';
import 'package:movieapp/models/movie.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final List<Movie> dummyMovies = [
    Movie(
      id: 1,
      title: 'Doctor Strange in the Multiverse of Madness',
      posterUrl: 'movie.png',
      backdropUrl: 'backdrop_doctor_strange.jpg',
      rating: 6.9,
      releaseYear: 2022,
      durationMinutes: 126,
      genre: ['Action', 'Adventure', 'Fantasy'],
      synopsis:
          'Melanjutkan kejadian di Spider-Man: No Way Home, Doctor Strange tanpa sengaja membuka gerbang multiverse yang membawa ancaman baru. Ia harus bekerja sama dengan Wong dan Scarlet Witch untuk menghadapi bahaya dari alam semesta lain.',
      cast: [
        Cast(id: 1, name: 'Benedict Cumberbatch', character: 'Dr. Stephen Strange', avatarUrl: 'benedict.jpg'),
        Cast(id: 2, name: 'Elizabeth Olsen', character: 'Wanda Maximoff / Scarlet Witch', avatarUrl: 'elizabeth.jpg'),
      ],
      reviews: [
        Review(
            id: 1,
            author: 'Budi Santoso',
            avatarUrl: 'user1.png',
            rating: 7.0,
            content: 'Visual efeknya sangat luar biasa dan sedikit bernuansa horor!',
            createdAt: '2022-05-10'),
      ],
    ),
    Movie(
      id: 2,
      title: 'Chainsaw Man',
      posterUrl: 'movie1.png',
      backdropUrl: 'backdrop_chainsaw_man.jpg',
      rating: 8.5,
      releaseYear: 2022,
      durationMinutes: 24,
      genre: ['Anime', 'Action', 'Horror'],
      synopsis:
          'Denji adalah remaja yang hidup dalam kemiskinan dan harus melunasi utang ayahnya dengan bekerja sebagai Pemburu Iblis. Setelah dikhianati dan dibunuh, ia bergabung dengan iblis peliharaannya, Pochita, dan bangkit kembali sebagai Chainsaw Man.',
      cast: [
        Cast(id: 3, name: 'Kikunosuke Toya', character: 'Denji', avatarUrl: 'toya.jpg'),
        Cast(id: 4, name: 'Tomori Kusunoki', character: 'Makima', avatarUrl: 'tomori.jpg'),
      ],
      reviews: [
        Review(
            id: 2,
            author: 'Andi M',
            avatarUrl: 'user2.png',
            rating: 9.0,
            content: 'Adaptasi anime yang sangat bagus dari manganya, animasinya mulus!',
            createdAt: '2022-11-20'),
      ],
    ),
    Movie(
      id: 3,
      title: 'Spider-Man: No Way Home',
      posterUrl: 'movie2.png',
      backdropUrl: 'backdrop_spiderman.jpg',
      rating: 8.2,
      releaseYear: 2021,
      durationMinutes: 148,
      genre: ['Action', 'Adventure', 'Sci-Fi'],
      synopsis:
          'Identitas Spider-Man kini terungkap. Peter Parker meminta bantuan Doctor Strange untuk membuat dunia melupakan siapa dirinya, namun mantra yang gagal justru menarik para musuh dari semesta lain.',
      cast: [
        Cast(id: 5, name: 'Tom Holland', character: 'Peter Parker / Spider-Man', avatarUrl: 'tomh.jpg'),
        Cast(id: 6, name: 'Zendaya', character: 'MJ', avatarUrl: 'zendaya.jpg'),
      ],
      reviews: [
        Review(
            id: 3,
            author: 'Rina Wati',
            avatarUrl: 'user3.png',
            rating: 8.5,
            content: 'Penuh dengan nostalgia yang memuaskan untuk para penggemar Spider-Man.',
            createdAt: '2021-12-18'),
      ],
    ),
    Movie(
      id: 4,
      title: 'Fantastic Beasts: The Secrets of Dumbledore',
      posterUrl: 'movie3.png',
      backdropUrl: 'backdrop_fantastic_beasts.jpg',
      rating: 6.2,
      releaseYear: 2022,
      durationMinutes: 142,
      genre: ['Fantasy', 'Adventure'],
      synopsis:
          'Profesor Albus Dumbledore mengetahui bahwa penyihir gelap yang kuat, Gellert Grindelwald, bergerak untuk menguasai dunia sihir. Ia mempercayakan Magizoologist Newt Scamander untuk memimpin tim menghentikannya.',
      cast: [
        Cast(id: 7, name: 'Jude Law', character: 'Albus Dumbledore', avatarUrl: 'jude.jpg'),
        Cast(id: 8, name: 'Eddie Redmayne', character: 'Newt Scamander', avatarUrl: 'eddie.jpg'),
      ],
      reviews: [
        Review(
            id: 4,
            author: 'Faisal',
            avatarUrl: 'user4.png',
            rating: 6.0,
            content: 'Dunia sihirnya tetap mempesona, tapi alur ceritanya terasa sedikit lambat.',
            createdAt: '2022-04-15'),
      ],
    ),
    Movie(
      id: 5,
      title: 'Attack on Titan',
      posterUrl: 'movie4.png',
      backdropUrl: 'backdrop_aot.jpg',
      rating: 9.0,
      releaseYear: 2013,
      durationMinutes: 24,
      genre: ['Anime', 'Action', 'Drama'],
      synopsis:
          'Umat manusia terpaksa berlindung di balik tembok raksasa untuk menghindari para Titan yang memangsa manusia. Eren Yeager bersumpah untuk menghabisi seluruh Titan setelah kampung halamannya dihancurkan.',
      cast: [
        Cast(id: 9, name: 'Yuki Kaji', character: 'Eren Yeager', avatarUrl: 'kaji.jpg'),
        Cast(id: 10, name: 'Yui Ishikawa', character: 'Mikasa Ackerman', avatarUrl: 'yui.jpg'),
      ],
      reviews: [
        Review(
            id: 5,
            author: 'Dian',
            avatarUrl: 'user5.png',
            rating: 9.5,
            content: 'Masterpiece sejati! Plot twist-nya membuat saya merinding.',
            createdAt: '2021-01-10'),
      ],
    ),
    Movie(
      id: 6,
      title: 'Avengers: Endgame',
      posterUrl: 'movie5.png',
      backdropUrl: 'backdrop_endgame.jpg',
      rating: 8.4,
      releaseYear: 2019,
      durationMinutes: 181,
      genre: ['Action', 'Adventure', 'Sci-Fi'],
      synopsis:
          'Setelah peristiwa dahsyat di Infinity War yang menghancurkan separuh populasi semesta, para Avengers yang tersisa harus berkumpul sekali lagi untuk membalikkan tindakan Thanos dan mengembalikan keseimbangan.',
      cast: [
        Cast(id: 11, name: 'Robert Downey Jr.', character: 'Tony Stark / Iron Man', avatarUrl: 'rdj.jpg'),
        Cast(id: 12, name: 'Chris Evans', character: 'Steve Rogers / Captain America', avatarUrl: 'chrise.jpg'),
      ],
      reviews: [
        Review(
            id: 6,
            author: 'Kevin',
            avatarUrl: 'user6.png',
            rating: 10.0,
            content: 'Penutup yang sangat sempurna untuk Infinity Saga.',
            createdAt: '2019-04-28'),
      ],
    ),
    Movie(
      id: 7,
      title: 'Bleach',
      posterUrl: 'movie6.png',
      backdropUrl: 'backdrop_bleach.jpg',
      rating: 8.1,
      releaseYear: 2004,
      durationMinutes: 24,
      genre: ['Anime', 'Action', 'Fantasy'],
      synopsis:
          'Ichigo Kurosaki, seorang remaja dengan kemampuan melihat roh, mendapatkan kekuatan Soul Reaper dari Rukia Kuchiki. Ia kini bertugas melindungi manusia dari roh jahat bernama Hollow.',
      cast: [
        Cast(id: 13, name: 'Masakazu Morita', character: 'Ichigo Kurosaki', avatarUrl: 'morita.jpg'),
        Cast(id: 14, name: 'Fumiko Orikasa', character: 'Rukia Kuchiki', avatarUrl: 'fumiko.jpg'),
      ],
      reviews: [
        Review(
            id: 7,
            author: 'Rizky',
            avatarUrl: 'user7.png',
            rating: 8.0,
            content: 'Pertarungan pedangnya sangat ikonik dan keren!',
            createdAt: '2010-08-14'),
      ],
    ),
    Movie(
      id: 8,
      title: 'Sonic the Hedgehog 2',
      posterUrl: 'movie7.png',
      backdropUrl: 'backdrop_sonic2.jpg',
      rating: 6.5,
      releaseYear: 2022,
      durationMinutes: 122,
      genre: ['Action', 'Adventure', 'Comedy'],
      synopsis:
          'Setelah menetap di Green Hills, Sonic sangat ingin membuktikan bahwa dirinya memiliki apa yang dibutuhkan untuk menjadi pahlawan sejati. Ujiannya datang saat Dr. Robotnik kembali bersama mitra barunya, Knuckles.',
      cast: [
        Cast(id: 15, name: 'Ben Schwartz', character: 'Sonic (Voice)', avatarUrl: 'ben.jpg'),
        Cast(id: 16, name: 'Jim Carrey', character: 'Dr. Ivo Robotnik', avatarUrl: 'jim.jpg'),
      ],
      reviews: [
        Review(
            id: 8,
            author: 'Sinta',
            avatarUrl: 'user8.png',
            rating: 7.0,
            content: 'Film yang sangat menghibur untuk ditonton bersama keluarga, Tails dan Knuckles keren!',
            createdAt: '2022-04-10'),
      ],
    ),
  ];

  int _selectedCategoryIndex = 0;

  String _getAssetPath(String raw) {
    if (raw.isEmpty) return 'assets/images/movie.png';
    if (raw.startsWith('assets/')) return raw;
    return 'assets/images/$raw';
  }

  void _navigateToDetail(BuildContext context, Movie movie) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(movie: movie),
        ),
      );
    } catch (e) {
      debugPrint("Gagal navigasi ke detail page: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final popularMovies = dummyMovies.take(2).toList();
    final nowPlayingMovies = dummyMovies.skip(2).take(3).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF112028),
        elevation: 0,
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
              children: popularMovies.map((movie) {
                return GestureDetector(
                  onTap: () => _navigateToDetail(context, movie),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _getAssetPath(movie.posterUrl),
                        width: 140,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 140,
                          height: 200,
                          color: Colors.grey[800],
                          child: const Icon(Icons.movie, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryTab("Now Playing", 0),
                const SizedBox(width: 16),
                _buildCategoryTab("Upcoming", 1),
                const SizedBox(width: 16),
                _buildCategoryTab("Top Rated", 2),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: nowPlayingMovies.map((movie) {
                return GestureDetector(
                  onTap: () => _navigateToDetail(context, movie),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _getAssetPath(movie.posterUrl),
                        width: 96,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey[800],
                          child: const Icon(Icons.movie, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title, int index) {
    final bool isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: isSelected ? 80 : 0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
