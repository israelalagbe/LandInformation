import 'package:flutter/material.dart';
import 'package:land_information/property/property-list.dart';

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: PropertyList(),
    );
  }
}
