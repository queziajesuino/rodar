import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rodar/src/domain/travel.dart';
import './response.dart';

class TravelService {
  static Future<ResponseTravel> add(String code, String parceiro) async {
    var url = 'http://52.55.172.202/rodar/app/iniciarOperacao.php';
    final response =
        await http.post(url, body: {'codigo': code, 'id_parceiro': parceiro});
    final s = response.body;
    print(s);

    final r = ResponseTravel.fromJson(json.decode(s));
    return r;
  }

  static Future<List<Travel>> getTravels(String id) async {
    final url = "http://52.55.172.202/rodar/app/listOperacao.php?id=" + id;
    print("> get: $url");

    final response = await http.get(url);

//    print("< : ${response.body}");

    final mapTravel = json.decode(response.body).cast<Map<String, dynamic>>();

    final travels = mapTravel.map<Travel>((json) => Travel.fromJson(json))
        .toList();

    return travels;
  }
}
