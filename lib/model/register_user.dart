import 'package:json_annotation/json_annotation.dart';

part 'register_user.g.dart';

@JsonSerializable()
class RegisterUser {
  RegisterUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.address,
  });

  String id;
  String name;
  String email;
  String phone;
  String password;
  String confirmPassword;
  String address;
  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterUserToJson(this);
}
