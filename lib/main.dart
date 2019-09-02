import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:rodar/src/pages/travel/mapsview.dart';

import './src/app.dart';

void main() => runApp(new App());

/*
Future<void> main() async {
  DirectionsResponse res =
  await directions.directionsWithAddress('Campo Grande, Terenos','Terenos,Campo Grande');

  print(res.status);
  if (res.isOkay) {
    print('${res.routes.length} routes');
    for (var r in res.routes) {
      print(r.summary);
      print(r.bounds);
    }
  } else {
    print(res.errorMessage);
  }
  directions.dispose();
}*/
