import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';
import '../models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password});
  Future<Either<FirebaseException, String>> registerWithEmailAndPass(
      {required String email,
      required String password,
      required String id,
      required String name});
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email});
  Future<Either<FirebaseException, UserModel>> getDataUser();
  Future<Either<FirebaseAuthException, bool>> deleteUser({
    required String email,
    required String password,
  });
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String name,
    required String oldPassword,
    required String id,
    required String email,
  });

  Future<Either<FirebaseAuthException, void>> changePassword(
      {required String oldPassword, required String newPassword});
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<Either<FirebaseAuthException, void>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);
    try {
      user.reauthenticateWithCredential(cred);
      UserCredential authResult = await user.reauthenticateWithCredential(cred);
      if (authResult.user != null) {
        user.updatePassword(newPassword);
      }
      return const Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email}) async {
    try {
      void response =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, UserModel>> getDataUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ConstantsManager.userId)
          .get()
          .then((value) {
        ConstantsManager.appUser = UserModel.fromJson(value.data()!);
      });
      return Right(ConstantsManager.appUser!);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid);
        ConstantsManager.userId = value.user!.uid;
        print(value.user!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ConstantsManager.userId)
            .get()
            .then((value) {
              print(value.data());
          ConstantsManager.appUser = UserModel.fromJson(value.data()!);
        });
        await CacheHelper.saveData(
                key: 'studentName', value: ConstantsManager.appUser!.name);
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, String>> registerWithEmailAndPass(
      {required String email,
      required String password,
      required String id,
      required String name}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) async {
        UserModel userModel = UserModel(email: email, id: id, name: name,uid: value.user!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set(userModel.toJson());
        ConstantsManager.studentName = name;
        ConstantsManager.userId = value.user!.uid;
        await CacheHelper.saveData(
            key: 'studentName', value: name);
        await CacheHelper.saveData(
            key: 'uid', value: value.user!.uid);
      });
      return right('تم إنشاء حساب');
    } on FirebaseException catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String name,
    required String oldPassword,
    required String id,
    required String email,
  }) async {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      id: id,
      uid: ConstantsManager.userId!
    );
    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: oldPassword);
      UserCredential authResult = await user.reauthenticateWithCredential(cred);
      if (user.email! != email) {
        user.updateEmail(email);
      }
      if (authResult.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ConstantsManager.userId)
            .update(userModel.toJson());
      }
      return const Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, bool>> deleteUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (ConstantsManager.userId == value.user!.uid) {
          final user = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(ConstantsManager.userId)
              .delete()
              .then((value) async {
            await CacheHelper.removeData(key: "uid");
            await CacheHelper.removeData(key: "waterCups");
            await CacheHelper.removeData(key: "studentName");
            user!.delete();
          });
        }
        else {
          return const Right(false);
        }
      });
      return const Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
}
