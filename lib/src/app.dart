import 'package:flutter/material.dart';
import 'package:rodar/src/pages/travel/Maps.dart';
import 'package:rodar/src/pages/travel/detail_travel.dart';

import './pages/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RodarAPP',
      //hide debug banner
      debugShowCheckedModeBanner: false,
      //theme of application
      theme: new ThemeData(
        primaryColor: Colors.indigo,
        primarySwatch: indigo,
        cursorColor: Colors.indigo.shade700,
        buttonColor: Colors.indigo.shade900,
        buttonTheme: new ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        errorColor: Colors.cyan,
      ),
      routes: screenRoutes,
      home: new MapsTravel(),
      //home: new SecondScreen(response:null,),
    );
  }
}

//create routes
final screenRoutes = <String, WidgetBuilder>{
  //route names coming from their respective classes
  LoginScreen.route: (BuildContext context) => new LoginScreen(),
  //SecondScreen.route: (BuildContext context) => new SecondScreen(response:null,),
};

//create material color to assign to primarySwatch
const MaterialColor indigo = const MaterialColor(0xFF3F51B5, const <int, Color>{
  50: Color(0xFFE8EAF6),
  100: Color(0xFFC5CAE9),
  200: Color(0xFF9FA8DA),
  300: Color(0xFF7986CB),
  400: Color(0xFF5C6BC0),
  500: Color(0xFF3F51B5),
  600: Color(0xFF3949AB),
  700: Color(0xFF303F9F),
  800: Color(0xFF283593),
  900: Color(0xFF1A237E),
});
