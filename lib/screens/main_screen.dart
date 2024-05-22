import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../widgets/custom_progress_indicator.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pomoflut'),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(200, 200),
                    painter: CustomProgressIndicator(
                      progress: (timerProvider.secondsRemaining /
                              (timerProvider.currentPhaseDuration * 60)) *
                          100,
                      color: timerProvider.phaseColor,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${timerProvider.minutes}:${timerProvider.seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 48),
                      ),
                      SizedBox(height: 8),
                      Text(
                        timerProvider.currentPhase == Phase.Focus
                            ? 'Focus'
                            : timerProvider.currentPhase == Phase.ShortBreak
                                ? 'Break'
                                : 'Long Break',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        '${timerProvider.currentCycle} / 4',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
                      size: 32,
                    ),
                    onPressed: () {
                      if (timerProvider.isRunning) {
                        timerProvider.pauseTimer();
                      } else {
                        timerProvider.startTimer();
                      }
                    },
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.stop,
                      size: 32,
                    ),
                    onPressed: () {
                      timerProvider.resetTimer();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
