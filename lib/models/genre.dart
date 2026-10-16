class Genre {
  final String slug;
  final String nama;
  final int jumlah;

  Genre({
    required this.slug,
    required this.nama,
    required this.jumlah,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      slug: json['slug']?.toString() ?? '',
      nama: json['nama']?.toString() ?? '',
      jumlah: json['jumlah'] is int
          ? json['jumlah'] as int
          : int.tryParse(json['jumlah']?.toString() ?? '0') ?? 0,
    );
  }
}
