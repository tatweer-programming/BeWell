import 'package:BeWell/core/error/remote_error.dart';
import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/modules/authenticaion/domain_layer/use_cases/send_auth_request_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../main/presentation_layer/screens/courses_screen.dart';
import '../../data_layer/models/user_model.dart';
import '../../domain_layer/use_cases/change_pass_use_case.dart';
import '../../domain_layer/use_cases/forget_password_usecase.dart';
import '../../domain_layer/use_cases/get_user_data_use_case.dart';
import '../../domain_layer/use_cases/login_with_email_and_pass_usecase.dart';
import '../../domain_layer/use_cases/update_user_data_use_case.dart';
import '../components/components.dart';
part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
   bool isValidEmail(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);
  List<Widget> pages = [];
  int currentIndex = 0;
  Widget currentPages = const Scaffold();
  UserModel? userModel;

  /// change old password visibility
  bool newVisibility = false;
  IconData newSuffix = Icons.visibility;
  TextInputType newType = TextInputType.visiblePassword;
  /// change old password visibility
  bool oldVisibility = false;
  IconData oldSuffix = Icons.visibility;
  TextInputType oldType = TextInputType.visiblePassword;
  void _changeVisibility() {
    newVisibility = !newVisibility;
    newSuffix =
        !newVisibility ? Icons.visibility : Icons.visibility_off;
    newType =
        !newVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }
  void _oldChangeVisibilityVoid() {
    oldVisibility = !oldVisibility;
    oldSuffix = !oldVisibility ? Icons.visibility : Icons.visibility_off;
    oldType =
        !oldVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }


  AuthBloc(AuthInitial authInitial) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is ChangeButtonAuthenticationEvent) {
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeButtonAuthState(index: event.index));
      }
      else if (event is ChangeVisibilityEvent) {
        _changeVisibility();
        emit(ChangeVisibilityState(isVisible: newVisibility));
      }
      else if (event is OldChangeVisibilityEvent) {
        _oldChangeVisibilityVoid();
        emit(OldChangeVisibilityState(isVisible: newVisibility));
      }
      else if (event is LoginEvent) {
        emit(const LoginLoadingAuthState());
        final result = await LoginWithEmailAndPassUseCase(sl()).excute(
          email: event.email,
          password: event.password,
        );
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(LoginErrorAuthState());
        }, (r) async{
          ConstantsManager.userId = await CacheHelper.getData(key: 'uid');
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            if (event.context.mounted) {

              emit(LoginSuccessfulAuthState (
                context: event.context, uid: ConstantsManager.userId!,));
            }
          });
          defaultToast(msg: "تم تسجيل الدخول بنجاح");
        });
      }
      else if (event is SendAuthRequestEvent) {
        print('1');
        emit(SendAuthRequestLoadingAuthState());
        final result = await SendAuthRequestUseCase(sl()).call(
           id: event.id,
            email: event.email,
            password: event.password,
            name: event.name,);
        ConstantsManager.userId = await CacheHelper.getData(key: 'uid') ?? '';
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(SendAuthRequestErrorAuthState());
        }, (r) {
          defaultToast(msg: "تم ارسال طلبك للمراجعة");
          emit(SendAuthRequestSuccessfulState(
              context: event.context, uid: ConstantsManager.userId!));
        });
      }
      else if (event is ForgetPasswordAuthEvent) {
        final result = await ForgetPasswordUseCase(sl())
            .excute(email: event.email);
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
        }, (r) {
          defaultToast(msg: "من فضلك تحقق من الايميل ");
        });
      }
      else if (event is GetMyDataEvent) {
        emit(GetMyDataLoadingState());
        final result = await GetDataUserUseCase(sl()).get();
        result.fold((l) {}, (r) {
          userModel = r;
          emit(GetMyDataSuccessState());
        });
      }
      else if (event is UpdateMyDataEvent) {
        final result = await UpdateDataUserUseCase(sl()).update(

            name: event.name,
            oldPassword: event.oldPassword,
            email: event.email, id: '');
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
          emit(UpdateMyDataErrorState());
        }, (r) {
          defaultToast(msg: "تم تحديث البيانات بنجاح");
          NavigationManager.pop(event.context);
          emit(UpdateMyDataSuccessState(context: event.context));
        });
      }
      else if (event is ChangePassEvent) {
        final result = await ChangePasswordUseCase(sl()).change(
            oldPassword: event.oldPassword, newPassword: event.newPassword);
        result.fold((l) {
          errorToast(msg: ExceptionManager(l).translatedMessage());
        }, (r) {
          defaultToast(msg: "تم تغير كلمة السر بنجاح");
          NavigationManager.pop(event.context);
          emit(ChangePassScreenSuccessState(context:event.context));
        });
      }
      else if (event is NavigationToChangePassScreenEvent) {
        NavigationManager.push(event.context, const Scaffold());
        emit(NavigationToChangePassScreenState(context:event.context));
      }
    });

  }


}
