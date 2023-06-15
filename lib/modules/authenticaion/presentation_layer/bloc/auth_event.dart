part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ChangeButtonAuthenticationEvent extends AuthEvent {
  final int index;

  const ChangeButtonAuthenticationEvent({required this.index});
  @override
  List<Object?> get props => [index];
}
//ignore: must_be_immutable
class LoginEvent extends AuthEvent {
  String email;
  String password;
  final BuildContext context;
  LoginEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}

class SendAuthRequestEvent extends AuthEvent {
  final String email;
  final String password;
  final String id;

  final String name;
  final BuildContext context;
  const SendAuthRequestEvent(
      {required this.context,
      required this.id,
      required this.password,
      required this.email,
      required this.name});

  @override
  List<Object?> get props => [];
}
//ignore: must_be_immutable
class CheckEmailEvent extends AuthEvent {
  String email;
  CheckEmailEvent(this.email);
  @override
  List<Object?> get props => [email];
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

class ConfirmChangeVisibilityEvent extends AuthEvent {
  const ConfirmChangeVisibilityEvent();
  @override
  List<Object?> get props => [];
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

  const ChangePassEvent(
      {required this.newPassword,
      required this.oldPassword,
      required this.context});
  @override
  List<Object?> get props => [newPassword, oldPassword, context];
}

class UpdateMyDataEvent extends AuthEvent {
  final String phone;
  final String address;
  final String name;
  final String oldPassword;
  final String email;
  final BuildContext context;
  const UpdateMyDataEvent({
    required this.email,
    required this.address,
    required this.phone,
    required this.name,
    required this.oldPassword,
    required this.context,
  });
  @override
  List<Object?> get props => [phone, address, name, email, context];
}

class NavigationToChangePassScreenEvent extends AuthEvent {
  final BuildContext context;
  const NavigationToChangePassScreenEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
