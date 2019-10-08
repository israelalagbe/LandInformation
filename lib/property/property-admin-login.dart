import 'package:flutter/material.dart';
import 'package:land_information/property/add-property.dart';

void alert(BuildContext context, {String title, String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
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

void confirm(BuildContext context,
    {String title, String content, Function callback}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              callback(false);
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () {
              callback(true);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class PropertyAdminLogin extends StatefulWidget {
  @override
  _PropertyAdminLoginState createState() => _PropertyAdminLoginState();
}

class _PropertyAdminLoginState extends State<PropertyAdminLogin> {
  final usernameCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  _login(BuildContext context) {
    if (usernameCtl.value.text == "admin" &&
        passwordCtl.value.text == 'password') {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => AddProperty(),
        ),
      );
    } else {
      alert(context,
          title: "Error", content: "Username or Password incorrect!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(
          "Admin Area",
          textDirection: TextDirection.ltr,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          //Contrained box is used here cos of the single child scrollview
          return SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 300,
                    child: Center(
                      child: Text(
                        "LOGO",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: "Username",
                          ),
                          controller: usernameCtl,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                          ),
                          controller: passwordCtl,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => _login(context),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        }),
      ),
    );
  }
}
