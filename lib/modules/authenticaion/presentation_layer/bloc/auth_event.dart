part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

/// firebase
class LoginEvent extends AuthEvent {
  String email;
  String password;
  final context;
  LoginEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String grade;
  final String studentPhone;
  final String parentPhone;
  final BuildContext context;
  const RegisterEvent(
      {required this.email,
      required this.password,
      required this.studentPhone,
      required this.parentPhone,
      required this.grade,
      required this.name,
      required this.context});
  @override
  List<Object?> get props => [email, password,studentPhone, parentPhone ,context,grade];
}
class ForgetPasswordAuthEvent extends AuthEvent {
  final String email;
  const ForgetPasswordAuthEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
class GetMyDataEvent extends AuthEvent {
  const GetMyDataEvent();
  @override
  List<Object?> get props => [];
}
class ChangePassEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final BuildContext context;

  const ChangePassEvent({required this.newPassword,required this.oldPassword,required this.context});
  @override
  List<Object?> get props => [newPassword,oldPassword,context];
}
class UpdateMyDataEvent extends AuthEvent {
  final String name;
  final String oldPassword;
  final String email;
  final String studentPhone;
  final String parentPhone;
  final BuildContext context;
  const UpdateMyDataEvent({
    required this.email,
    required this.name,
    required this.oldPassword,
    required this.parentPhone,
    required this.studentPhone,
    required this.context,
});
  @override
  List<Object?> get props => [name,parentPhone,studentPhone,email,context];
}

/// Navigation
class NavigationToChangePassScreenEvent extends AuthEvent {
  final BuildContext context;
  const NavigationToChangePassScreenEvent(
      {required this.context});

  @override
  List<Object?> get props => [context];
}
class NavigationToForgetPasswordScreenEvent extends AuthEvent {
  final BuildContext context;
  const NavigationToForgetPasswordScreenEvent(
      {required this.context});
  @override
  List<Object?> get props => [context];
}
class NavigationToRegisterScreenEvent extends AuthEvent {
  final BuildContext context;
  const NavigationToRegisterScreenEvent(
      {required this.context});

  @override
  List<Object?> get props => [context];
}
class NavigationToLoginScreenEvent extends AuthEvent {
  final BuildContext context;
  const NavigationToLoginScreenEvent(
      {required this.context});
  @override
  List<Object?> get props => [context];
}

/// logic
class ChooseIndexGradeEvent extends AuthEvent {
  final int index;
  const ChooseIndexGradeEvent({required this.index});
  @override
  List<Object?> get props => [index];
}
class ChangeIsGradeEvent extends AuthEvent {
  final bool flag;
  const ChangeIsGradeEvent(this.flag);
  @override
  List<Object?> get props => [flag];
}
class ChangeIsLoadingEvent extends AuthEvent {
  final bool flag;
  const ChangeIsLoadingEvent(this.flag);
  @override
  List<Object?> get props => [flag];
}
class ChangeVisibilityEvent extends AuthEvent {
  const ChangeVisibilityEvent();
  @override
  List<Object?> get props => [];
}
class OldChangeVisibilityEvent extends AuthEvent {
  const OldChangeVisibilityEvent();
  @override
  List<Object?> get props => [];
}
class ChangeButtonAuthenticationEvent extends AuthEvent {
  final int index;
  const ChangeButtonAuthenticationEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

/// animation
class CheckEvent extends AuthEvent {

  const CheckEvent();
  @override
  List<Object?> get props => [];
}
class ConFettiEvent extends AuthEvent {

  const ConFettiEvent();
  @override
  List<Object?> get props => [];
}
