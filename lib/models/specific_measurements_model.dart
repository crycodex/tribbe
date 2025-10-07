class SpecificMeasurementsModel {
  final double cuello;
  final double hombro;
  final double brazoIzquierdo;
  final double brazoDerecho;
  final double antebrazoIzquierdo;
  final double antebrazoDerecho;
  final double pecho;
  final double espalda;
  final double cintura;
  final double cuadricepIzquierdo;
  final double cuadricepDerecho;
  final double pantorrillaIzquierda;
  final double pantorrillaDerecha;

  const SpecificMeasurementsModel({
    this.cuello = 0.0,
    this.hombro = 0.0,
    this.brazoIzquierdo = 0.0,
    this.brazoDerecho = 0.0,
    this.antebrazoIzquierdo = 0.0,
    this.antebrazoDerecho = 0.0,
    this.pecho = 0.0,
    this.espalda = 0.0,
    this.cintura = 0.0,
    this.cuadricepIzquierdo = 0.0,
    this.cuadricepDerecho = 0.0,
    this.pantorrillaIzquierda = 0.0,
    this.pantorrillaDerecha = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'cuello': cuello,
    'hombro': hombro,
    'brazoIzquierdo': brazoIzquierdo,
    'brazoDerecho': brazoDerecho,
    'antebrazoIzquierdo': antebrazoIzquierdo,
    'antebrazoDerecho': antebrazoDerecho,
    'pecho': pecho,
    'espalda': espalda,
    'cintura': cintura,
    'cuadricepIzquierdo': cuadricepIzquierdo,
    'cuadricepDerecho': cuadricepDerecho,
    'pantorrillaIzquierda': pantorrillaIzquierda,
    'pantorrillaDerecha': pantorrillaDerecha,
  };

  factory SpecificMeasurementsModel.fromJson(Map<String, dynamic> json) =>
      SpecificMeasurementsModel(
        cuello: (json['cuello'] ?? 0.0).toDouble(),
        hombro: (json['hombro'] ?? 0.0).toDouble(),
        brazoIzquierdo: (json['brazoIzquierdo'] ?? 0.0).toDouble(),
        brazoDerecho: (json['brazoDerecho'] ?? 0.0).toDouble(),
        antebrazoIzquierdo: (json['antebrazoIzquierdo'] ?? 0.0).toDouble(),
        antebrazoDerecho: (json['antebrazoDerecho'] ?? 0.0).toDouble(),
        pecho: (json['pecho'] ?? 0.0).toDouble(),
        espalda: (json['espalda'] ?? 0.0).toDouble(),
        cintura: (json['cintura'] ?? 0.0).toDouble(),
        cuadricepIzquierdo: (json['cuadricepIzquierdo'] ?? 0.0).toDouble(),
        cuadricepDerecho: (json['cuadricepDerecho'] ?? 0.0).toDouble(),
        pantorrillaIzquierda: (json['pantorrillaIzquierda'] ?? 0.0).toDouble(),
        pantorrillaDerecha: (json['pantorrillaDerecha'] ?? 0.0).toDouble(),
      );
}
