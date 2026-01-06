import 'dart:async';
import 'package:flutter/material.dart';

enum PomodoroMode { focus, breakTime }

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const int focusTime = 1500; // 25 dakika
  static const int breakTime = 300;  // 5 dakika
  
  int _seconds = focusTime;
  Timer? _timer;
  bool _isRunning = false;
  
  PomodoroMode _currentMode = PomodoroMode.focus;

  void _startTimer() {
    if (_isRunning) return;

    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        _handleTimerFinished(); 
      }
    });
  }

  void _handleTimerFinished() {
    setState(() {
      _isRunning = false;
      if (_currentMode == PomodoroMode.focus) {
        _currentMode = PomodoroMode.breakTime;
        _seconds = breakTime;
        _showFinishedDialog("Çalışma Bitti!", "Şimdi 5 dakikalık bir mola zamani");
      } else {
        _currentMode = PomodoroMode.focus;
        _seconds = focusTime;
        _showFinishedDialog("Mola Bitti!", "Tekrar odaklanma zamanı!");
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = (_currentMode == PomodoroMode.focus) ? focusTime : breakTime;
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showFinishedDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Hazırım!")
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Color themeColor = (_currentMode == PomodoroMode.focus) 
        ? const Color.fromARGB(255, 24, 88, 184) 
        : const Color.fromARGB(255, 116, 172, 255);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      appBar: AppBar(
        title: Text(
          _currentMode == PomodoroMode.focus ? "Focus Time" : "Break Time", 
          style: const TextStyle(color: Colors.white)
        ),
        backgroundColor: themeColor,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentMode == PomodoroMode.focus ? "Focus Time" : "Break time",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: themeColor),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _seconds / (_currentMode == PomodoroMode.focus ? focusTime : breakTime),
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                Text(
                  _formatTime(_seconds),
                  style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  icon: _isRunning ? Icons.pause : Icons.play_arrow,
                  label: _isRunning ? "Durdur" : "Başlat",
                  color: _isRunning ? Colors.orange : themeColor,
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  onPressed: _resetTimer,
                  icon: Icons.refresh,
                  label: "Sıfırla",
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required VoidCallback onPressed, required IconData icon, required String label, required Color color}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}