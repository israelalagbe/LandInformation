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
  double opacity = 0.0;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      setState(() {
        opacity = 1.0;
      });
    });
    print("Hello world");
    // _controller=AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 1)
    // );
  }

  @override
  Widget build(BuildContext context) {
    var description = this.widget.property.description;
    var items = description.split('\n');
    var builtDesc = "";
    var widgetItems = items.map((item) {
      var text1 = item.split(':')[0];
      var text2 = item.split(':')[1];
      return FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {},
        child: Container(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  text1.trim() + ": ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
                Text(
                  text2.trim(),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
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
                                SelectableText(
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
                                SelectableText(
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
                                Column(
                                  children: widgetItems,
                                )
                                // SelectableText(
                                //   items[0],
                                //   textDirection: TextDirection.ltr,
                                //   style: TextStyle(color: Colors.black87),
                                // ),
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
