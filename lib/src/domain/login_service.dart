import 'dart:convert';

import 'package:http/http.dart' as http;

import './response.dart';

class LoginService {
  static Future<ResponseUser> login(String login, String password) async {
    var url = 'http://52.55.172.202/rodar/app/auth.php';
    final response =
        await http.post(url, body: {'senha': password, 'usuario': login});
    final s = response.body;

    final r = ResponseUser.fromJson(json.decode(s));
    return r;
  }
}
