import 'package:flutter/material.dart';
import 'package:movieapp/core/di/injection.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/services/movie_service.dart';
import 'package:movieapp/services/watchlist_service.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/typography.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final MovieService _movieService = getIt<MovieService>();
  final WatchlistService _watchlistService = getIt<WatchlistService>();

  late Movie _movie;
  bool _isLoadingDetail = false;
  String? _detailErrorMessage;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    setState(() {
      _isLoadingDetail = true;
      _detailErrorMessage = null;
    });

    try {
      final detail = await _movieService.getMovieDetail(_movie.id);
      if (mounted) {
        setState(() {
          _movie = detail;
          _isLoadingDetail = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingDetail = false;
          _detailErrorMessage = e.toString().replaceAll("Exception: ", "");
        });
      }
    }
  }

  Widget _buildNetworkOrAssetImage(
    String rawUrl, {
    BoxFit fit = BoxFit.cover,
    Widget? errorWidget,
  }) {
    if (rawUrl.isEmpty) {
      return errorWidget ??
          Container(
            color: buttonGrey,
            child: const Center(
              child: Icon(Icons.movie, color: white, size: 40),
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
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            Container(
              color: buttonGrey,
              child: const Center(
                child: Icon(Icons.image_not_supported, color: white, size: 36),
              ),
            ),
      );
    }

    final assetPath = rawUrl.startsWith('assets/') ? rawUrl : 'assets/images/$rawUrl';
    return Image.asset(
      assetPath,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Container(
            color: buttonGrey,
            child: const Center(
              child: Icon(Icons.movie, color: white, size: 40),
            ),
          ),
    );
  }

  ImageProvider? _getAvatarProvider(String rawUrl) {
    if (rawUrl.isEmpty) return null;
    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      return NetworkImage(rawUrl);
    }
    final assetPath = rawUrl.startsWith('assets/') ? rawUrl : 'assets/images/$rawUrl';
    return AssetImage(assetPath);
  }

  @override
  Widget build(BuildContext context) {
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
          ListenableBuilder(
            listenable: _watchlistService,
            builder: (context, _) {
              final isSaved = _watchlistService.isInWatchlist(_movie.id);
              return IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: isSaved ? blue : white,
                ),
                onPressed: () {
                  _watchlistService.toggleWatchlist(_movie);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isSaved
                            ? '${_movie.title} dihapus dari Watch list'
                            : '${_movie.title} ditambahkan ke Watch list',
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: buttonGrey,
                    ),
                  );
                },
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
                  _buildNetworkOrAssetImage(_movie.backdropUrl),
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
                            _movie.rating.toString(),
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
                              child: _buildNetworkOrAssetImage(_movie.posterUrl),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _movie.title,
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
                                    "${_movie.releaseYear}",
                                    style: xsRegular.copyWith(color: grey),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text("|", style: TextStyle(color: grey)),
                                  ),
                                  const Icon(Icons.access_time, color: grey, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    _movie.getFormattedDuration(),
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
                      children: _movie.genre.map((genreName) {
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
                    _buildActiveTabContent(),
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

  Widget _buildActiveTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildAboutTab();
      case 1:
        return _buildCastTab();
      case 2:
        return _buildReviewsTab();
      default:
        return _buildAboutTab();
    }
  }

  Widget _buildAboutTab() {
    return Text(
      _movie.getSafeSynopsis(),
      style: sRegular.copyWith(
        color: white.withValues(alpha: 0.85),
        height: 1.6,
      ),
    );
  }

  Widget _buildCastTab() {
    if (_isLoadingDetail && _movie.cast.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(color: blue),
        ),
      );
    }

    if (_detailErrorMessage != null && _movie.cast.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                "Gagal memuat pemeran: $_detailErrorMessage",
                style: xsRegular.copyWith(color: grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _fetchMovieDetail,
                icon: const Icon(Icons.refresh, color: blue, size: 16),
                label: const Text("Coba Lagi", style: TextStyle(color: blue)),
              ),
            ],
          ),
        ),
      );
    }

    if (_movie.cast.isEmpty) {
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
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _movie.cast.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final cast = _movie.cast[index];
          final avatarProvider = _getAvatarProvider(cast.avatarUrl);

          return SizedBox(
            width: 80,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: buttonGrey.withValues(alpha: 0.6),
                  backgroundImage: avatarProvider,
                  onBackgroundImageError: avatarProvider != null ? (error, stackTrace) {} : null,
                  child: avatarProvider == null
                      ? const Icon(Icons.person, color: white, size: 28)
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  cast.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: xsBold.copyWith(color: white),
                ),
                Text(
                  cast.character,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: xxsRegular.copyWith(color: grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewsTab() {
    if (_isLoadingDetail && _movie.reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(color: blue),
        ),
      );
    }

    if (_detailErrorMessage != null && _movie.reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                "Gagal memuat ulasan: $_detailErrorMessage",
                style: xsRegular.copyWith(color: grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _fetchMovieDetail,
                icon: const Icon(Icons.refresh, color: blue, size: 16),
                label: const Text("Coba Lagi", style: TextStyle(color: blue)),
              ),
            ],
          ),
        ),
      );
    }

    if (_movie.reviews.isEmpty) {
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
      children: _movie.reviews.map((review) {
        final avatarProvider = _getAvatarProvider(review.avatarUrl);

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
                  backgroundImage: avatarProvider,
                  onBackgroundImageError: avatarProvider != null ? (error, stackTrace) {} : null,
                  child: avatarProvider == null
                      ? const Icon(Icons.person, color: blue, size: 20)
                      : null,
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
