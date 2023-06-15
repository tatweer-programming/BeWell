// ignore_for_file: void_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:BeWell/modules/authenticaion/data_layer/models/request_model.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';
import '../models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
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
    if (kDebugMode) {
      print(
          "forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword");
    }
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
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid)
            .then((value) async {
          ConstantsManager.userId = await CacheHelper.getData(key: 'uid');
          await FirebaseFirestore.instance
              .collection('users')
              .doc("8a1la2MLXpTYy9Kt6H9a")
              .get()
              .then((value) {
            ConstantsManager.appUser = UserModel.fromJson(value.data()!);
          });
          await CacheHelper.saveData(
                  key: 'studentName', value: ConstantsManager.appUser!.name)
              .then((value) async {
            ConstantsManager.studentName =
                await CacheHelper.getData(key: 'studentName');
          });
        });
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, String>> sendAuthRequest(
      {required String email,
      required String password,
      required String id,

      required String name}) async {
    try {
      RequestModel request =
          RequestModel(name: name, email: email, id: id, password: password);
      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson());
      return right('تم ارسال طلب الانضمام');
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
}
