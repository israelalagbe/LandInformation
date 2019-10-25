import 'package:flutter/material.dart';
import 'package:land_information/property/property-details.dart';
import 'package:land_information/property/property.dart';
import 'package:intl/intl.dart' as intl;

final formatCurrency = new intl.NumberFormat.currency(symbol: "\u20A6");

class PropertyItem extends StatelessWidget {
  final Property property;
  const PropertyItem({
    Key key,
    this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Runes input = new Runes(' \u{1f605} ');
    return Card(
      child: InkWell(
        splashColor: Colors.redAccent.withAlpha(70),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) =>
                  PropertyDetails(property: this.property),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.only(left: 5, top: 5, right: 5),
          height: 100,
          child: Row(
            children: <Widget>[
              Hero(
                tag: this.property.id,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                        property.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 240,
                      child: Text(
                        property.name,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withAlpha(150)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${formatCurrency.format(property.price)}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withAlpha(100),
                      ),
                    ),
                    // Text(
                    //   "Category: Property",
                    //   textDirection: TextDirection.ltr,
                    //   style: TextStyle(
                    //       fontStyle: FontStyle.italic, color: Colors.black38),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
