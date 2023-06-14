import 'package:equatable/equatable.dart';

import 'daily_reminder.dart';

class DoneSection extends Equatable{
  final Map<String,dynamic> progress;
  final Map<String,int> done;
  final String studentName;
  final List<DailyReminder> dailyReminder;
  final String lastUsing;
  const DoneSection({
    required this.progress,
    required this.done,
    required this.studentName,
    required this.lastUsing,
    required this.dailyReminder,
  });
  @override
  List<Object?> get props => [done,progress,studentName,lastUsing,dailyReminder];
}
