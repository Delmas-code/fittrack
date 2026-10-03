import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/step_model.dart';

class DailyStepsNotifier extends AsyncNotifier<StepLog> {
  static const _boxName = 'stepsBox';

  String get _todayId {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}';
  }

  @override
  Future<StepLog> build() async {
    return _fetchTodaySteps();
  }

  Future<StepLog> _fetchTodaySteps() async {
    final box = await Hive.openBox<StepLog>(_boxName);
    return box.get(_todayId) ?? StepLog(dateId: _todayId, count: 0);
  }

  Future<void> addSteps(int stepsToAdd) async {
    state = await AsyncValue.guard(() async {
      final box = await Hive.openBox<StepLog>(_boxName);
      final currentLog =  box.get(_todayId) ?? StepLog(dateId: _todayId, count: 0);

      final updatedLog = StepLog(
          dateId: _todayId,
          count: currentLog.count + stepsToAdd,
          target: currentLog.target,
      );
      await box.put(_todayId, updatedLog);
      return updatedLog;
    });
  }

}

//This is the actual provider being read
final dailyStepsNotifierProvider = AsyncNotifierProvider<DailyStepsNotifier, StepLog>(() {
  return DailyStepsNotifier();
});