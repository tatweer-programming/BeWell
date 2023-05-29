part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

/// logic
class ChangeButtonAuthState extends AuthState {
  final int index;
  const ChangeButtonAuthState({required this.index});

  @override
  List<Object> get props => [index];
}

class ChooseIndexGradeState extends AuthState {
  final int index;
  const ChooseIndexGradeState({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeVisibilityState extends AuthState {
  final bool isVisible;
  const ChangeVisibilityState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class ChangeIsGradeState extends AuthState {
  final bool isGrade;
  const ChangeIsGradeState({required this.isGrade});
  @override
  List<Object> get props => [isGrade];
}

class OldChangeVisibilityState extends AuthState {
  final bool isVisible;
  const OldChangeVisibilityState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class ChangeIsLoadingState extends AuthState {
  final bool isShowLoading;
  const ChangeIsLoadingState({
    required this.isShowLoading,
  });
  @override
  List<Object?> get props => [isShowLoading];
}

/// firebase
// register
class RegisterErrorAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingAuthState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterSuccessAuthState extends AuthState {
  final String uid;
  final BuildContext context;
  const RegisterSuccessAuthState({required this.context, required this.uid});
  @override
  List<Object?> get props => [context];
}

// login
class LoginLoadingAuthState extends AuthState {
  const LoginLoadingAuthState();
  @override
  List<Object?> get props => [];
}

class LoginSuccessfulAuthState extends AuthState {
  final BuildContext context;
  const LoginSuccessfulAuthState(
      {required this.context,});
  @override
  List<Object?> get props => [context];
}

class LoginErrorAuthState extends AuthState {

  const LoginErrorAuthState();
  @override
  List<Object?> get props => [];
}

// forget password
class SendEmailSuccessfulAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SendEmailErrorAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

// update
class UpdateMyDataSuccessState extends AuthState {
  final BuildContext context;
  const UpdateMyDataSuccessState({required this.context});
  @override
  List<Object?> get props => [];
}

class UpdateMyDataErrorState extends AuthState {
  @override
  List<Object?> get props => [];
}

class GetMyDataSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class GetMyDataLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

// change pass
class ChangePassScreenSuccessState extends AuthState {
  final BuildContext context;
  const ChangePassScreenSuccessState({required this.context});
  @override
  List<Object?> get props => [context];
}

class ChangePassScreenErrorState extends AuthState {
  final BuildContext context;
  const ChangePassScreenErrorState({required this.context});
  @override
  List<Object?> get props => [context];
}

/// animation
class CheckState extends AuthState {

  const CheckState();
  @override
  List<Object?> get props =>
      [];
}

class ConfettiState extends AuthState {

  const ConfettiState();
  @override
  List<Object?> get props => [];
}

/// Navigation
class NavigationToChangePassScreenState extends AuthState {
  final BuildContext context;
  const NavigationToChangePassScreenState({required this.context});
  @override
  List<Object?> get props => [context];
}

class NavigationToRegisterScreenState extends AuthState {
  final BuildContext context;
  const NavigationToRegisterScreenState({required this.context});
  @override
  List<Object?> get props => [context];
}

class NavigationToLoginScreenState extends AuthState {
  final BuildContext context;
  final bool isGrade;
  const NavigationToLoginScreenState(
      {required this.context, required this.isGrade});
  @override
  List<Object?> get props => [context, isGrade];
}

class NavigationToForgetPasswordState extends AuthState {
  final BuildContext context;
  const NavigationToForgetPasswordState({required this.context});
  @override
  List<Object?> get props => [context];
}
