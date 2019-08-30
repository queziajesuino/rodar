import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodar/src/ui/prefs.dart';

class Travel {
  final String codigo;
  String id_passageiro;
  String id_parceiro;
  String valor_uber;
  String valor_corrida;
  String valor_parceiro;
  String tipo_venda;
  String endereco_destino;
  String latitude;
  String longitude;
  String latLong;

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
    this.latLong
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      codigo: json['codigo'] as String,
      id_passageiro: json['id_passageiro']as String,
      id_parceiro: json['id_parceiro']as String,
      valor_uber: json['valor_uber']as String,
      valor_corrida: json['valor_corrida']as String,
      valor_parceiro: json['valor_parceiro']as String,
      tipo_venda: json['tipo_venda']as String,
      endereco_destino: json['endereco_destino'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,

    );
  }

  get latlng => LatLng(
      latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
      longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude));

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

  static Future<Travel> get() async {
    String s = await Prefs.getString("travel.prefs");
    if (s == null || s.isEmpty) {
      return null;
    }
    final travel = Travel.fromJson(json.decode(s));
    return travel;
  }


}
