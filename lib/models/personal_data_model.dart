import 'package:tribbe/models/location_model.dart';

class PersonalDataModel {
  final String nombreCompleto;
  final String nombreUsuario;
  final String email;
  final String fechaNacimiento;
  final LocationModel ubicacion;

  const PersonalDataModel({
    required this.nombreCompleto,
    required this.nombreUsuario,
    required this.email,
    required this.fechaNacimiento,
    required this.ubicacion,
  });

  Map<String, dynamic> toJson() => {
    'nombreCompleto': nombreCompleto,
    'nombreUsuario': nombreUsuario,
    'email': email,
    'fechaNacimiento': fechaNacimiento,
    'ubicacion': ubicacion.toJson(),
  };

  factory PersonalDataModel.fromJson(Map<String, dynamic> json) =>
      PersonalDataModel(
        nombreCompleto: json['nombreCompleto'] ?? '',
        nombreUsuario: json['nombreUsuario'] ?? '',
        email: json['email'] ?? '',
        fechaNacimiento: json['fechaNacimiento'] ?? '',
        ubicacion: LocationModel.fromJson(json['ubicacion'] ?? {}),
      );

  PersonalDataModel copyWith({
    String? nombreCompleto,
    String? nombreUsuario,
    String? email,
    String? fechaNacimiento,
    LocationModel? ubicacion,
  }) => PersonalDataModel(
    nombreCompleto: nombreCompleto ?? this.nombreCompleto,
    nombreUsuario: nombreUsuario ?? this.nombreUsuario,
    email: email ?? this.email,
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    ubicacion: ubicacion ?? this.ubicacion,
  );
}
