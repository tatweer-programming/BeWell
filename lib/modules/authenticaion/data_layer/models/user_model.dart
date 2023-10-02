import '../../domain_layer/entities/user.dart';

//ignore: must_be_immutable
class UserModel extends AppUser {
  UserModel({
    required String email,
    required String id,
    required String uid,
    required String name,
  }) : super(
          name: name,
          email: email,
          id: id,
          uid: uid,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'uid': uid,
      'email': email,
    };
  }
}
