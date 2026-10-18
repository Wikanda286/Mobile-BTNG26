import 'package:flutter/material.dart';
import 'package:movieapp/detail_page.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/typography.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MovieListItem({
    super.key,
    required this.movie,
    this.onTap,
    this.trailing,
  });

  Widget _buildPosterImage(String rawUrl) {
    if (rawUrl.isEmpty) {
      return Container(
        color: buttonGrey,
        child: const Center(
          child: Icon(Icons.movie, color: white, size: 32),
        ),
      );
    }

    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      return Image.network(
        rawUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: buttonGrey,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: blue),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: buttonGrey,
          child: const Center(
            child: Icon(Icons.broken_image, color: white, size: 28),
          ),
        ),
      );
    }

    final assetPath = rawUrl.startsWith('assets/') ? rawUrl : 'assets/images/$rawUrl';
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: buttonGrey,
        child: const Center(
          child: Icon(Icons.movie, color: white, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(movie: movie),
              ),
            );
          },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 95,
              height: 125,
              child: _buildPosterImage(movie.posterUrl),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: smBold.copyWith(
                    color: white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_rounded,
                      color: Color(0xFFFF8700),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toString(),
                      style: sBold.copyWith(
                        color: const Color(0xFFFF8700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.confirmation_number_outlined,
                      color: white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.getPrimaryGenre(),
                      style: xsRegular.copyWith(color: white),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.releaseYear.toString(),
                      style: xsRegular.copyWith(color: white),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: white,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.getFormattedDuration(),
                      style: xsRegular.copyWith(color: white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
