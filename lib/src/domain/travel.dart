import 'package:google_maps_flutter/google_maps_flutter.dart';

class Travel {
  final int codigo;
  String id_passageiro;
  String id_parceiro;
  String valor_uber;
  String valor_corrida;
  String valor_parceiro;
  String tipo_venda;
  String endereco_destino;
  String latitude;
  String longitude;

  Travel({
    this.codigo,
    this.id_passageiro,
    this.id_parceiro,
    this.valor_uber,
    this.valor_corrida,
    this.valor_parceiro,
    this.tipo_venda,
    this.endereco_destino,
    this.latitude,
    this.longitude,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      codigo: json['codigo'] as int,
      id_passageiro: json['id_passageiro'],
      id_parceiro: json['id_parceiro'],
      valor_uber: json['valor_uber'],
      valor_corrida: json['valor_corrida'],
      valor_parceiro: json['valor_parceiro'],
      tipo_venda: json['tipo_venda'],
      endereco_destino: json['endereco_destino'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  get latlng =>
      LatLng(
          latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
          longitude == null || longitude.isEmpty ? 0.0 : double.parse(
              longitude));

  Map toMap() {
    Map<String, dynamic> map = {
      "latitude": latitude,
      "longitude": longitude,
    };
    if (codigo != null) {
      map["codigo"] = codigo;
    }
    return map;
  }

  @override
  String toString() {
    return "Travel[$codigo]: $id_passageiro";
  }
}
