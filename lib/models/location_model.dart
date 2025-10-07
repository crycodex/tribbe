class LocationModel {
  final String pais;
  final String provincia;
  final String ciudad;

  const LocationModel({
    required this.pais,
    required this.provincia,
    required this.ciudad,
  });

  Map<String, dynamic> toJson() => {
    'pais': pais,
    'provincia': provincia,
    'ciudad': ciudad,
  };

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    pais: json['pais'] ?? '',
    provincia: json['provincia'] ?? '',
    ciudad: json['ciudad'] ?? '',
  );

  LocationModel copyWith({String? pais, String? provincia, String? ciudad}) =>
      LocationModel(
        pais: pais ?? this.pais,
        provincia: provincia ?? this.provincia,
        ciudad: ciudad ?? this.ciudad,
      );
}
