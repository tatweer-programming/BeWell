import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_auth_repository.dart';

class SendAuthRequestUseCase  {
  final BaseAuthRepository baseAuthRepository;

  SendAuthRequestUseCase (this.baseAuthRepository);
  Future<Either<FirebaseException, String>> call ({required String email, required String password,
    required String id, required String name})  async {
    print(2);
    return await baseAuthRepository.sendAuthRequest
      (email: email, password: password, id: id, name: name);
  }
}
