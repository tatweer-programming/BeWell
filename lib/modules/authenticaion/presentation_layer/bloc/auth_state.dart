part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangeButtonAuthState extends AuthState {
  final int index;
  const ChangeButtonAuthState({required this.index});
  @override
  List<Object> get props => [index];
}

class ChangeVisibilityState extends AuthState {
  final bool isVisible;
  const ChangeVisibilityState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class OldChangeVisibilityState extends AuthState {
  final bool isVisible;
  const OldChangeVisibilityState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class ConfirmChangeVisibilityState extends AuthState {
  final bool isVisible;
  const ConfirmChangeVisibilityState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

/// register states

class SendAuthRequestLoadingAuthState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//ignore: must_be_immutable
class SendAuthRequestSuccessfulState extends AuthState {
  String uid;
  BuildContext context;
  SendAuthRequestSuccessfulState({required this.context, required this.uid});
  @override
  List<Object?> get props => [context];
}

class SendAuthRequestErrorAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

//ignore: must_be_immutable
class RegisterPhaseOneSuccessfulAuthState extends AuthState {
  BuildContext context;
  RegisterPhaseOneSuccessfulAuthState({required this.context});
  @override
  List<Object?> get props => [context];
}

/// login states

class LoginLoadingAuthState extends AuthState {
  const LoginLoadingAuthState();
  @override
  List<Object?> get props => [];
}

//ignore: must_be_immutable
class LoginSuccessfulAuthState extends AuthState {
  String uid;
  BuildContext context;
  LoginSuccessfulAuthState({required this.context, required this.uid});
  @override
  List<Object?> get props => [context];
}

class LoginErrorAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

/// forget password states

class SendEmailSuccessfulAuthState extends AuthState {
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

class NavigationToChangePassScreenState extends AuthState {
  final BuildContext context;
  const NavigationToChangePassScreenState({required this.context});
  @override
  List<Object?> get props => [context];
}

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
