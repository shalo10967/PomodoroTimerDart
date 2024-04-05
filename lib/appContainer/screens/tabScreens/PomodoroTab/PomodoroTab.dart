import "dart:async";
import "dart:convert";
import "package:intl/intl.dart";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:timepomodoro/appContainer/utils/timersList.dart";
import "package:timepomodoro/appContainer/widgets/ButtonRounded/ButtonRounded.dart";
import "package:timepomodoro/appContainer/widgets/ButtonSquare/ButtonSquare.dart";
import "package:timepomodoro/appContainer/widgets/ClockTimer/ClockTimer.dart";

class PomodoroTabView extends StatefulWidget {
  PomodoroTabView(
      {super.key,
      required this.voidCallback,
      required this.isRunningLongBreak,
      required this.isRunningShortBreak,
      required this.resetCallback});
  final VoidCallback voidCallback;
  final VoidCallback resetCallback;
  bool isRunningLongBreak;
  bool isRunningShortBreak;
  @override
  State<PomodoroTabView> createState() => _PomodoroTabViewState();
}

class _PomodoroTabViewState extends State<PomodoroTabView> {
  int count = 0;
  double defaultValue = pomodoroTimers[0];
  double value = pomodoroTimers[0];
  bool isStarted = false;
  bool isRunning = false;
  int focusedMinutes = 0;
  late Timer timer;
  final dateFormatter = DateFormat('yyyy-MM-dd');
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
    TotalFocused();
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
          focusedMinutes++;
        });
        addFocusTimerNow(focusedMinutes);
        addTotalFocusTimer(focusedMinutes);
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

  Future<void> TotalFocused() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int getValuesFocused = sharedPreferences.getInt('totalFocused') ?? 0;
    int tmpCount = getValuesFocused + 1;
    sharedPreferences.setInt('totalFocused', tmpCount);
  }

  Future<void> TotalFocusedNow() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String now = dateFormatter.format(DateTime.now());
    int getValues = sharedPreferences.getInt(now) ?? 0;
    sharedPreferences.setInt(now, getValues + 1);
  }

  Future<void> addTotalFocusTimer(int focusedMinutes) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int getValues = sharedPreferences.getInt('totalFocus') ?? 0;
    sharedPreferences.setInt('totalFocus', focusedMinutes + getValues);
  }

  Future<void> addFocusTimerNow(int focusedMinutes) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String now = dateFormatter.format(DateTime.now());
    int getValuesFocusedTimes =
        sharedPreferences.getInt('${now}_focused_times') ?? 0;

    sharedPreferences.setInt('${now}_focused_times', getValuesFocusedTimes + 1);
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
            child: Text('Pomodoro Timer',
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
                    buttonText: "25'",
                    onTap: () {
                      setTimersValue(pomodoroTimers[0]);
                    }),
                ButtonSquare(
                    buttonText: "30'",
                    onTap: () {
                      setTimersValue(pomodoroTimers[1]);
                    }),
                ButtonSquare(
                    buttonText: "35'",
                    onTap: () {
                      setTimersValue(pomodoroTimers[2]);
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
                      if (widget.isRunningShortBreak ||
                          widget.isRunningLongBreak) {
                        showAlertDialog(context);
                      } else {
                        if (!isStarted) {
                          TotalFocusedNow();
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
