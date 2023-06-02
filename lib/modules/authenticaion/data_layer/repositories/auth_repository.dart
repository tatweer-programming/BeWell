import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BeWell/modules/authenticaion/data_layer/models/user_model.dart';
import '../../domain_layer/repsitories/base_auth_repository.dart';
import '../data_sources/auth_remote_data_sources.dart';

class AuthRepository extends BaseAuthRepository {
  BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  AuthRepository(this.baseAuthRemoteDataSource);
  @override
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password}) async {
    return baseAuthRemoteDataSource.loginWithEmailAndPass(
        email: email, password: password);
  }

  @override
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email}) async {
    return await baseAuthRemoteDataSource.forgetPassword(email: email);
  }

  @override
  Future<Either<FirebaseException, UserModel>> getDataUser() async {
    return await baseAuthRemoteDataSource.getDataUser();
  }

  @override
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String name,
    required String oldPassword,
    required String id,
    required String email,
    required String phone,
  }) async {
    return await baseAuthRemoteDataSource.updateDataUser(
        name: name, oldPassword: oldPassword,email: email ,id: id, phone: phone);
  }

  @override
  Future<Either<FirebaseAuthException, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await baseAuthRemoteDataSource.changePassword(
        newPassword: newPassword, oldPassword: oldPassword);
  }

  @override
  Future<Either<FirebaseException, String>> sendAuthRequest
      ({required String email, required String password,
    required String id, required String studentPhone, required String name}) async {
    return await baseAuthRemoteDataSource.sendAuthRequest
      (email: email, password: password, id: id, studentPhone: studentPhone, name: name);
  }
}
