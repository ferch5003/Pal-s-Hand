import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../base_model.dart';

class ShoppingViewModel extends BaseModel {
  bool _ready = false;

  bool get ready => _ready;

  Future<List<Map<dynamic, dynamic>>> getMyProducts() async {
    List<Map<dynamic, dynamic>> productsList = List<Map<dynamic, dynamic>>();

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      _ready = await DatabaseService(uid: user.uid).getReady();

      QuerySnapshot snapshot =
          await DatabaseService(uid: user.uid).getProducts();

      productsList = snapshot.documents
          .map((product) => {
                'product': Product.fromJson(product.data),
                'productid': product.documentID
              })
          .toList();
    } catch (error) {}
    return productsList;
  }

  Future<List<Map<dynamic, dynamic>>> getMyFriendProducts() async {
    List<Map<dynamic, dynamic>> productsList = List<Map<dynamic, dynamic>>();

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      _ready = await DatabaseService(uid: user.uid).getReady();

      QuerySnapshot snapshot =
          await DatabaseService(uid: user.uid).getFriendList();

      productsList = snapshot.documents
          .map((product) => {
                'product': Product.fromJson(product.data),
                'productid': product.documentID
              })
          .toList();
    } catch (error) {}

    return productsList;
  }

  Future<QuerySnapshot> getAllUsersData() async {
    QuerySnapshot userData;

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      _ready = await DatabaseService(uid: user.uid).getReady();

      QuerySnapshot snapshot = await DatabaseService().getUsers();

      userData = snapshot;
    } catch (error) {}
    return userData;
  }

  deleteAllProducts(uid, name, email, image) async {
    try {
      _ready = await DatabaseService(uid: uid).getReady();

      if(_ready){
        await DatabaseService(uid: uid).deleteAllProducts();
        await DatabaseService(uid: uid).updateUserData(name: name, email: email, image: image);
      }
    } catch (error) {}
  }

}
