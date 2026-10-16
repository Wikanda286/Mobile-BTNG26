class Cast {
  final int id;
  final String name;
  final String character;
  final String avatarUrl;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.avatarUrl,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      character: json['character']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
    );
  }
}
