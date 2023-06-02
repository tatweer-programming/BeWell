import '../../domain_layer/entities/user.dart';

class UserModel extends AppUser {
   UserModel({required String email,required String id,  required String name ,required String phone}) :
         super(name: name ,email: email ,  id: id, phone: phone);


   factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], id: json['id'], name: json['name'], phone: json['phone']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email': email,
    };
  }
}
