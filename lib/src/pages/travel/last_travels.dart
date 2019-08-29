import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LastTravels extends StatefulWidget {
  static String route = '/lasttravel';
  final String parceiro;

  LastTravels(this.parceiro);

  //@override
  _LastTravelsState createState() => _LastTravelsState(this.parceiro);
}

class _LastTravelsState extends State<LastTravels> {
  final String parceiro;

  _LastTravelsState(this.parceiro);

  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get(
        "http://52.55.172.202/rodar/app/listOperacao.php?id=" + this.parceiro);
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
        title: Text("HISTÓRICO"),
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
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(45.521563, -122.677433),
                      zoom: 11,
                    ),
                  ),
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
