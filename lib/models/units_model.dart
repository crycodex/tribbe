class UnitsModel {
  final String medida;
  final String peso;

  const UnitsModel({this.medida = 'cm', this.peso = 'kg'});

  Map<String, dynamic> toJson() => {'medida': medida, 'peso': peso};

  factory UnitsModel.fromJson(Map<String, dynamic> json) =>
      UnitsModel(medida: json['medida'] ?? 'cm', peso: json['peso'] ?? 'kg');

  UnitsModel copyWith({String? medida, String? peso}) =>
      UnitsModel(medida: medida ?? this.medida, peso: peso ?? this.peso);
}
