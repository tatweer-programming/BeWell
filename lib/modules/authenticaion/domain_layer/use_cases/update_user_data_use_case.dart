import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_auth_repository.dart';

class UpdateDataUserUseCase{
  final BaseAuthRepository baseAuthRepository;
  UpdateDataUserUseCase(this.baseAuthRepository);
  Future<Either<FirebaseException, void>> update({
    required String name,
    required String oldPassword,
    required String id,

    required String email,})async{
    return await baseAuthRepository.updateDataUser(name: name, oldPassword: oldPassword, id: id, email: email,);
  }
}