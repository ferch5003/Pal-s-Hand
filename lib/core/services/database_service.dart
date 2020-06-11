import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pals_hand/core/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // Collection reference
  final CollectionReference users = Firestore.instance.collection('users');

  Future<DocumentSnapshot> getUser() async {
    return users.document(uid).get();
  }

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

  deliverReady() async {
    DocumentSnapshot friend = await users.document(uid).get();
    String friendId = friend.data['friend_list'];
    await users.document(uid).updateData({'ready': true});
    await users.document(friendId).updateData({'ready': true});
  }

  deliverFinished() async {
    DocumentSnapshot friend = await users.document(uid).get();
    String friendId = friend.data['friend_list'];
    users.document(uid).collection('products').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    users.document(friendId).collection('products').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
    await users.document(uid).updateData({
      'friend_list': '',
      'ready': false,
      'total': 0.0,
    });
    await users.document(friendId).updateData({
      'friend_list': '',
      'ready': false,
      'total': 0.0,
    });
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

  Future<String> getFriend() async {
    DocumentSnapshot list = await users.document(uid).get();
    return list.data['friend_list'];
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
