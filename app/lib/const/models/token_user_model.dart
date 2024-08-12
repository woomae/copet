import 'dart:convert';

class TokenUserModel{
  final String providerId;
  final String email;
  final int userId;
  final int iat;
  final int exp;

  TokenUserModel({
    required this.providerId,
    required this.email,
    required this.userId,
    required this.iat,
    required this.exp
});
  TokenUserModel.fromJson({required Map<String,dynamic> token}):
    providerId = token['provider_id'],
    email = token['email'],
    userId = token['user_id'],
    iat = token['iat'],
    exp = token['exp'];

}