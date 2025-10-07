class InformationModel {
  final String proposito;
  final String metaFitness;
  final List<String> lesiones;
  final String nivelExperiencia;
  final int condicionFisicaActual;

  const InformationModel({
    required this.proposito,
    required this.metaFitness,
    this.lesiones = const [],
    required this.nivelExperiencia,
    this.condicionFisicaActual = 0,
  });

  Map<String, dynamic> toJson() => {
    'proposito': proposito,
    'metaFitness': metaFitness,
    'lesiones': lesiones,
    'nivelExperiencia': nivelExperiencia,
    'condicionFisicaActual': condicionFisicaActual,
  };

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      InformationModel(
        proposito: json['proposito'] ?? '',
        metaFitness: json['metaFitness'] ?? '',
        lesiones: (json['lesiones'] as List?)?.cast<String>() ?? [],
        nivelExperiencia: json['nivelExperiencia'] ?? '',
        condicionFisicaActual: json['condicionFisicaActual'] ?? 0,
      );

  InformationModel copyWith({
    String? proposito,
    String? metaFitness,
    List<String>? lesiones,
    String? nivelExperiencia,
    int? condicionFisicaActual,
  }) => InformationModel(
    proposito: proposito ?? this.proposito,
    metaFitness: metaFitness ?? this.metaFitness,
    lesiones: lesiones ?? this.lesiones,
    nivelExperiencia: nivelExperiencia ?? this.nivelExperiencia,
    condicionFisicaActual: condicionFisicaActual ?? this.condicionFisicaActual,
  );
}
