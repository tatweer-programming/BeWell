import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class AppUser extends Equatable {
  final String name;
  final String email;
  final String id;
  final String uid;

  const AppUser({
    required this.name,
    required this.email,
    required this.id,
    required this.uid,
  });
  @override
  List<Object?> get props => [name, email, uid,id];
}
