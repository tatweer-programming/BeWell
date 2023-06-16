import 'package:BeWell/modules/authenticaion/domain_layer/entities/request.dart';

//ignore: must_be_immutable
class RequestModel extends Request {
  RequestModel(
      {required super.name,
      required super.email,
      required super.id,
      required super.password});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "id": id,
      'password': password,
    };
  }
}
