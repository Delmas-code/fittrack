import 'package:hive/hive.dart';

part 'step_model.g.dart';

@HiveType(typeId: 1)
class StepLog extends HiveObject {
  @HiveField(0)
  final String dateId; // Format YYYY-MM-DD

  @HiveField(1)
  final int count;

  @HiveField(2)
  final int target;

  StepLog({
    required this.dateId,
    required this.count,
    this.target = 6000,
  });
}