import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_layer/models/user_model.dart';

abstract class BaseAuthRepository {
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password});
  Future<Either<FirebaseException, String>> sendAuthRequest(
      {required String email,
        required String password,
        required String id,
        required String name});
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email});
  Future<Either<FirebaseException, UserModel>> getDataUser();
  Future<Either<FirebaseAuthException, void>> updateDataUser(
      {required String name,
        required String oldPassword,
        required String id,
        required String email,

      });

  Future<Either<FirebaseAuthException, void>> changePassword(
      {required String oldPassword, required String newPassword});
}
