import 'package:json_annotation/json_annotation.dart';
import 'package:pals_hand/core/models/product.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String email;
  String image;
  String name;
  bool ready;
  double total;
  String uid;
  List<Product> products;

  @JsonKey(name: 'friend_list')
  String friendList;

  User(
      {this.email,
      this.image,
      this.name,
      this.ready,
      this.total,
      this.uid,
      this.products});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
