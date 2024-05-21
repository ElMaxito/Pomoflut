// lib/models/timer_model.dart
class TimerModel {
  int workDuration;
  int shortBreakDuration;
  int longBreakDuration;
  int completedPomodoros;

  TimerModel({
    this.workDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
    this.completedPomodoros = 0,
  });
}
