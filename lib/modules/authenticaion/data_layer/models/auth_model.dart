import '../../domain_layer/entities/auth.dart';

//ignore: must_be_immutable
class AuthModel extends Auth {
  AuthModel({required String uid, required String token})
      : super(uid: uid, token: token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(uid: json['uid'], token: json['token']);
  }
}
