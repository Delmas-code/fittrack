import 'package:fittrack/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import models
// import 'features/workouts/models/workout_model.dart';
// import 'features/daily_steps/models/step_model.dart';
import 'package:fittrack/features/workouts/models/workout_model.dart';
import 'package:fittrack/features/daily_steps/models/step_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//   Initialize local storage
  await Hive.initFlutter();

//   register generated Hive adapters
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(StepLogAdapter());

  runApp(
    const ProviderScope(
        child: FitnessApp())
  );
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4F7F9),
      ),
      home: const Scaffold(
        body: Center(child: Text('Data Layer Ready')),
      ),
    );
  }
}
