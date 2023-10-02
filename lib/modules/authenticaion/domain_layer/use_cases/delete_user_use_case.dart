import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_auth_repository.dart';

class DeleteUserUseCase {
  final BaseAuthRepository baseAuthRepository;
  DeleteUserUseCase(this.baseAuthRepository);
  Future<Either<FirebaseAuthException, bool>> delete({
    required String email,
    required String password,
  }) async {
    return await baseAuthRepository.deleteUser(email: email,password: password);
  }
}
