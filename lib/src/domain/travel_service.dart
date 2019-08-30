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

  static Future<ResponseTravel> finalize(String id) async {
    var url = 'http://52.55.172.202/rodar/app/finalizarOperacao.php';
    final response =
    await http.post(url, body: {'id': id});
    final s = response.body;
    print(s);

    final r = ResponseTravel.fromJson(json.decode(s));
    return r;
  }

  static Future<List<Travel>> getTravels(String id) async {
    Map data;
    List travels;

    http.Response response = await http
        .get("http://52.55.172.202/rodar/app/listOperacao.php?id=" + id);
    data = json.decode(response.body);

    travels = data["operacoes"];
//print(travels);
    return travels;
  }
}
