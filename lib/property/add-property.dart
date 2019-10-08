import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:land_information/property/property-admin-login.dart';
import 'package:land_information/property/property-service.dart';
import 'package:land_information/property/property.dart';

class MySingleScroll extends StatelessWidget {
  final Widget child;
  const MySingleScroll({this.child});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        //Contrained box is used here cos of the single child scrollview
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  File _file;
  final titleCtl = TextEditingController();
  final priceCtl = TextEditingController();
  final descriptionCtl = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            "Add land info",
            textDirection: TextDirection.ltr,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: MySingleScroll(
            child: Container(
              padding: EdgeInsets.all(10),
              //height: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.red,
                    child: Container(
                      height: 200,
                      width: 300,
                      color: Colors.grey.withAlpha(70),
                      child: _file != null
                          ? Image.file(
                              _file,
                              height: 200,
                              width: 300,
                            )
                          : Center(
                              child: Text(
                                "Tap to Upload Image",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                    ),
                    onTap: () async {
                      File file =
                          await FilePicker.getFile(type: FileType.IMAGE);
                      setState(() {
                        _file = file;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      labelText: "Land Title",
                      border: OutlineInputBorder(),
                    ),
                    controller: titleCtl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                      labelText: 'Price (#)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    controller: priceCtl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "Full Description of the Land. e.g Address, Seller, e.t.c",
                    ),
                    maxLines: 10,
                    controller: descriptionCtl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      color: Colors.red,
                      child: loading
                          ? CircularProgressIndicator()
                          : Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        try {
                          if (titleCtl.text.isEmpty ||
                              descriptionCtl.text.isEmpty ||
                              priceCtl.text.isEmpty ||
                              _file == null) {
                            alert(
                              context,
                              title: "Error",
                              content: "Please fill all inputs!",
                            );
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          var propertyService = new PropertyService();
                          var url = await propertyService.uploadFile(_file);
                          Property property = new Property(
                            name: titleCtl.value.text,
                            description: descriptionCtl.value.text,
                            price: int.parse(priceCtl.value.text),
                            image: url,
                          );

                          await propertyService.savePost(property);
                          alert(
                            context,
                            title: "Success",
                            content: "Land saved successfully!",
                          );
                          setState(() {
                            _file = null;
                          });
                          titleCtl.text = "";
                          priceCtl.text = "";
                          descriptionCtl.text = "";
                        } catch (e) {
                          print(e);
                          alert(
                            context,
                            title: "Error",
                            content: "Error occured while saving Land info!",
                          );
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
