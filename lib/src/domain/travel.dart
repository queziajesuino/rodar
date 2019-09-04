import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodar/src/ui/prefs.dart';

class Travel {
  final String codigo;
  final String id_passageiro;
  final String id_parceiro;
  final String valor_uber;
  final String valor_corrida;
  final String valor_parceiro;
  final String tipo_venda;
  final String endereco_destino;
  final String latitude;
  final String longitude;

  Travel(
      this.codigo,
      this.id_passageiro,
      this.id_parceiro,
      this.valor_uber,
      this.valor_corrida,
      this.valor_parceiro,
      this.tipo_venda,
      this.endereco_destino,
      this.latitude,
      this.longitude);

  Travel.fromJson(Map<String, dynamic> json)
      : this.codigo = json['codigo'],
        this.id_passageiro = json['id_passageiro'],
        this.id_parceiro = json['id_parceiro'],
        this.valor_uber = json['valor_uber'],
        this.valor_corrida = json['valor_corrida'],
        this.valor_parceiro = json['valor_parceiro'],
        this.tipo_venda = json['tipo_venda'],
        this.endereco_destino = json['endereco_destino'],
        this.latitude = json['latitude'],
        this.longitude = json['longitude'];

  void save() {
    final map = {
      "codigo": codigo,
      "id_passageiro": id_passageiro,
      "id_parceiro": id_parceiro,
      "valor_uber": valor_uber,
      "valor_corrida": valor_corrida,
      "valor_parceiro": valor_parceiro,
      "tipo_venda": tipo_venda,
      "endereco_destino": endereco_destino,
      "latitude": latitude,
      "longitude": longitude
    };
    Prefs.setString("travel.prefs", json.encode(map));
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
