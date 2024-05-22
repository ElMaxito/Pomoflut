import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/timer_model.dart';

class TimerProvider with ChangeNotifier {
  TimerModel _timerModel = TimerModel(workDuration: 25, shortBreakDuration: 5, longBreakDuration: 15);
  bool isRunning = false;
  Timer? _timer;
  int _secondsRemaining = 25 * 60;
  Phase _currentPhase = Phase.Focus;
  int _currentCycle = 1;
  final AudioCache _audioCache = AudioCache(prefix: 'assets/sounds/');

  TimerProvider() {
    _audioCache.load('beep.mp3');
  }

  TimerModel get timerModel => _timerModel;

  int get secondsRemaining => _secondsRemaining;

  Phase get currentPhase => _currentPhase;

  int get currentCycle => _currentCycle;

  int get currentPhaseDuration {
    switch (_currentPhase) {
      case Phase.Focus:
        return _timerModel.workDuration;
      case Phase.ShortBreak:
        return _timerModel.shortBreakDuration;
      case Phase.LongBreak:
        return _timerModel.longBreakDuration;
      default:
        return _timerModel.workDuration;
    }
  }

  Color get phaseColor {
    switch (_currentPhase) {
      case Phase.Focus:
        return Colors.green;
      case Phase.ShortBreak:
        return Colors.orange;
      case Phase.LongBreak:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  int get minutes => _secondsRemaining ~/ 60;
  int get seconds => _secondsRemaining % 60;

  void _playSound() {
    _audioCache.play('beep.mp3');
  }

  void updateDurations({required int work, required int shortBreak, required int longBreak}) {
    _timerModel.workDuration = work;
    _timerModel.shortBreakDuration = shortBreak;
    _timerModel.longBreakDuration = longBreak;
    _secondsRemaining = _currentPhase == Phase.Focus ? work * 60 : _secondsRemaining;
    notifyListeners();
  }

  void incrementPomodoros() {
    _timerModel.completedPomodoros++;
    _currentCycle = (_timerModel.completedPomodoros % 4) + 1;
    notifyListeners();
  }

  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          _timer?.cancel();
          _playSound();
          Future.delayed(Duration(milliseconds: 500), () {
            isRunning = false;
            _switchPhase();
            startTimer();  // Automatically start the next phase
          });
        }
      });
    }
  }

  void pauseTimer() {
    if (isRunning) {
      _timer?.cancel();
      isRunning = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning = false;
    _secondsRemaining = _timerModel.workDuration * 60;
    _currentPhase = Phase.Focus;
    _currentCycle = 1;
    _timerModel.completedPomodoros = 0;
    notifyListeners();
  }

  void _switchPhase() {
    switch (_currentPhase) {
      case Phase.Focus:
        _currentPhase = (_currentCycle == 4) ? Phase.LongBreak : Phase.ShortBreak;
        break;
      case Phase.ShortBreak:
      case Phase.LongBreak:
        _currentPhase = Phase.Focus;
        incrementPomodoros();
        break;
    }
    resetPhaseTimer();  // Ensure the timer is reset for the new phase
  }

  void resetPhaseTimer() {
    _secondsRemaining = currentPhaseDuration * 60;
    notifyListeners();
  }
}

enum Phase {
  Focus,
  ShortBreak,
  LongBreak,
}
