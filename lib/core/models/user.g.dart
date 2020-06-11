// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    image: json['image'] as String,
    name: json['name'] as String,
    ready: json['ready'] as bool,
    total: (json['total'] as num)?.toDouble(),
    uid: json['uid'] as String,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..friendList = json['friend_list'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'image': instance.image,
      'name': instance.name,
      'ready': instance.ready,
      'total': instance.total,
      'uid': instance.uid,
      'products': instance.products,
      'friend_list': instance.friendList,
    };
