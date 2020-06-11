import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../base_model.dart';

class ShoppingViewModel extends BaseModel {
  bool _ready = false;

  bool get ready => _ready;

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> data = Map<String, dynamic>();

    FirebaseUser authUser = await FirebaseAuth.instance.currentUser();
    User user = User.fromJson(
        (await DatabaseService(uid: authUser.uid).getUser()).data);
    User friend = user.friendList == ''
        ? null
        : User.fromJson(
            (await DatabaseService(uid: user.friendList).getUser()).data);

    bool ready = await DatabaseService(uid: authUser.uid).getReady();

    List<Product> myProds = List<Product>();
    List<Product> friendProds = List<Product>();

    QuerySnapshot myProdSnapshot =
        await DatabaseService(uid: user.uid).getProducts();
    QuerySnapshot friendProdSnapshot = user.friendList == ''
        ? null
        : await DatabaseService(uid: user.uid).getFriendList();

    myProds = myProdSnapshot.documents
        .map((product) => Product.fromJson(product.data))
        .toList();
    friendProds = user.friendList == ''
        ? null
        : friendProdSnapshot.documents
            .map((product) => Product.fromJson(product.data))
            .toList();

    data = {
      'user': user,
      'friend': friend,
      'myProds': myProds,
      'friendProds': friendProds,
      'ready': ready
    };

    return data;
  }

  updateView() {
    setState(ViewState.Idle);
  }
}
