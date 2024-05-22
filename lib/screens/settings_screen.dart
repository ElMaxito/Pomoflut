import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final timerModel = timerProvider.timerModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Focus Duration: ${timerModel.workDuration} minutes'),
            Slider(
              value: timerModel.workDuration.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: timerModel.workDuration.toString(),
              onChanged: (value) {
                timerProvider.updateDurations(
                  work: value.toInt(),
                  shortBreak: timerModel.shortBreakDuration,
                  longBreak: timerModel.longBreakDuration,
                );
              },
            ),
            Text('Short Break: ${timerModel.shortBreakDuration} minutes'),
            Slider(
              value: timerModel.shortBreakDuration.toDouble(),
              min: 1,
              max: 15,
              divisions: 14,
              label: timerModel.shortBreakDuration.toString(),
              onChanged: (value) {
                timerProvider.updateDurations(
                  work: timerModel.workDuration,
                  shortBreak: value.toInt(),
                  longBreak: timerModel.longBreakDuration,
                );
              },
            ),
            Text('Long Break: ${timerModel.longBreakDuration} minutes'),
            Slider(
              value: timerModel.longBreakDuration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: timerModel.longBreakDuration.toString(),
              onChanged: (value) {
                timerProvider.updateDurations(
                  work: timerModel.workDuration,
                  shortBreak: timerModel.shortBreakDuration,
                  longBreak: value.toInt(),
                );
              },
            ),
            Text('Volume: ${(timerModel.volume * 100).toInt()}%'),
            Slider(
              value: timerModel.volume,
              min: 0,
              max: 1,
              divisions: 10,
              label: (timerModel.volume * 100).toInt().toString(),
              onChanged: (value) {
                timerProvider.updateVolume(value);
              },
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
