import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timepomodoro/appContainer/screens/tabScreens/LongBreak/LongBreak.dart';
import 'package:timepomodoro/appContainer/screens/tabScreens/PomodoroTab/PomodoroTab.dart';
import 'package:timepomodoro/appContainer/screens/tabScreens/ShortBreak/ShortBreakTab.dart';
import 'package:timepomodoro/appContainer/widgets/ButtonSquare/ButtonSquare.dart';
import 'package:timepomodoro/appContainer/widgets/State/KeepPageAlive.dart';

class TabsNavigation extends StatefulWidget {
  const TabsNavigation({super.key});

  @override
  State<TabsNavigation> createState() => _TabsNavigationState();
}

class _TabsNavigationState extends State<TabsNavigation>
    with SingleTickerProviderStateMixin {
  bool isRunningPomodoro = false;
  bool isRunningShortBreak = false;
  bool isRunningLongBreak = false;
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final tabScreens = [
      KeepPageAlive(
          child: PomodoroTabView(
              isRunningShortBreak: isRunningShortBreak,
              isRunningLongBreak: isRunningLongBreak,
              voidCallback: () {
                setState(() {
                  isRunningPomodoro = true;
                });
              },
              resetCallback: () {
                setState(() {
                  isRunningPomodoro = false;
                });
              })),
      KeepPageAlive(
          child: ShortBreakTabView(
              isRunningPomodoro: isRunningPomodoro,
              isRunningLongBreak: isRunningLongBreak,
              voidCallback: () {
                setState(() {
                  isRunningShortBreak = true;
                });
              },
              resetCallback: () {
                setState(() {
                  isRunningShortBreak = false;
                });
              })),
      KeepPageAlive(
          child: LongBreakTabView(
              isRunningPomodoro: isRunningPomodoro,
              isRunningShortBreak: isRunningShortBreak,
              voidCallback: () {
                setState(() {
                  isRunningLongBreak = true;
                });
              },
              resetCallback: () {
                setState(() {
                  isRunningLongBreak = false;
                });
              }))
    ];

    return DefaultTabController(
        length: 3,
        child: Builder(
          builder: ((context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Pomodoro',
                    ),
                    Tab(
                      text: 'Short Break',
                    ),
                    Tab(
                      text: 'Long Break',
                    )
                  ],
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orangeAccent,
                ),
              ),
              body: TabBarView(
                children: tabScreens,
              ),
            );
          }),
        ));
  }
}
