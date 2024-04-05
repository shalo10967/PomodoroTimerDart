import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:timepomodoro/appContainer/utils/timersList.dart";
import "package:timepomodoro/appContainer/widgets/ButtonRounded/ButtonRounded.dart";
import "package:timepomodoro/appContainer/widgets/ButtonSquare/ButtonSquare.dart";
import "package:timepomodoro/appContainer/widgets/ClockTimer/ClockTimer.dart";

class ShortBreakTabView extends StatefulWidget {
  ShortBreakTabView(
      {super.key,
      required this.voidCallback,
      required this.isRunningLongBreak,
      required this.isRunningPomodoro,
      required this.resetCallback});
  final VoidCallback voidCallback;
  final VoidCallback resetCallback;
  bool isRunningLongBreak;
  bool isRunningPomodoro;

  @override
  State<ShortBreakTabView> createState() => _ShortBreakTabViewState();
}

class _ShortBreakTabViewState extends State<ShortBreakTabView> {
  int count = 0;
  double defaultValue = shortBreakTimers[0];
  double value = shortBreakTimers[0];
  bool isStarted = false;
  bool isRunning = false;
  int focusedMinutes = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.orangeAccent));
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            content: const Text('No puedes iniciar otro cronometro',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //controller.index = controller.previousIndex;
                  },
                  child: const Text('Ok',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)))
            ],
          );
        });
  }

  void startTime() {
    focusedMinutes = value.toInt();
    addBreaksTimerToSF();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (value <= 1) {
        setState(() {
          timer.cancel();
          value = defaultValue;
          isRunning = false;
          isStarted = false;
        });
      } else {
        setState(() {
          value--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setTimersValue(double duration) {
    setState(() {
      value = duration;
      defaultValue = duration;
    });
  }

  void resetTimer() {
    widget.resetCallback();
    setState(() {
      timer.cancel();
      value = defaultValue;
      isStarted = false;
      isRunning = false;
    });
  }

  Future<void> addBreaksTimerToSF() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int getValues = sharedPreferences.getInt('breaks') ?? 0;
    int tmpCount = getValues + 1;
    sharedPreferences.setInt('breaks', tmpCount);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Center(
            child: Text('Short Break Timer',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  ClockTimer(value: value, defaultValue: defaultValue)
                ],
              ),
            ),
          ),
          if (!isRunning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonSquare(
                    buttonText: "5'",
                    onTap: () {
                      setTimersValue(shortBreakTimers[0]);
                    }),
                ButtonSquare(
                    buttonText: "10'",
                    onTap: () {
                      setTimersValue(shortBreakTimers[1]);
                    }),
                ButtonSquare(
                    buttonText: "15'",
                    onTap: () {
                      setTimersValue(shortBreakTimers[2]);
                    })
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonRounded(
                  buttonIcon: isStarted ? Icons.pause : Icons.play_arrow,
                  onTap: () {
                    setState(() {
                      if (widget.isRunningPomodoro ||
                          widget.isRunningLongBreak) {
                        showAlertDialog(context);
                      } else {
                        if (!isStarted) {
                          isStarted = true;
                          isRunning = true;
                          startTime();
                          widget.voidCallback();
                        } else {
                          timer.cancel();
                          isStarted = false;
                          widget.voidCallback();
                        }
                      }
                    });
                  }),
              if (isRunning)
                ButtonRounded(buttonIcon: Icons.stop, onTap: resetTimer),
            ],
          ),
        ],
      ),
    );
  }
}
