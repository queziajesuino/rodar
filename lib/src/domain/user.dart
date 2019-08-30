import 'dart:convert';

import '../ui//prefs.dart';

class User {
  final String nome;
  final String usuario;
  final String email;
  final String id_parceiro;

  User(this.nome, this.usuario, this.email, this.id_parceiro);

  User.fromJson(Map<String, dynamic> map)
      : this.nome = map["nome"],
        this.usuario = map["usuario"],
        this.email = map["email"],
        this.id_parceiro = map["id_parceiro"];

  void save() {
    final map = {
      "nome": nome,
      "usuario": usuario,
      "email": email,
      "id_parceiro": id_parceiro
    };
    Prefs.setString("user.prefs", json.encode(map));
  }

  static Future<User> get() async {
    String s = await Prefs.getString("user.prefs");
    if (s == null || s.isEmpty) {
      return null;
    }
    final user = User.fromJson(json.decode(s));
    return user;
  }

  static clear() {
    // Prefs.setString("user.prefs", "");
  }
}
