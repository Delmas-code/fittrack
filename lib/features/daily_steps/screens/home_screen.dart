import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/step_provider.dart';
import '../../workouts/providers/workout_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepAsync = ref.watch(dailyStepsNotifierProvider);
    final workoutAsync = ref.watch(workoutProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEader
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's Activity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xFFDBEAFE),
                      child: const Text(
                        'AG',
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),

              //   Steps Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: stepAsync.when(
                    data: (stepLog) {
                      final progress = (stepLog.count / stepLog.target).clamp(0.0, 1.0);
                      return Row(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 8,
                                  backgroundColor: const Color(0xFFE5E7EB),
                                  color: const Color(0xFF10B981),
                                ),
                                Text(
                                  '${(stepLog.count / 1000).toStringAsFixed(1)}k',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily Steps',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color(0xFF111827)
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Text(
                                'Target: ${stepLog.target} steps',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],

                          )
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator(),),
                    error: (err, stack) => Text('Error: $err')
                  ),
                ),
                const SizedBox(height: 24,),
                const Text(
                  'Recent Workouts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827)
                  ),
                ),
                const SizedBox(height: 12,),
              //   Workout History
                workoutAsync.when(
                    data: (workouts) {
                      if (workouts.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          alignment: Alignment.center,
                          child: const Text(
                            'No Workouts logged yet today',
                            style: TextStyle(color: Color(0xFF6B7280)),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          final item = workouts[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFE5E7EB)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDBEAFE),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Icon(
                                    Icons.fitness_center_rounded,
                                    color: Color(0xFF2563EB),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16,),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.exerciseName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                        Text(
                                          '${item.discipline} • ${item.sets} sets ${item.weight != null ?  "• ${item.weight}kg": ""} ',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF6B7280),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0xFF9CA3AF),
                                  size: 18,
                                )
                              ],
                            ),
                          );
                        }
                      );
                    },
                    error: (err, stack) => Text('Error loading workouts: ${err}'),
                    loading: () => CircularProgressIndicator())
              ],
            ),
          )
      ),
    );
  }

}