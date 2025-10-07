import 'package:tribbe/models/personal_data_model.dart';
import 'package:tribbe/models/preferences_model.dart';
import 'package:tribbe/models/information_model.dart';
import 'package:tribbe/models/character_model.dart';
import 'package:tribbe/models/measurements_model.dart';

class UserProfileModel {
  final PersonalDataModel datosPersonales;
  final PreferencesModel preferencias;
  final InformationModel? informacion;
  final CharacterModel? personaje;
  final MeasurementsModel? medidas;

  const UserProfileModel({
    required this.datosPersonales,
    this.preferencias = const PreferencesModel(),
    this.informacion,
    this.personaje,
    this.medidas,
  });

  Map<String, dynamic> toJson() => {
    'datosPersonales': datosPersonales.toJson(),
    'preferencias': preferencias.toJson(),
    'informacion': informacion?.toJson(),
    'personaje': personaje?.toJson(),
    'medidas': medidas?.toJson(),
  };

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        datosPersonales: PersonalDataModel.fromJson(json['datosPersonales']),
        preferencias: json['preferencias'] != null
            ? PreferencesModel.fromJson(json['preferencias'])
            : const PreferencesModel(),
        informacion: json['informacion'] != null
            ? InformationModel.fromJson(json['informacion'])
            : null,
        personaje: json['personaje'] != null
            ? CharacterModel.fromJson(json['personaje'])
            : null,
        medidas: json['medidas'] != null
            ? MeasurementsModel.fromJson(json['medidas'])
            : null,
      );

  UserProfileModel copyWith({
    PersonalDataModel? datosPersonales,
    PreferencesModel? preferencias,
    InformationModel? informacion,
    CharacterModel? personaje,
    MeasurementsModel? medidas,
  }) => UserProfileModel(
    datosPersonales: datosPersonales ?? this.datosPersonales,
    preferencias: preferencias ?? this.preferencias,
    informacion: informacion ?? this.informacion,
    personaje: personaje ?? this.personaje,
    medidas: medidas ?? this.medidas,
  );
}
