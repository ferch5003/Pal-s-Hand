import 'package:dio/dio.dart';
import 'package:pals_hand/core/models/product.dart';

class Api {
  final _endpoint = "https://frutiland.herokuapp.com";
  Dio _dio;

  Api() {
    _dio = new Dio();
    _dio.options.baseUrl = _endpoint;
  }

  Future<List<Product>> getProducts({String q, String category}) async {
    try {
      Response response =
          await _dio.get('$_endpoint/search?q=$q&category=$category');
      Iterable iterableProducts = response.data;
      List<Product> productsList = List<Product>.from(
          iterableProducts.map((model) => Product.fromJson(model)));
      return productsList;
    } on DioError catch (error) {
      throw error;
    }
  }
}
