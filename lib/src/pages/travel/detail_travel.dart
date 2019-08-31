import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodar/src/domain/travel_service.dart';
import 'package:rodar/src/ui/flushbar.dart';

import 'last_travels.dart';

class DetailTravel extends StatefulWidget {
  final Map travel;

  DetailTravel(this.travel);

  _DetailTravelState createState() => _DetailTravelState();
}

class _DetailTravelState extends State<DetailTravel> {
  get travel => widget.travel;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    //_mapController.mar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Text(travel["codigo"] + " - " + travel["status"],
              style: TextStyle(
                fontSize: 30,
              )),

          Text(travel["endereco_destino"],

              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                              ),),
          Container(padding: EdgeInsets.only(top: 10))
        ],
      ),

      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      bottomSheet: Container(
        height: 300,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            //   polylines: Set<Polyline>.of(polylines.values),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(travel["latitude"]),
                  double.parse(travel["longitude"])),
              zoom: 17.0,
            ),
            markers: Set.of(_getMarkers()),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //_initCameraPosition();
            },
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                    ),
                    PriceWidget(
                      price: travel["valor_parceiro"],
                      onPressed: () {},
                    ),
                    Container(
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                    ),
                    GoButton(
                      title: "Finalizar",
                      onPressed: () {
                        _onClickFinalizar(context, travel);
                      },
                    ),
                    Container(
                      width: 50,
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onClickFinalizar(BuildContext context, travel) async {
    final response = await TravelService.finalize(travel["id"]);
//print(travel["id_parceiro"]);

    if (response.isOk()) {
          var route = new MaterialPageRoute(
          builder: (BuildContext context) => new LastTravels(travel["id_parceiro"]));
      Navigator.of(context).push(route);

    } if (response.isError())  {
      Dialog(
        child: Text( response.message,
      ),
              );
    }
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(double.parse(travel["latitude"]),
            double.parse(travel["longitude"])),
        infoWindow: InfoWindow(title: travel["codigo"],snippet: travel["endereco_destino"] )
      )
    ];
  }
}

class FunctionalButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.black,
          fillColor: Colors.white,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                widget.icon,
                size: 30.0,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}

class PriceWidget extends StatefulWidget {
  final String price;
  final Function() onPressed;

  const PriceWidget({Key key, this.price, this.onPressed}) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4),
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("R\$",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          Text(widget.price,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class GoButton extends StatefulWidget {
  final String title;
  final Function() onPressed;

  const GoButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  _GoButtonState createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 10),
              shape: BoxShape.circle),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            child: RawMaterialButton(
              onPressed: widget.onPressed,
              splashColor: Colors.black,
              fillColor: Colors.red,
              elevation: 15.0,
              shape: CircleBorder(),
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13))),
            ),
          ),
        ),
      ],
    );
  }
}
