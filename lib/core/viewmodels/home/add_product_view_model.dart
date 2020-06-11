import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/services/api.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../../../locator.dart';
import '../base_model.dart';

class AddProductViewModel extends BaseModel {
  Api _api = locator<Api>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  String _category = '';
  String _q = '';
  String _selectedDropdown = 'Categoria';
  List<Product> _products = List<Product>();

  List<Product> get products => _products;
  String get selectedDropdown => _selectedDropdown;

  changeCategory(String selectedCategory) {
    setState(ViewState.Busy);
    _selectedDropdown = selectedCategory;
    if (selectedCategory == 'Categoria') selectedCategory = '';

    _category = selectedCategory.toUpperCase();
    setState(ViewState.Idle);
  }

  searchProducts(String q) {
    setState(ViewState.Busy);

    _q = q;

    setState(ViewState.Idle);
  }

  addProduct(Product product) async {
    setState(ViewState.Busy);
    product.quantity = 1;
    FirebaseUser user = await _authenticationService.user.currentUser();
    await DatabaseService(uid: user.uid).addProductData(product: product);
    setState(ViewState.Idle);
  }

  Future<List<Product>> getProducts() async {
    try {
      FirebaseUser user = await _authenticationService.user.currentUser();
      QuerySnapshot snapshot =
          await DatabaseService(uid: user.uid).getProducts();

      List<Product> userProducts = snapshot.documents
          .map((product) => Product.fromJson(product.data))
          .toList();

      List<String> productsName = userProducts.map((product) => product.name).toList();

      List<Product> products =
          await _api.getProducts(q: _q, category: _category);

      products.removeWhere((product) => productsName.contains(product.name));

      _products = products;
    } catch (error) {}
    return _products;
  }
}
