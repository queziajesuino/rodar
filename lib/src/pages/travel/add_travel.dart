import 'package:flutter/material.dart';
import 'package:rodar/src/domain/travel_service.dart';
import 'package:rodar/src/ui/flushbar.dart';

class AdiTravel extends StatefulWidget {
  static String route = '/addtravel';
  final String parceiro;

  AdiTravel(this.parceiro);

  //@override
  _AdiTravelState createState() => _AdiTravelState(this.parceiro);
}

class _AdiTravelState extends State<AdiTravel> {
  TextEditingController _tCodTravel = new TextEditingController();
  final String parceiro;

  _AdiTravelState(this.parceiro);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("START VIAGEM"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: _tCodTravel,
                  decoration: new InputDecoration(
                      hintText: "Código de Viagem",
                      labelText: "Código de Viagem"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("ENVIAR"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    _onClickISave(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onClickISave(BuildContext context) async {
    final code = _tCodTravel.text;

    final response = await TravelService.add(code, this.parceiro);

    if (response.isOk()) {
      Flushbar(
        message: response.message,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Flushbar(
        message: response.message,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}
