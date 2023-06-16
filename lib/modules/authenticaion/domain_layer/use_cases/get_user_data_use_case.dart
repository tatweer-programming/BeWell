import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_layer/models/user_model.dart';
import '../repsitories/base_auth_repository.dart';

class GetDataUserUseCase {
  final BaseAuthRepository baseAuthRepository;
  GetDataUserUseCase(this.baseAuthRepository);
  Future<Either<FirebaseException, UserModel>> get() async {
    return await baseAuthRepository.getDataUser();
  }
}
