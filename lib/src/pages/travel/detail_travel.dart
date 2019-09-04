import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTravel extends StatefulWidget {
  final Map travel;

  DetailTravel(this.travel);

  _DetailTravelState createState() => _DetailTravelState();
}

const kExpandedHeight = 300.0;

class _DetailTravelState extends State<DetailTravel> {
  get travel => widget.travel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: 560,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            travel["codigo"],
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "R\$" + travel["valor_parceiro"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.indigo.shade700,
                        blurRadius: 11,
                        offset: Offset(3.0, 4.0))
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        title: Text(
                            DateFormat.yMMMd().format(DateTime.parse(travel["inicio_corrida"])),
                            style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                                DateFormat.Hm().format(
                                      DateTime.parse(travel["inicio_corrida"]),
                                    ) +" - " +
                                    DateFormat.Hm().format(
                                      DateTime.parse(travel["termino_corrida"]),
                                    ),
                                style: TextStyle(fontSize: 16))),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade700,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        title: Text("Destino", style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(travel["endereco_destino"],
                                style: TextStyle(fontSize: 16))),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade700,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
