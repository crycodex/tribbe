import 'package:tribbe/models/units_model.dart';

class PreferencesModel {
  final String tema;
  final UnitsModel unidades;
  final String idioma;

  const PreferencesModel({
    this.tema = 'Día',
    this.unidades = const UnitsModel(),
    this.idioma = 'Español',
  });

  Map<String, dynamic> toJson() => {
    'tema': tema,
    'unidades': unidades.toJson(),
    'idioma': idioma,
  };

  factory PreferencesModel.fromJson(Map<String, dynamic> json) =>
      PreferencesModel(
        tema: json['tema'] ?? 'Día',
        unidades: json['unidades'] != null
            ? UnitsModel.fromJson(json['unidades'])
            : const UnitsModel(),
        idioma: json['idioma'] ?? 'Español',
      );

  PreferencesModel copyWith({
    String? tema,
    UnitsModel? unidades,
    String? idioma,
  }) => PreferencesModel(
    tema: tema ?? this.tema,
    unidades: unidades ?? this.unidades,
    idioma: idioma ?? this.idioma,
  );
}
