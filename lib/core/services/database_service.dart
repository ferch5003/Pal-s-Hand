import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pals_hand/core/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference users = Firestore.instance.collection('users');

  Future<QuerySnapshot> getUsers() async {
    return await users.getDocuments();
  }

  updateUserData(
      {@required String name,
      @required String email,
      @required String image}) async {
    final snapShot = await users.document(uid).get();
    if (!snapShot.exists) {
      await users.document(uid).setData({
        'name': name,
        'email': email,
        'image': image,
        'uid': uid,
        'friend_list': '',
        'total': 0.0,
        'ready': false
      });
    }
  }

  Future<bool> getReady() async {
    return (await users.document(uid).get())['ready'];
  }

  Future<QuerySnapshot> getProducts() async {
    return await users.document(uid).collection('products').getDocuments();
  }

  addProductData({@required Product product}) async {
    await users
        .document(uid)
        .updateData({'total': FieldValue.increment(product.price)});
    await users.document(uid).collection('products').add(product.toJson());
  }

  updateProductData(
      {@required String productId,
      @required Product product,
      @required int factor}) async {
    await users
        .document(uid)
        .updateData({'total': FieldValue.increment(factor * product.price)});
    await users
        .document(uid)
        .collection('products')
        .document(productId)
        .updateData({'quantity': FieldValue.increment(factor)});
  }

  deleteProduct({@required String productId, @required Product product}) async {
    await users.document(uid).updateData({
      'total': FieldValue.increment(-1 * (product.quantity * product.price))
    });
    await users
        .document(uid)
        .collection('products')
        .document(productId)
        .delete();
  }

  Future<QuerySnapshot> getFriendList() async {
    DocumentSnapshot list = await users.document(uid).get();
    String frienduid = list.data['friend_list'];
    return await users
        .document(frienduid)
        .collection('products')
        .getDocuments();
  }

  addFriendListData({@required String frienduid}) async {
    await users.document(uid).setData({'friend_list': frienduid});
  }

  updateFriendListData({@required String frienduid}) async {
    DocumentSnapshot user = await users.document(uid).get();
    String lastFriendUid = user.data['friend_list'];
    String updateUser = uid;
    String updateFriend = frienduid;
    if (lastFriendUid != '') {
      if (lastFriendUid == frienduid) {
        updateUser = '';
        updateFriend = '';
      } else {
        await users.document(lastFriendUid).updateData({'friend_list': ''});
      }
    }
    await users.document(uid).updateData({'friend_list': updateFriend});
    await users.document(frienduid).updateData({'friend_list': updateUser});
  }
}
