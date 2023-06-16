import 'package:equatable/equatable.dart';

class DailyReminder extends Equatable {
  final String title;
  final String image;
  const DailyReminder({
    required this.image,
    required this.title,
  });
  @override
  List<Object?> get props => [image, title];
}
