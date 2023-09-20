import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:suga_core/suga_core.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Model {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "deactivated_at")
  final DateTime? deactivatedAt;

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.deactivatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJsonString(String jsonString) => User.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object?> get props => [id];
}
