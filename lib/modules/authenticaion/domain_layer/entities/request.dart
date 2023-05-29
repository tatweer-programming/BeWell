import 'package:equatable/equatable.dart';

class Request extends Equatable {
  String name ;
  String email ;
  String password ;
  String id ;
  Request({required this.name , required this.email , required this.id , required this.password});
  @override
  List<Object?> get props => [];

}