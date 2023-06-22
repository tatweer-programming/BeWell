import 'package:equatable/equatable.dart';

class DoneSection extends Equatable {
  final Map<String, int> progress;
  final Map<String, int> done;
  final String studentName;
  final String lastUsing;
  const DoneSection({
    required this.progress,
    required this.done,
    required this.studentName,
    required this.lastUsing,
  });
  @override
  List<Object?> get props =>
      [done, progress, studentName, lastUsing];
}
