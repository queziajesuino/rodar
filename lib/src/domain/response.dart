import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyBhDflq5iJrXIcKpeq0IzLQPQpOboX91lY";

class ResponseUser {
  final String code;
  final String id_parceiro;
  final String nome;
  final String email;

  ResponseUser(this.code, this.id_parceiro, this.email, this.nome);

  // lista de inicialização que vai preencher o method constructor do objeto
  ResponseUser.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        id_parceiro = map["id_parceiro"],
        nome = map["nome"],
        email = map["email"];

  bool isOk() {
    return code == "success";
  }
}

class ResponseTravel {
  final String code;
  final String message;

  ResponseTravel(this.code, this.message);

  // lista de inicialização que vai preencher o method constructor do objeto
  ResponseTravel.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        message = map["message"];

  bool isOk() {
    return code == "success";
  }
}

class ResponseTravelview {
  final String code;
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

  ResponseTravelview(
      this.code,
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

  // lista de inicialização que vai preencher o method constructor do objeto
  ResponseTravelview.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        codigo = map["codigo"],
        id_parceiro = map["id_parceiro"],
        id_passageiro = map["id_passageiro"],
        valor_uber = map["valor_uber"],
        valor_corrida = map["valor_corrida"],
        valor_parceiro = map["valor_parceiro"],
        tipo_venda = map["tipo_venda"],
        endereco_destino = map["endereco_destino"],
        latitude = map["latitude"],
        longitude = map["longitude"];

  bool isOk() {
    return code == "success";
  }
}

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
