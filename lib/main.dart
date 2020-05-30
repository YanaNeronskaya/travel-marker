import 'package:flutter/material.dart';
import 'package:travelmarker/client/pages/home/Home.dart' as HomePage;
import 'package:travelmarker/client/pages/earth/Earth.dart' as EarthPage;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'Travel Marker',
      routes: {
        '/': (context) => HomePage.MyHomePage(title: 'Homepage'),
        '/earth': (context) => EarthPage.OfflineMapPage()
      }
    );
  }
}
