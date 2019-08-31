import 'package:flutter/material.dart';
import 'package:rodar/src/domain/travel_service.dart';
import 'package:rodar/src/ui/drawer-list.dart';
import 'package:rodar/src/ui/flushbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'travel/add_travel.dart';
import 'travel/detail_travel.dart';
import 'travel/last_travels.dart';
import 'travel/next_travels.dart';

class HomePage extends StatefulWidget {
  static String route = '/homePage';
  final String parceiro;

  HomePage(this.parceiro);

  //@override
  _HomePageState createState() => _HomePageState(this.parceiro);
}

class _HomePageState extends State<HomePage> {
  final String parceiro;
  Map data;
  TextEditingController _tCodTravel = new TextEditingController();

  _HomePageState(this.parceiro);

  var usernameStyle = new TextStyle(
    color: Colors.black,
    fontSize: 40.0,
    fontWeight: FontWeight.w100,
  );
  var textStyle = new TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
  );
  var boldTextStyle = new TextStyle(
    fontWeight: FontWeight.w300,
  );

  Future getData() async {

    http.Response response = await http.get(
        "http://52.55.172.202/rodar/app/listOperacao.php?codigo=" +
            widget.parceiro);
    data = json.decode(response.body);
    //print(data);
    setState(() {
      data= data["operacoes"];
    });
  }
  //icon builder
  Widget iconBuilder() {
    return new Image.asset(
      "images/vemrodar.png",
    );
  }

  void _onClickISave(BuildContext context) async {
    final code = _tCodTravel.text;

    final response = await TravelService.add(code, this.parceiro);

    if (response.isOk()) {
      var route = new MaterialPageRoute(
          builder: (context) => new LastTravels(this.parceiro));
      Navigator.push(context,route);
    } else {
      Flushbar(
        message: response.message,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void validaButton(String type) {
    setState(() {
      if (type == 'Start') {

        _onClickISave(context);
      } else if (type == 'Historico') {
        lastTravels();
      } else if (type == 'Voos') {
        nextTravels();
      }
    });
  }

  void addTravel() {
    setState(() {
      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new AdiTravel(this.parceiro));
      Navigator.of(context).push(route);
    });
  }

  void lastTravels() {
    setState(() {
      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new LastTravels(this.parceiro));
      Navigator.of(context).push(route);
    });
  }

  void nextTravels() {
    setState(() {
      var route = new MaterialPageRoute(
          builder: (BuildContext context) => new NextTravels());
      Navigator.of(context).push(route);
    });
  }

  //username builder
  Widget buttonBuilder(String text, Color color, String type) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: RaisedButton(
              splashColor: color,
              color: color,
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                validaButton(type);
              },
            ),
          ),
        ],
      ),
    );
  }

  //username builder
  Widget usernameTextBuilder() {
    return new Container(
      padding: new EdgeInsets.only(
        bottom: 12.0,
      ),
      child: new RichText(
        text: new TextSpan(
          text: 'RODAR ',
          style: usernameStyle,
          children: <TextSpan>[
            new TextSpan(
              text: 'APP',
              style: boldTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  //text builder
  Widget textBuilder(IconData icon, String firstText, String secondText) {
    return Container(
      padding: new EdgeInsets.only(
        bottom: 8.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(right: 5.0),
            child: new Icon(
              icon,
              color: Colors.indigo,
              size: 20.0,
            ),
          ),
          new RichText(
            text: new TextSpan(
              text: firstText,
              style: textStyle,
              children: <TextSpan>[
                new TextSpan(
                  text: secondText,
                  style: boldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
      ),
      drawer: DrawerList(),

      body: new Container(
        padding: new EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20),
        child: new Center(
          child: new Column(
            children: <Widget>[
              iconBuilder(),
              //usernameTextBuilder(),

              new TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: _tCodTravel,
                decoration: new InputDecoration(

                    hintText: "Código da Corrida",
                  ),
              ),
              buttonBuilder('INICIAR OPERAÇÃO', Colors.indigo.shade500, 'Start'),

              buttonBuilder(
                  'HISTÓRICO DE OPERAÇÕES', Colors.indigo.shade500, 'Historico'),
              //  buttonBuilder('PRÓXIMOS VÔOS', Colors.indigo.shade600, 'Voos'),
            ],
          ),
        ),
      ),
    );
  }
}
