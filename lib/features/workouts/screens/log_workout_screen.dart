import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/workout_provider.dart';

class LogWorkoutScreen extends ConsumerStatefulWidget{
  const LogWorkoutScreen({super.key});

  @override
  ConsumerState<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends ConsumerState<LogWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _discipline = 'Free-Weights';
  final _exerciseController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      final name = _exerciseController.text.trim();
      final sets = int.parse(_setsController.text);
      final reps = int.parse(_repsController.text);
      final weight = double.tryParse(_weightController.text);

      await ref.read(workoutProvider.notifier).addWorkout(
          discipline: _discipline,
          exerciseName: name,
          sets: sets,
          reps: reps,
          weight: weight,
      );
      _exerciseController.clear();
      _weightController.clear();
      _repsController.clear();
      _setsController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Workout saved to local storage!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log Entry',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827)
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discipline',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8,),
                        DropdownButtonFormField<String>(
                            initialValue: _discipline,
                            decoration: _inputDecoration(),
                            items: ['Free-Weights', 'Calisthenics', 'Core']
                            .map((d) => DropdownMenuItem(value: d, child: Text(d))
                            ).toList(),
                          onChanged: (val) => setState(() => _discipline = val!),
                        ),
                        const SizedBox(height: 16,),
                        const Text(
                          'Exercise Name',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8,),
                        TextFormField(
                          controller: _exerciseController,
                          decoration: _inputDecoration(hint: 'e.g., Hack Squats'),
                          validator: (val) =>
                                val == null || val.isEmpty ? 'Required': null ,
                        ),
                        const SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sets',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8,),
                                    TextFormField(
                                      controller: _setsController,
                                      decoration: _inputDecoration(hint: '0'),
                                      keyboardType: TextInputType.number,
                                      validator: (val) =>
                                       val == null || val.isEmpty ? 'Required': null,
                                    ),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reps',
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8,),
                                    TextFormField(
                                      controller: _repsController,
                                      decoration: _inputDecoration(hint: '0'),
                                      keyboardType: TextInputType.number,
                                      validator: (val) =>
                                          val == null || val.isEmpty ? 'Required' : null,
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Weight (Optional)',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _weightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: _inputDecoration(hint: '0.0 kg'),
                        ),
                        const SizedBox(height: 24,),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _submitData,
                            child: const Text(
                              'Save Workout',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F7F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
      )
    );
  }
}