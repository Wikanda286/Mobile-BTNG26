import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/typography.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedTabIndex = 0;

  String _getAssetPath(String raw) {
    if (raw.isEmpty) return 'assets/images/movie.png';
    if (raw.startsWith('assets/')) return raw;
    return 'assets/images/$raw';
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Detail",
          style: smBold.copyWith(color: white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Film disimpan ke bookmark'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _getAssetPath(movie.backdropUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: buttonGrey,
                      child: const Center(
                        child: Icon(Icons.movie, color: white, size: 50),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          background.withValues(alpha: 0.6),
                          background,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252836).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: sBold.copyWith(color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SizedBox(
                            width: screenWidth > 600 ? 140 : 100,
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: Image.asset(
                                _getAssetPath(movie.posterUrl),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: buttonGrey,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported, color: white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: mBold.copyWith(color: white),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined, color: grey, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${movie.releaseYear}",
                                    style: xsRegular.copyWith(color: grey),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text("|", style: TextStyle(color: grey)),
                                  ),
                                  const Icon(Icons.access_time, color: grey, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.getFormattedDuration(),
                                    style: xsRegular.copyWith(color: grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genre.map((genreName) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: buttonGrey.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: grey.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            genreName,
                            style: xsMedium.copyWith(color: white),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildTabItem("About Movie", 0),
                        const SizedBox(width: 20),
                        _buildTabItem("Cast", 1),
                        const SizedBox(width: 20),
                        _buildTabItem("Reviews", 2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildActiveTabContent(movie),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
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
            height: 3,
            width: isSelected ? 36 : 0,
            decoration: BoxDecoration(
              color: isSelected ? blue : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTabContent(Movie movie) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildAboutTab(movie);
      case 1:
        return _buildCastTab(movie);
      case 2:
        return _buildReviewsTab(movie);
      default:
        return _buildAboutTab(movie);
    }
  }

  Widget _buildAboutTab(Movie movie) {
    return Text(
      movie.getSafeSynopsis(),
      style: sRegular.copyWith(
        color: white.withValues(alpha: 0.85),
        height: 1.6,
      ),
    );
  }

  Widget _buildCastTab(Movie movie) {
    if (movie.cast.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            "Belum ada data pemeran untuk film ini.",
            style: sRegular.copyWith(color: grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movie.cast.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final cast = movie.cast[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: buttonGrey.withValues(alpha: 0.6),
                child: const Icon(Icons.person, color: white, size: 28),
              ),
              const SizedBox(height: 6),
              Text(
                cast.name,
                style: xsBold.copyWith(color: white),
              ),
              Text(
                cast.character,
                style: xxsRegular.copyWith(color: grey),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReviewsTab(Movie movie) {
    if (movie.reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            "Belum ada ulasan untuk film ini.",
            style: sRegular.copyWith(color: grey),
          ),
        ),
      );
    }

    return Column(
      children: movie.reviews.map((review) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: buttonGrey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: white.withValues(alpha: 0.05)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: blue.withValues(alpha: 0.2),
                  child: const Icon(Icons.person, color: blue, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review.author,
                            style: sBold.copyWith(color: white),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                review.rating.toString(),
                                style: xsBold.copyWith(color: Colors.amber),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        review.content,
                        style: xsRegular.copyWith(
                          color: white.withValues(alpha: 0.8),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
