import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../data_layer/models/user_model.dart';
import '../../domain_layer/use_cases/change_pass_use_case.dart';
import '../../domain_layer/use_cases/forget_password_usecase.dart';
import '../../domain_layer/use_cases/get_user_data_use_case.dart';
import '../../domain_layer/use_cases/login_with_email&pass_usecase.dart';
import '../../domain_layer/use_cases/send_auth_request_use_case.dart';
import '../../domain_layer/use_cases/update_user_data_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);
  List<Widget> pages = [

  ];
  int currentIndex = 0;
  Widget currentPages = const Scaffold();
  UserModel? userModel;

  /// change old password visibility
  bool newVisibility = true;
  IconData newSuffix = Icons.visibility_off;
  TextInputType newType = TextInputType.visiblePassword;
  /// change old password visibility
  bool oldVisibility = true;
  IconData oldSuffix = Icons.visibility_off;
  TextInputType oldType = TextInputType.visiblePassword;
  void changeVisibility() {
    newVisibility = !newVisibility;
    newSuffix =
        !newVisibility ? Icons.visibility : Icons.visibility_off;
    newType =
        !newVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }
  void oldChangeVisibilityVoid() {
    oldVisibility = !oldVisibility;
    oldSuffix = !oldVisibility ? Icons.visibility : Icons.visibility_off;
    oldType =
    !oldVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }


  bool isShowLoading = false;
  void changeLoading(bool flag) {
    if(flag) {
      isShowLoading = true;
    }else{
      isShowLoading = false;
    }
  }

  AuthBloc(AuthInitial authInitial) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      /// logic
      if (event is ChangeButtonAuthenticationEvent) {
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeButtonAuthState(index: event.index));
      }

      else if (event is ChangeVisibilityEvent) {
        changeVisibility();
        emit(ChangeVisibilityState(isVisible: newVisibility));
      }
      else if (event is OldChangeVisibilityEvent) {
        oldChangeVisibilityVoid();
        emit(OldChangeVisibilityState(isVisible: oldVisibility));
      }

      /// firebase
      else if (event is LoginEvent) {
        emit(const LoginLoadingAuthState());
        final result = await LoginWithEmailAndPassUseCase(sl()).excute(
          email: event.email,
          password: event.password,
        );
        await result.fold((l) {
         // errorToast(msg: "تأكد من البيانات وحاول مرة اخري");
          emit(const LoginErrorAuthState());
        }, (r) async{
          add(const GetMyDataEvent());
          emit(LoginSuccessfulAuthState(context: event.context));
        });
      }
      else if (event is ForgetPasswordAuthEvent) {
        final result = await ForgetPasswordUseCase(sl())
            .excute(email: event.email);
        result.fold((l) {
          emit(SendEmailErrorAuthState());
         // errorToast(msg: "تأكد من الإيميل ");
        }, (r) {
          emit(SendEmailSuccessfulAuthState());
        });
      }
      else if (event is GetMyDataEvent) {
        emit(GetMyDataLoadingState());
        final result = await GetDataUserUseCase(sl()).get();
        result.fold((l) {}, (r) async {
          userModel = r;
          emit(GetMyDataSuccessState());
          await CacheHelper.saveData(key: 'studentName', value: userModel!.name);
        });
      }
      else if (event is UpdateMyDataEvent) {
        final result = await UpdateDataUserUseCase(sl()).update(
            name: event.name,
            oldPassword: event.oldPassword,
            id: event.parentPhone,
            email: event.email);
        result.fold((l) {
        //  errorToast(msg: l.message!);
          emit(UpdateMyDataErrorState());
        }, (r) {
         // defaultToast(msg: "تم تحديث البيانات بنجاح");
          NavigationManager.pop(event.context);
          emit(UpdateMyDataSuccessState(context: event.context));
        });
      }
      else if (event is ChangePassEvent) {
        final result = await ChangePasswordUseCase(sl()).change(
            oldPassword: event.oldPassword, newPassword: event.newPassword);
        result.fold((l) {
          //errorToast(msg: l.message!);
        }, (r) {
          //defaultToast(msg: "تم تغير كلمة السر بنجاح");
          NavigationManager.pop(event.context);
          emit(ChangePassScreenSuccessState(context:event.context));
        });
      }
      /// Navigation
      else if (event is NavigationToChangePassScreenEvent) {
        NavigationManager.push(event.context, const Scaffold());
        emit(NavigationToChangePassScreenState(context:event.context));
      }
      else if (event is NavigationToRegisterScreenEvent) {
        NavigationManager.pushPage(event.context, const Scaffold());
        emit(NavigationToRegisterScreenState(context:event.context));
      }
      else if (event is NavigationToLoginScreenEvent) {
        NavigationManager.pushPage(event.context, const Scaffold());
        Future.delayed(const Duration(seconds: 1),(){
        });
        emit(NavigationToLoginScreenState(context:event.context, isGrade: true, ));
      }
      else if (event is NavigationToForgetPasswordScreenEvent) {
        NavigationManager.pushPage(event.context, const Scaffold());
        emit(NavigationToForgetPasswordState(context:event.context));
      }
      /// animation
      else if (event is ChangeIsLoadingEvent){
        changeLoading(event.flag);
        emit(ChangeIsLoadingState(isShowLoading: isShowLoading));
      }

      // else if (event is TimerEvent){
      //   startTimer(event.seconds);
      // }
    });
  }
}
