import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodar/src/domain/travel.dart';
import 'package:rodar/src/domain/travel_service.dart';

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

  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
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
      child: FutureBuilder<List<Travel>>(
        future: TravelService.getTravels(this.parceiro),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _listView(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Sem dados..",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 26,
                    fontStyle: FontStyle.normal),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _listView(List<Travel> travels) {
    return ListView.builder(
      itemCount: travels == null ? 0 : travels.length,
      itemBuilder: (BuildContext context, int index) {
        final travel = travels[index];
        return Container(
          height: 280,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(travel.endereco_destino),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Marker> _getMarkers(Travel travel) {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: travel.latlng(),
        infoWindow:
        InfoWindow(title: "Ferrari FF", snippet: "Fábrica da Ferrari"),
        onTap: () {
          print("> ${travel.endereco_destino}");
        },
      )
    ];
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
