import 'package:flutter/material.dart';

import 'src/HomePage.dart';

void main() {
  runApp(MyApp());
}

// stl  Stateless
// stf  Statefull

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha conta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF7159C1),
        accentColor: Color(0xFF7D40E7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
