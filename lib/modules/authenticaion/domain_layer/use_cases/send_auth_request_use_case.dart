import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_auth_repository.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;
  RegisterUseCase(this.baseAuthRepository);
  Future<Either<FirebaseException, String>> call(
      {required String email,
      required String password,
      required String id,
      required String name}) async {
    return await baseAuthRepository.sendAuthRequest(
        email: email, password: password, id: id, name: name);
  }
}
