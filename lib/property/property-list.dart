import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:land_information/property/property-admin-login.dart';
import 'package:land_information/property/property-item.dart';
import 'package:land_information/property/property-service.dart';
import 'package:land_information/property/property.dart';

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  bool loading;
  var propertyService = new PropertyService();
  Future<List<Property>> properties;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this.loading = true;
    // loadItems().then((value) {
    //   setState(() {
    //     loading = false;
    //   });
    // });

    properties = propertyService.getPosts();
  }

  Future loadItems() async {
    return await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0, //To minimize the padding between title and leading
        leading: Icon(Icons.landscape),
        title: Text(
          "Land Management",
          textDirection: TextDirection.ltr,
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'login') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PropertyAdminLogin()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Admin Area"),
                  value: 'login',
                )
              ];
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
           properties = propertyService.getPosts(); 
          });
          return properties;
        },
        child: Center(
          child: FutureBuilder<List<Property>>(
            future: properties, // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Nothing to show');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) return Icon(Icons.refresh);
                  return ListView(
                    children: snapshot.data
                        .map((property) => PropertyItem(
                              property: property,
                            ))
                        .toList(),
                  );
              }
              return null; // unreachable
            },
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
