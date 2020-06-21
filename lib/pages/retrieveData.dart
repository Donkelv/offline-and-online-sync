import 'package:Internashala/db/class.dart';
import 'package:Internashala/db/db.dart';
import 'package:Internashala/db/sqlDb.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Retrieve extends StatefulWidget {
  static const routeName = '/retreieve';
  @override
  _RetrieveState createState() => _RetrieveState();
}

class _RetrieveState extends State<Retrieve> {
  DatabaseService db = DatabaseService();
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
                return StreamBuilder<List<Intern>>(
                  stream: db.streamIntern(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      var info = snapshot.data;
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
                                child: Text("All Intern Data",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: info.length,
                              itemBuilder: (buildContext, index) => ListIntern(
                                intern: info[index],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
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

class ListIntern extends StatefulWidget {
  final Intern intern;
  ListIntern({this.intern});
  @override
  _ListInternState createState() => _ListInternState();
}

class _ListInternState extends State<ListIntern> {
  Intern interna;

  @override
  void initState() {
    super.initState();
    interna = widget.intern;
    //saveData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      saveData();
    });
    return ListTile(
      title: Text(
        interna.name,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        interna.prefe,
        style: TextStyle(color: Colors.black),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(
          interna.name[0],
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  saveData() async {
    InternSqflite internSqflite = InternSqflite(interna.name, interna.prefe);
    await DatabaseSqflite.instance.saveData(internSqflite);
  }
}
