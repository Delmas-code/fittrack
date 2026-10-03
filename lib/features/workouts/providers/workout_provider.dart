import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/workout_model.dart';
import 'package:uuid/uuid.dart';

class WorkoutNotifier extends AsyncNotifier<List<Workout>>{
  static const String _boxName = "workoutsBox";

  @override
  Future<List<Workout>> build() async {
    return _fetchWorkouts();
  }

  Future<List<Workout>> _fetchWorkouts() async {
    final box = await Hive.openBox<Workout>(_boxName);
  //   sort by date descending (newest first)
    final workouts = box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return workouts;
  }

  Future<void> addWorkout({
    required String discipline,
    required String exerciseName,
    required int sets,
    required int reps,
    double? weight,
  }) async {
    //set state to loading while we write in the DB
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final box = await Hive.openBox<Workout>(_boxName);

      final newWorkout = Workout(
          id: const Uuid().v4(),
          discipline: discipline,
          exerciseName: exerciseName,
          sets: sets,
          reps: reps,
          weight: weight,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()
      );

      await box.put(newWorkout.id, newWorkout);

    //   return updated list of workouts
      return _fetchWorkouts();
    });
  }
}

//The Provider we will watch from the UI
final workoutProvider = AsyncNotifierProvider<WorkoutNotifier, List<Workout>>(() {
  return WorkoutNotifier();
});