import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:rodar/src/domain/user.dart';
import 'package:http/http.dart' as http;

import 'detail_travel.dart';

class LastTravels extends StatefulWidget {
  static String route = '/lasttravel';
  final String parceiro;

  LastTravels(this.parceiro);

  //@override
  _LastTravelsState createState() => _LastTravelsState();
}

class _LastTravelsState extends State<LastTravels> {
  _LastTravelsState();

  GoogleMapController mapController;

  Map data;
  List travels;
  User user;

  Future getData() async {
    User.get();
    http.Response response = await http.get(
        "http://52.55.172.202/rodar/app/listOperacao.php?id=" +
            widget.parceiro);
    data = json.decode(response.body);
    //print(data);
    setState(() {
      travels = data["operacoes"];
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
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(12),
      child: ListView.builder(

        itemCount: travels == null ? 0 : travels.length,
        itemBuilder: (BuildContext cntx, int index) {
          final travel = travels[index];
          return Container(

            child: InkWell(
              onTap: () {
                _onClickDetails(context, travel);
              },
              child: Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(
                      Icons.airport_shuttle,
                      size: 50,
                    ),
                    title: Text(
                      travel["date_created"] + ' - Valor:' + travel["valor_parceiro"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    subtitle: Text(
                      travel["endereco_destino"],
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () {
                           // _onClickDetails(context, travel);
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onClickDetails(BuildContext context, travel) {
    // print(travel);
    var route =
        new MaterialPageRoute(builder: (context) => new DetailTravel(travel));
    Navigator.push(context, route);
  }
}
