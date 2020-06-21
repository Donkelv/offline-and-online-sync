import 'package:Internashala/db/class.dart';
import 'package:Internashala/db/db.dart';
import 'package:Internashala/db/sqlDb.dart';
import 'package:Internashala/pages/retrieveData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_widget/connectivity_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name;
  TextEditingController prefe;
  DatabaseService db = DatabaseService();
  DatabaseSqflite databaseSqflite;
  //final snackBar = SnackBar(content: Text('Added Succesfully'));
  bool visible;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    prefe = TextEditingController();
    //databaseSqflite.initDatabase();
    visible = false;
  }

  @override
  void dispose() {
    super.dispose();
    name.clear();
    prefe.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: ConnectivityWidget(
            showOfflineBanner: false,
            builder: (context, isOnline) {
              if (isOnline) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.0,
                          ),
                          child: Text(
                            "Intern Test",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 30.0),
                          child: Text(
                            "Here we will push intern data to firebase",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 30.0, right: 30.0),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(13.0),
                                      color: Color(0xFFF3F4F3),
                                      child: ListTile(
                                        title: TextFormField(
                                          cursorColor: Colors.black,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            hintText: "Tell Us your name",
                                            hintStyle: TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                            focusColor: Colors.black,
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Color(0xFFC4C4C4),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          controller: name,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Please tell us your name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        color: Color(0xFFF3F4F3),
                                        child: ListTile(
                                          title: TextFormField(
                                            //expands: true,
                                            maxLines: 5,
                                            minLines: 4,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              hintText:
                                                  "Tell us what you love doing",
                                              hintStyle: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              focusColor: Colors.black,
                                              prefixIcon: Icon(
                                                Icons.games,
                                                color: Color(0xFFC4C4C4),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            controller: prefe,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Please tell us what you love doing";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            visible = true;
                                          });
                                          if (_formKey.currentState
                                              .validate()) {
                                            db
                                                .addDetails(
                                                    name.text, prefe.text)
                                                .whenComplete(() {
                                              //Scaffold.of(context).showSnackBar(snackBar);
                                              Navigator.pushNamed(
                                                  context, Retrieve.routeName);
                                              setState(() {
                                                visible = false;
                                              });
                                            });
                                          }
                                        },
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          color: Colors.black,
                                          child: Container(
                                            width: width,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: visible == true
                                                    ? CircularProgressIndicator()
                                                    : Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: FutureBuilder<List<InternSqflite>>(
                    future: DatabaseSqflite.instance.getUserModelData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return Stack(
                        children: [
                          Positioned(
                            top: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              color: Colors.white,
                              width: width,
                              height: 80.0,
                              child: Center(
                                child: Text("Offline",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              dragStartBehavior: DragStartBehavior.start,
                              children: snapshot.data
                                  .map(
                                    (e) => ListTile(
                                      title: Text(
                                        e.name,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        e.prefe,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Text(
                                          e.name[0],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
