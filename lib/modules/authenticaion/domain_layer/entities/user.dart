import 'package:equatable/equatable.dart';
class AppUser extends Equatable {
  final String name;
  final String email;
  String id;

   AppUser({
    required this.name,
    required this.email,

   required this.id,
  });
  @override
  List<Object?> get props => [name,email, id ];

}