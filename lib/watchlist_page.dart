import 'package:flutter/material.dart';
import 'package:movieapp/core/di/injection.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/watchlist_service.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/movie_list_item.dart';
import 'package:movieapp/ui/typography.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final WatchlistService _watchlistService = getIt<WatchlistService>();


  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E3541),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF02A7FF).withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.bookmark_border_rounded,
                    color: blue,
                    size: 44,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "There Is No Movie Yet!",
                textAlign: TextAlign.center,
                style: smBold.copyWith(
                  color: white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Find your movie by Type title,\ncategories, years, etc",
                textAlign: TextAlign.center,
                style: sRegular.copyWith(
                  color: grey,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: background,
        elevation: 0,
        title: Text(
          "Watch list",
          style: smBold.copyWith(color: white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _watchlistService,
          builder: (context, _) {
            final List<Movie> movies = _watchlistService.watchlist;

            if (movies.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              itemCount: movies.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Dismissible(
                  key: ValueKey("watchlist_${movie.id}"),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete_outline, color: white, size: 28),
                  ),
                  onDismissed: (_) {
                    _watchlistService.removeFromWatchlist(movie.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${movie.title} dihapus dari Watch list"),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: buttonGrey,
                      ),
                    );
                  },
                  child: MovieListItem(movie: movie),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
