import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = const Duration();

  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (countDown) {
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter StopWatch Timer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTime(),
            const SizedBox(
              height: 80,
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeCard(
          time: hours,
          header: 'HOURS',
        ),
        const SizedBox(
          width: 8,
        ),
        _buildTimeCard(
          time: minutes,
          header: 'MINUTES',
        ),
        const SizedBox(
          width: 8,
        ),
        _buildTimeCard(
          time: seconds,
          header: 'SECONDS',
        ),
      ],
    );
  }

  Widget _buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            header,
            style: const TextStyle(
              color: Colors.black45,
            ),
          ),
        ],
      );

  Widget _buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Stop',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(resets: false);
                  }
                },
              ),
              const SizedBox(
                width: 12,
              ),
              ButtonWidget(
                text: 'Cencel',
                onClicked: stopTimer,
              )
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            onClicked: () {
              startTimer();
            });
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.backgroundColor = Colors.black,
    required this.onClicked,
  });
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: color,
        ),
      ),
    );
  }
}
