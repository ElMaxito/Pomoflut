class TimerModel {
  int workDuration;
  int shortBreakDuration;
  int longBreakDuration;
  int completedPomodoros;
  double volume;

  TimerModel({
    this.workDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
    this.completedPomodoros = 0,
    this.volume = 1.0,  // Default volume
  });
}
