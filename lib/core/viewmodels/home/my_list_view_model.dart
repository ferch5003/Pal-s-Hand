import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../base_model.dart';

class MyListViewModel extends BaseModel {
  bool _ready = false;

  bool get ready => _ready;

  deleteProduct(Product product, String productId) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    await DatabaseService(uid: user.uid)
        .deleteProduct(productId: productId, product: product);
  }

  changeQuantity(Product product, String productId, int factor) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    await DatabaseService(uid: user.uid).updateProductData(
        productId: productId, product: product, factor: factor);
  }

  Future<List<Map<dynamic, dynamic>>> getProducts() async {
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
}
