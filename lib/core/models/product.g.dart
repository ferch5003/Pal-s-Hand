// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    category: json['category'] as String,
    quantity: (json['quantity'] as num)?.toInt(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'quantity': instance.quantity,
    };
