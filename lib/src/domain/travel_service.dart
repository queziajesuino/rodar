import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
