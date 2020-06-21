import 'package:cloud_firestore/cloud_firestore.dart';

class Intern {
  Intern({
    this.id,
    this.name,
    this.prefe,
  });

  Intern.fromFirestore(Map snapshot, DocumentReference documentReference)
      : id = documentReference.documentID,
        name = snapshot["name"] ?? '',
        prefe = snapshot["hobby"] ?? '';

  String id;
  String name;
  String prefe;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["name"] = name;
    map["hobby"] = prefe;
    return map;
  }
}

class InternSqflite {
  //String id;
  String name;
  String prefe;

  InternSqflite(
    /* this.id, */ this.name,
    this.prefe,
  );

  InternSqflite.fromMap(snap) {
    //this.id = snap["id"];
    this.name = snap["name"];
    this.prefe = snap["hobby"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    //map["id"] = id;
    map["name"] = name;
    map["hobby"] = prefe;
    return map;
  }

  String get getName => name;
  String get getUsername => prefe;
}
