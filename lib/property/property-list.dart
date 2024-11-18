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
  var propertyService = PropertyService();
  Future<List<Property>> properties;
  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future loadItems() async {
    var items = propertyService.getPosts().catchError((err) {
      print(err);
      alert(context,
          title: "Error", content: "Error Occured while fetching posts");
    });
    // Future.delayed(Duration.zero, () {
    // print("djkjkdkd");
    setState(() {
      properties = items;
    });
    return properties;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0, //To minimize the padding between title and leading
        leading: Icon(Icons.landscape),
        title: Text(
          "Land Sales Management",
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
        onRefresh: () => loadItems(),
        child: Container(
          alignment: Alignment.center,
          color: Color(0xFFF2F4F8),
          child: FutureBuilder<List<Property>>(
            future: properties, // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return errorWidget();
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) return errorWidget();
                  if (!snapshot.hasData) return errorWidget();
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

  Widget errorWidget() {
    return FlatButton(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap to refresh',
            ),
            Icon(Icons.refresh)
          ],
        ),
      ),
      onPressed: () {
        loadItems();
      },
    );
  }

}
