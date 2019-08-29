import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NextTravels extends StatefulWidget {
  static String route = '/nexttravel';

  //@override
  _NextTravelsState createState() => _NextTravelsState();
}

class _NextTravelsState extends State<NextTravels> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response =
        await http.get("http://52.55.172.202/rodar/app/listOperacao.php?id=1");
    data = json.decode(response.body);
    setState(() {
      userData = data["operacoes"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRÓXIMOS VÔOS"),
        //backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${userData[index]["codigo"]} ${userData[index]["id_passageiro"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
