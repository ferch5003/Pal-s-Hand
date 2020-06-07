import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference users = Firestore.instance.collection('users');

  updateUserData({String name, String email, String image}) async {
    final snapShot = await users.document(uid).get();
    if (!snapShot.exists) {
      await users
          .document(uid)
          .setData({'name': name, 'email': email, 'image': image});
    } 
  }
}
