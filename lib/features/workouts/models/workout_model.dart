import 'package:hive/hive.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 0)
class Workout extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String discipline;

  @HiveField(2)
  final String exerciseName;

  @HiveField(3)
  final int sets;

  @HiveField(4)
  final int reps;

  @HiveField(5)
  final double? weight;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime modifiedAt;

  Workout({
    required this.id,
    required this.discipline,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    this.weight,
    required this.createdAt,
    required this.modifiedAt
  });
}