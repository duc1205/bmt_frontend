import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:suga_core/suga_core.dart';

part 'club.g.dart';

@JsonSerializable()
class Club extends Model {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "ownerId")
  final String ownerId;
  @JsonKey(name: "avatar_path")
  final String? avatarPath;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  //relations
  @JsonKey(name: "owner")
  final User? user;

  const Club({
    required this.id,
    required this.name,
    required this.ownerId,
    this.avatarPath,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  factory Club.fromJsonString(String jsonString) => Club.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ClubToJson(this);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object?> get props => [id];
}
