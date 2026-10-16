import 'package:flutter/material.dart';
import 'package:movieapp/core/di/injection.dart';
import 'package:movieapp/detail_page.dart';
import 'package:movieapp/models/genre.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/movie_service.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/typography.dart';

// ignore: camel_case_types
typedef homePage = HomePage;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieService _movieService = getIt<MovieService>();

  List<Movie> _movies = [];
  List<Genre> _genres = [];
  bool _isLoading = true;
  String? _errorMessage;

  int _selectedCategoryIndex = 0;

  List<String> get _genreTabs {
    if (_genres.isEmpty) {
      return ["All", "Action", "Adventure", "Sci-Fi", "Drama"];
    }
    return ["All", ..._genres.take(4).map((g) => g.nama)];
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        _movieService.getMovies(),
        _movieService.getGenres(),
      ]);
      setState(() {
        _movies = results[0] as List<Movie>;
        _genres = results[1] as List<Genre>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll("Exception: ", "");
        _isLoading = false;
      });
    }
  }

  Widget _buildPosterImage(String rawUrl, {BoxFit fit = BoxFit.cover}) {
    if (rawUrl.isEmpty) {
      return Container(
        color: buttonGrey,
        child: const Center(
          child: Icon(Icons.movie, color: white, size: 36),
        ),
      );
    }

    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      return Image.network(
        rawUrl,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: buttonGrey,
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: blue),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: buttonGrey,
          child: const Center(
            child: Icon(Icons.broken_image, color: white, size: 36),
          ),
        ),
      );
    }

    final assetPath = rawUrl.startsWith('assets/') ? rawUrl : 'assets/images/$rawUrl';
    return Image.asset(
      assetPath,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: buttonGrey,
        child: const Center(
          child: Icon(Icons.movie, color: white, size: 36),
        ),
      ),
    );
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

  List<Movie> _getFilteredCategoryMovies() {
    if (_movies.isEmpty) return [];

    final tabs = _genreTabs;
    if (_selectedCategoryIndex < 0 || _selectedCategoryIndex >= tabs.length) {
      return _movies;
    }

    final selectedGenre = tabs[_selectedCategoryIndex];
    if (selectedGenre == "All") {
      return _movies;
    }

    final filtered = _movies.where((m) {
      return m.genre.any((g) => g.toLowerCase() == selectedGenre.toLowerCase());
    }).toList();

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final int crossAxisCount = screenWidth > 900
        ? 5
        : screenWidth > 600
            ? 4
            : screenWidth > 380
                ? 3
                : 2;

    final popularMovies = _movies.where((m) => m.rating >= 8.0).toList();
    final categoryMovies = _getFilteredCategoryMovies();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: background,
        elevation: 0,
        title: Text(
          "What do you want to watch?",
          style: mBold.copyWith(color: white),
        ),
      ),
      body: _buildBody(crossAxisCount, popularMovies, categoryMovies),
    );
  }

  Widget _buildBody(int crossAxisCount, List<Movie> popularMovies, List<Movie> categoryMovies) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: blue),
            const SizedBox(height: 16),
            Text(
              "Memuat film dari server...",
              style: sMedium.copyWith(color: grey),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null && _movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, color: Colors.redAccent, size: 64),
              const SizedBox(height: 16),
              Text(
                "Gagal Memuat Data",
                style: mBold.copyWith(color: white),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: sRegular.copyWith(color: grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _fetchMovies,
                icon: const Icon(Icons.refresh, color: white),
                label: const Text("Coba Lagi", style: TextStyle(color: white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final tabs = _genreTabs;

    return RefreshIndicator(
      color: blue,
      backgroundColor: buttonGrey,
      onRefresh: _fetchMovies,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Popular",
                style: smBold.copyWith(color: white),
              ),
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 64,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: popularMovies.isEmpty
                    ? Center(
                        child: Text("Tidak ada film populer", style: sRegular.copyWith(color: grey)),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularMovies.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final movie = popularMovies[index];
                          return GestureDetector(
                            onTap: () => _navigateToDetail(context, movie),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: _buildPosterImage(movie.posterUrl),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.75),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          movie.rating.toString(),
                                          style: xsBold.copyWith(color: Colors.amber),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  left: 8,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 44,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Poppins",
                                      color: white.withValues(alpha: 0.85),
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 8,
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 28),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index == tabs.length - 1 ? 0 : 20),
                      child: _buildCategoryTab(tabs[index], index),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 18),
              categoryMovies.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          "Belum ada film di kategori ini",
                          style: sRegular.copyWith(color: grey),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryMovies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.58,
                      ),
                      itemBuilder: (context, index) {
                        final movie = categoryMovies[index];
                        return GestureDetector(
                          onTap: () => _navigateToDetail(context, movie),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: _buildPosterImage(movie.posterUrl),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    right: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.75),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber, size: 12),
                                          const SizedBox(width: 2),
                                          Text(
                                            movie.rating.toString(),
                                            style: xxsBold.copyWith(color: Colors.amber),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: xsMedium.copyWith(color: white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 20),
            ],
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: smMedium.copyWith(
              color: isSelected ? white : grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 4,
            width: isSelected ? 32 : 0,
            decoration: BoxDecoration(
              color: isSelected ? blue : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
