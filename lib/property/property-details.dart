import 'package:flutter/material.dart';
import 'package:land_information/property/property.dart';
import 'package:intl/intl.dart' as intl;

final formatCurrency = new intl.NumberFormat.currency(symbol: "\u20A6");

class PropertyDetails extends StatefulWidget {
  final Property property;
  const PropertyDetails({Key key, this.property}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  AnimationController _controller;
  Animation _animation;
  double opacity=0.0;
  @override
  void initState(){
    Future.delayed(Duration(milliseconds: 1)).then((value){
      setState(() {
        opacity=1.0; 
      });
    });
    // _controller=AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 1)
    // );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            widget.property.name,
            textDirection: TextDirection.ltr,
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            //Contrained box is used here cos of the single child scrollview
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: this.widget.property.id,
                          child: Container(
                            child: Image.network(
                              this.widget.property.image,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: opacity,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  this.widget.property.name,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withAlpha(150)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${formatCurrency.format(widget.property.price)}",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.black.withAlpha(100),
                                      fontSize: 18),
                                ),
                                // Text(
                                //   "Category: Property",
                                //   textDirection: TextDirection.ltr,
                                //   style: TextStyle(
                                //       fontStyle: FontStyle.italic, color: Colors.black38),
                                // ),
                                Divider(),
                                Text(
                                  this.widget.property.description,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
