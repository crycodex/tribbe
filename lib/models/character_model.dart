class CharacterModel {
  final String genero;
  final String tonoPiel;
  final String? avatarUrl;

  const CharacterModel({
    required this.genero,
    required this.tonoPiel,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
    'genero': genero,
    'tonoPiel': tonoPiel,
    'avatarUrl': avatarUrl,
  };

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    genero: json['genero'] ?? '',
    tonoPiel: json['tonoPiel'] ?? '',
    avatarUrl: json['avatarUrl'],
  );

  CharacterModel copyWith({
    String? genero,
    String? tonoPiel,
    String? avatarUrl,
  }) => CharacterModel(
    genero: genero ?? this.genero,
    tonoPiel: tonoPiel ?? this.tonoPiel,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );
}
