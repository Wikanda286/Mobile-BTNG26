import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF112028),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 180,
                  child: Image.asset(
                    _getAssetPath(movie.backdropUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.movie, color: Colors.white, size: 50),
                    ),
                  ),
                ),
                Positioned(
                  top: 135,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252836).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_border, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _getAssetPath(movie.posterUrl),
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 140,
                        color: Colors.grey[700],
                        child: const Icon(Icons.image_not_supported, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 190,
                  left: 140,
                  right: 24,
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 16),
                const SizedBox(width: 6),
                Text(
                  "${movie.releaseYear}",
                  style: const TextStyle(color: Colors.grey, fontFamily: "Poppins", fontSize: 13),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("|", style: TextStyle(color: Colors.grey)),
                ),
                const Icon(Icons.access_time, color: Colors.grey, size: 16),
                const SizedBox(width: 6),
                Text(
                  movie.getFormattedDuration(),
                  style: const TextStyle(color: Colors.grey, fontFamily: "Poppins", fontSize: 13),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("|", style: TextStyle(color: Colors.grey)),
                ),
                const Icon(Icons.confirmation_number_outlined, color: Colors.grey, size: 16),
                const SizedBox(width: 6),
                Text(
                  movie.getPrimaryGenre(),
                  style: const TextStyle(color: Colors.grey, fontFamily: "Poppins", fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _buildTabItem("About Movie", 0),
                const SizedBox(width: 24),
                _buildTabItem("Reviews", 1),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _selectedTabIndex == 0
                ? _buildAboutTab(movie)
                : _buildReviewsTab(movie),
          ),
          const SizedBox(height: 32),
        ],
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
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 4,
            width: index == 0 ? 90 : 60,
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey[600] : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(Movie movie) {
    return Text(
      movie.getSafeSynopsis(),
      style: const TextStyle(
        fontFamily: "Poppins",
        color: Colors.white70,
        fontSize: 14,
        height: 1.6,
      ),
    );
  }

  Widget _buildReviewsTab(Movie movie) {
    if (movie.reviews.isEmpty) {
      return const Text(
        "Belum ada ulasan untuk film ini.",
        style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
      );
    }

    return Column(
      children: movie.reviews.map((review) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.purple.shade300,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review.rating.toString(),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.content,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
