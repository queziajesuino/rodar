import 'package:flutter/material.dart';
import 'package:rodar/src/ui/drawer-list.dart';

import 'travel/add_travel.dart';
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

  //icon builder
  Widget iconBuilder() {
    return new Icon(
      Icons.airport_shuttle,
      color: Colors.indigo,
      size: 150.0,
    );
  }

  void validaButton(String type) {
    setState(() {
      if (type == 'Adicionar') {
        addTravel();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTravel();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              iconBuilder(),
              usernameTextBuilder(),
              buttonBuilder(
                  'ADICIONAR CORRIDA', Colors.indigo.shade400, 'Adicionar'),
              buttonBuilder(
                  'HISTÓRICO DE CORRIDAS', Colors.indigo.shade500, 'Historico'),
              buttonBuilder('PRÓXIMOS VÔOS', Colors.indigo.shade600, 'Voos'),
            ],
          ),
        ),
      ),
    );
  }
}
