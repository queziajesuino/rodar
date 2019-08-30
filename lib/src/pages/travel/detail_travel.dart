import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodar/src/domain/travel.dart';

class DetailTravel extends StatefulWidget {
  final Map travel;

  DetailTravel(this.travel);

  _DetailTravelState createState() => _DetailTravelState();
}

class _DetailTravelState extends State<DetailTravel> {
  get travel => widget.travel;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    print(travel);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(travel["codigo"]),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Card(
          child: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(target: _latLong(), zoom: 11),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set.of(_getMaker()),
          ),
        ),
      ),
    );
  }

  _latLong() {
    return LatLng(-20.4810437, -54.7756201);
    // return LatLng(double.parse(travel["latitude"]), double.parse(travel["longitude"]));
  }

  List<Marker> _getMaker() {
    return [
      Marker(
          markerId: MarkerId("1"),
          position: _latLong(),
          infoWindow: InfoWindow(
              title: travel["codigo"], snippet: travel["endereco_destino"])),
    ];
  }
}
