import 'package:Internashala/db/sqlDb.dart';
import 'package:Internashala/pages/retrieveData.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'pages/retrieveData.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  DatabaseSqflite.instance.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConnectivityUtils.initialize(
        serverToPing:
            "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt",
        callback: (response) => response.contains("This is a test!"));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internashala Test',
      theme: ThemeData(
        fontFamily: "montserrat",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        Retrieve.routeName: (context) => Retrieve(),
      },
    );
  }
}
