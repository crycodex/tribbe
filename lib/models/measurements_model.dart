import 'package:tribbe/models/specific_measurements_model.dart';

class MeasurementsModel {
  final double alturaCm;
  final double pesoKg;
  final double porcentajeGrasaCorporal;
  final SpecificMeasurementsModel medidasEspecificasCm;

  const MeasurementsModel({
    this.alturaCm = 0.0,
    this.pesoKg = 0.0,
    this.porcentajeGrasaCorporal = 0.0,
    this.medidasEspecificasCm = const SpecificMeasurementsModel(),
  });

  Map<String, dynamic> toJson() => {
    'alturaCm': alturaCm,
    'pesoKg': pesoKg,
    'porcentajeGrasaCorporal': porcentajeGrasaCorporal,
    'medidasEspecificasCm': medidasEspecificasCm.toJson(),
  };

  factory MeasurementsModel.fromJson(Map<String, dynamic> json) =>
      MeasurementsModel(
        alturaCm: (json['alturaCm'] ?? 0.0).toDouble(),
        pesoKg: (json['pesoKg'] ?? 0.0).toDouble(),
        porcentajeGrasaCorporal: (json['porcentajeGrasaCorporal'] ?? 0.0)
            .toDouble(),
        medidasEspecificasCm: json['medidasEspecificasCm'] != null
            ? SpecificMeasurementsModel.fromJson(json['medidasEspecificasCm'])
            : const SpecificMeasurementsModel(),
      );

  MeasurementsModel copyWith({
    double? alturaCm,
    double? pesoKg,
    double? porcentajeGrasaCorporal,
    SpecificMeasurementsModel? medidasEspecificasCm,
  }) => MeasurementsModel(
    alturaCm: alturaCm ?? this.alturaCm,
    pesoKg: pesoKg ?? this.pesoKg,
    porcentajeGrasaCorporal:
        porcentajeGrasaCorporal ?? this.porcentajeGrasaCorporal,
    medidasEspecificasCm: medidasEspecificasCm ?? this.medidasEspecificasCm,
  );
}
