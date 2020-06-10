import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
@JsonSerializable()
class Product {
  String name;
  double price;
  String category;
  int quantity;

  Product({this.name, this.price, this.category, this.quantity});
  
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}