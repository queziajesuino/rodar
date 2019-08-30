//vai os campos do json de retorno
class ResponseUser {
  final String code;
  final String id_parceiro;

  ResponseUser(this.code, this.id_parceiro);

  // lista de inicialização que vai preencher o method constructor do objeto
  ResponseUser.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        id_parceiro = map["id_parceiro"];

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
