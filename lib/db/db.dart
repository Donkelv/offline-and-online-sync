import 'package:Internashala/db/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Future addDetails(String name, String pref) async {
    await _db.collection("intern-data").document().setData({
      "name": name,
      "hobby": pref,
    });
  }

  Stream<List<Intern>> streamIntern() {
    final snap = _db.collection("intern-data").snapshots();
    return snap.map((event) => event.documents
        .map((e) => Intern.fromFirestore(e.data, e.reference))
        .toList());
  }
}
